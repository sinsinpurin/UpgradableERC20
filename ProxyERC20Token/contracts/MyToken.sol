// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./ERC20.sol";

contract MyToken is ERC20{
    // ERC20の初期値
    // to private
    string private _name;
    string private _symbol;
    uint256 private _initial_supply;

    // MyTokenとERC20の初期化
    function initMyToken() public initializer{
        _name = "ERC20Token";
        _symbol = "ERC20Token";
        _initial_supply = 1000000;
        Ownable.initOwnable();
        ERC20.initERC20(_name, _symbol);
        _mint(Ownable.getOwner(), _initial_supply);
    }
}
