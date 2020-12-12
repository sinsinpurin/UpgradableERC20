// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./Token/ERC20.sol";

contract MyTokenV2 is ERC20 {
    // ERC20の初期値
    string private constant _name = "ERC20Token";
    string private constant _symbol = "ERC20Token";
    uint256 private constant _initial_supply = 1000000;

    using SafeMath for uint256;

    // MyTokenとERC20の初期化
    constructor () ERC20(_name,_symbol){}

    //uint256 internal tax = 10;

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 amountAndTax = amount.div( 10,"tax : cannot div amount");
        _balances[sender] = _balances[sender].sub(
            amountAndTax,
            "ERC20: transfer amount exceeds balance"
        );
        _balances[recipient] = _balances[recipient].add(amountAndTax);
        emit Transfer(sender, recipient, amount);
    }
}
