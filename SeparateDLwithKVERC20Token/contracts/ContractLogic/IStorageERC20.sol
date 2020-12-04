// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

interface IStorageERC20 {
    function getName() external view returns (string memory);

    function getSymbol() external view returns (string memory);

    function getDecimals() external view returns (uint8);

    function getTotalSupply() external view returns (uint256);

    function setTotalSupply(uint256 amount) external;

    // balance
    function getBalanceOf(address account) external view returns (uint256);

    function setBalanceOf(address account, uint256 amount) external;

    // allowance
    function getAllowance(address owner, address spender)
        external
        view
        returns (uint256);

    function setAllowance(
        address owner,
        address spender,
        uint256 amount
    ) external;
}
