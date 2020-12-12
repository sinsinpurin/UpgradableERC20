// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./logic/LogicERC20.sol";
import "./utils/Initializable.sol";

contract MyToken is LogicERC20, Initializable{
    // ERC20の初期値
    string private constant _name = "ERC20Token";
    string private constant _symbol = "ERC20Token";
    uint8 private constant _decimals = 18;
    uint256 private constant _initial_supply = 1000000;

    // 作成者アドレス
    address private _owner;
    address public _storageERC20Address;

    // MyTokenとERC20の初期化
    constructor (address storageERC20Address) LogicERC20(storageERC20Address){
        _storageERC20Address = storageERC20Address;
    }
    
    function initMyToken() public initializer{
        setName(_name);
        setSymbol(_symbol);
        setDecimals(_decimals);
        _owner = msg.sender;
        _mint(_owner, _initial_supply);
    }
}
