// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./Ownable.sol";

contract Accessible is Ownable {
    address private _AccessAddress;

    event AccessTransferred(
        address previousAccessAddress,
        address newAccessAddress
    );

    function getAccessAddress() public view returns (address) {
        return _AccessAddress;
    }

    modifier canAccess() {
        require(
            _AccessAddress == msg.sender,
            "Accessible: caller is not the owner"
        );
        _;
    }

    function changeAccessAddress(address newAccessAddress) public onlyOwner {
        require(
            newAccessAddress != address(0),
            "Accessible: newAccess is zero address"
        );
        emit AccessTransferred(_AccessAddress, newAccessAddress);
        _AccessAddress = newAccessAddress;
    }
}
