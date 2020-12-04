// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./Initializable.sol";

contract ProxyOwnable is Initializable{
    address private _owner;

    event OwnershipTransferred(address previousOwner, address newOwner);

    // _ownerの初期化
    constructor() {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function getProxyOwner() public view returns(address){
        return _owner;
    }

    // 
    modifier onlyProxyOwner(){
        require(_owner == msg.sender,"Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyProxyOwner{
        require(newOwner != address(0), "Ownable: newOwner is zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
