// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "../token/IERC20.sol";
import "../utils/SafeMath.sol";
import "../data/IStorageERC20.sol";

contract LogicERC20 is IERC20{
    using SafeMath for uint256;

    IStorageERC20 private _storageERC20;

    constructor(address storageERC20Address){
        _storageERC20 = IStorageERC20(storageERC20Address);
    }

    function name() public view returns (string memory) {
        return _storageERC20.getName();
    }

    function symbol() public view returns (string memory) {
        return _storageERC20.getSymbol();
    }

    function decimals() public view returns (uint8) {
        return _storageERC20.getDecimals();
    }

    function totalSupply() public override view returns (uint256) {
        return _storageERC20.getTotalSupply();
    }

    function balanceOf(address account) public override view returns (uint256) {
        return _storageERC20.getBalanceOf(account);
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
        return _storageERC20.getAllowance(owner, spender);
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
            _storageERC20.getAllowance(sender, msg.sender).sub(
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
            _storageERC20.getAllowance(msg.sender, spender).add(addedValue)
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
            _storageERC20.getAllowance(msg.sender, spender).sub(
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
        _storageERC20.setBalanceOf(sender, _storageERC20.getBalanceOf(sender).sub(
            amount,
            "ERC20: transfer amount exceeds balance"
        ));
        _storageERC20.setBalanceOf(recipient, _storageERC20.getBalanceOf(recipient).add(amount));
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _storageERC20.setTotalSupply(_storageERC20.getTotalSupply());

        _storageERC20.setBalanceOf(account, _storageERC20.getBalanceOf(account).add(amount));
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _storageERC20.setBalanceOf(account, _storageERC20.getBalanceOf(account).sub(
            amount,
            "ERC20: burn amount exceeds balance"
            ));
        _storageERC20.setTotalSupply(_storageERC20.getTotalSupply().sub(amount));
        emit Transfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        
        _storageERC20.setAllowance(owner, spender, amount);

        emit Approval(owner, spender, amount);
    }
}
