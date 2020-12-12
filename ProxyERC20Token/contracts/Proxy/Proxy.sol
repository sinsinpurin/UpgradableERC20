// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./ProxyOwnable.sol";

/**
 * @title Proxy
 */
contract Proxy is ProxyOwnable {
    address private implementation;

    function targetAddress() public view returns (address) {
        return implementation;
    }

    /**
     * @dev ロジックコントラクトのアドレスアドレスの設定
     */
    function upgradeTo(address _address) public onlyProxyOwner {
        implementation = _address;
    }

    fallback() external payable {
        _delegate();
    }

    receive() external payable {
        _delegate();
    }

    /**
     * @dev Fallback関数 ロジックコントラクトのdelegatecall()を実行する
     */
    function _delegate() internal {
        // ロジックコントラクトのアドレス
        address _impl = implementation;
        require(_impl != address(0));
        assembly {
              let ptr := mload(0x40)
            
              // (1) copy incoming call data
              calldatacopy(ptr, 0, calldatasize())
            
              // (2) forward call to logic contract
              let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
              let size := returndatasize()
            
              // (3) retrieve return data
              returndatacopy(ptr, 0, size)
            
              // (4) forward return data back to caller
              switch result
              case 0 { revert(ptr, size) }
              default { return(ptr, size) }
        }
    }
}
