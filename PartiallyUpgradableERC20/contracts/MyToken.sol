// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./Token/ERC20.sol";

contract MyToken is ERC20 {
    // ERC20の初期値
    string private constant _name = "ERC20Token";
    string private constant _symbol = "ERC20Token";
    uint256 private constant _initial_supply = 1000000;

    // 作成者アドレス
    address private _owner;

    // MyTokenとERC20の初期化
    constructor () ERC20(_name,_symbol){
        _owner = msg.sender;
        _mint(_owner, _initial_supply);
    }
}
