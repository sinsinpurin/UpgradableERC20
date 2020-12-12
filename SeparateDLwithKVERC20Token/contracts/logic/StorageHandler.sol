// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "../data/Storage.sol";


contract StorageHandler{

    Storage internal _storageERC20;

    constructor(address storageERC20Address){
        _storageERC20 = Storage(storageERC20Address);
    }

    ///  getter   ///

    function getName() internal view returns (string memory){
        return _storageERC20.getString(keccak256("name"));
    }

    function getSymbol() internal view returns (string memory) {
        return _storageERC20.getString(keccak256("symbol"));
    }

    function getDecimals() internal view returns (uint8) {
        return uint8(_storageERC20.getUint(keccak256("decimals")));
    }

    function getTotalSupply() internal view returns (uint256) {
        return _storageERC20.getUint(keccak256("totalSupply"));
    }

    function getBalanceOf(address account) internal view returns (uint256) {
        return _storageERC20.getUint(keccak256(abi.encodePacked("balances", account)));
    }

    function getAllowance(address owner, address spender) internal view returns(uint256){
        _storageERC20.getUint(keccak256(abi.encodePacked("allowance",owner, spender)));
    }

    ///   setter   ///

    function setName(string memory name)internal {
        _storageERC20.setString(keccak256("name"), name);
    }

    function setSymbol(string memory symbol)internal{
        _storageERC20.setString(keccak256("symbol"), symbol);
    }

    function setDecimals(uint8 decimals)internal{
        _storageERC20.setUint(keccak256("decimals"), uint256(decimals));
    }

    function setTotalSupply(uint256 amount) internal{
        _storageERC20.setUint(keccak256(abi.encodePacked("totalSupply")), amount);
    }

    function setBalances(address sender, uint256 amount) internal {
        _storageERC20.setUint(keccak256(abi.encodePacked("balances",sender)), amount);
    }

    function setAllowance(address owner, address spender, uint256 amount)internal{
        _storageERC20.setUint(keccak256(abi.encodePacked("allowances",owner, spender)), amount);
    }
}