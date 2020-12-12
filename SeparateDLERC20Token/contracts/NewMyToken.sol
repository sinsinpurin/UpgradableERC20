// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./logic/LogicERC20.sol";
import "./utils/Initializable.sol";

contract NewMyToken is LogicERC20, Initializable{
    // ERC20の初期値
    string private constant _name = "ERC20Token";
    string private constant _symbol = "ERC20Token";
    uint256 private constant _initial_supply = 1000000;

    address public _storageERC20Address;

    // MyTokenとERC20の初期化
    constructor (address storageERC20Address) LogicERC20(storageERC20Address){
        _storageERC20Address = storageERC20Address;
    }

    using SafeMath for uint256;

    // Fix Function
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        IStorageERC20(_storageERC20Address).setBalanceOf(sender, IStorageERC20(_storageERC20Address).getBalanceOf(sender).sub(
            amount,
            "ERC20: transfer amount exceeds balance"
        ));
        IStorageERC20(_storageERC20Address).setBalanceOf(recipient, _storageERC20.getBalanceOf(recipient).add(amount));
        emit Transfer(sender, recipient, amount);
    }

    // New Event
    event Airdrop(address account, uint256 amount);

    // New Function
    function airdrop(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
        emit Airdrop(account, amount);
    }
}
