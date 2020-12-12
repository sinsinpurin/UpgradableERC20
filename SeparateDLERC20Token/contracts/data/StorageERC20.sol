// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "../utils/Accessible.sol";

contract StorageERC20 is Accessible{

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name, string memory symbol){
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }

    function getName() public view returns (string memory) {
        return _name;
    }

    function getSymbol() public view returns (string memory) {
        return _symbol;
    }

    function getDecimals() public view returns (uint8) {
        return _decimals;
    }

    function getTotalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function setTotalSupply(uint amount) public canAccess{
        _totalSupply = amount;
    }

// balance
    function getBalanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function setBalanceOf(address account, uint amount) public canAccess {
        _balances[account] = amount;
    }

// allowance
    function getAllowance(address owner,address spender) public view canAccess returns(uint){
        return _allowances[owner][spender];
    }

    function setAllowance(address owner, address spender, uint amount) public canAccess{
        _allowances[owner][spender] = amount;
    }
}
