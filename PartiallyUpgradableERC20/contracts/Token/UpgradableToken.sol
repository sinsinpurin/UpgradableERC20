// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

abstract contract UpgradableToken {
    function UpgradedTransfer(
        address sender,
        address recipient,
        uint256 amount
    ) public {}

    function UpgradedApprove() public {}

    function UpgradedMint(address account, uint256 amount) public {}

    function UpgradedBurn(address account, uint256 amount) public {}
}
