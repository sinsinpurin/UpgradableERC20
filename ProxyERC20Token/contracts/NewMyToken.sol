// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./token/ERC20.sol";
import "./utils/SafeMath.sol";

contract NewMyToken is ERC20 {
    // ERC20の初期値
    // to private
    string private _name;
    string private _symbol;
    uint256 private _initial_supply;

    function initMyToken() public initializer {}

    ///   Upgrade   ///

    using SafeMath for uint256;

    // Fix Function
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(
            amount,
            "ERC20: transfer amount exceeds balance"
        );
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /**
     * @dev Add New Variable. Airdrop Amount
     */
    mapping(address => uint256) private airdropAmounts;

    // Add Event
    event Airdrop(address account, uint256 amount);

    // Add New Function
    function getAirdropAmount(address account) public view returns (uint256) {
        return airdropAmounts[account];
    }

    function airdrop(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
        airdropAmounts[account] = airdropAmounts[account].add(amount);
        emit Airdrop(account, amount);
    }
}
