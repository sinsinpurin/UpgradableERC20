// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./Initializable.sol";

contract Ownable is Initializable {
    address private _owner;

    event OwnershipTransferred(address previousOwner, address newOwner);

    // _ownerの初期化
    function initOwnable() internal initializer{
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function getOwner() public view returns (address) {
        return _owner;
    }

    //
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: newOwner is zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
