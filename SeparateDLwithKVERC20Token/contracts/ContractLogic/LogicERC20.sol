// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./IERC20.sol";
import "../utils/SafeMath.sol";
import "./StorageHandler.sol";

contract LogicERC20 is IERC20, StorageHandler {
    using SafeMath for uint256;

    ///  variable   ///
    constructor(address StrorageERC20Address)StorageHandler(StrorageERC20Address){}

    function name() public view returns (string memory) {
        return getName();
    }

    function symbol() public view returns (string memory) {
        return getSymbol();
    }

    function decimals() public view returns (uint8) {
        return getDecimals();
    }

    function totalSupply() public override view returns (uint256) {
        return getTotalSupply();
    }

    function balanceOf(address account) public override view returns (uint256) {
        return getBalanceOf(account);
    }

    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        public
        virtual
        override
        view
        returns (uint256)
    {
        return getAllowance(owner, spender);
    }

    function approve(address spender, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            allowance(sender, msg.sender).sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
            allowance(msg.sender, spender).add(addedValue)
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
            allowance(msg.sender, spender).sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        setBalances(
            sender,
            balanceOf(sender).sub(
                amount,
                "ERC20: transfer amount exceeds balance"
            )
        );

        setBalances(recipient, balanceOf(recipient).add(amount));

        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        setTotalSupply(amount);
        setBalances(account, balanceOf(account).add(amount));

        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        setBalances(
            account,
            balanceOf(account).sub(amount, "ERC20: burn amount exceeds balance")
        );

        setTotalSupply(totalSupply().sub(amount));

        emit Transfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        setAllowance(owner, spender, amount);

        emit Approval(owner, spender, amount);
    }
}
