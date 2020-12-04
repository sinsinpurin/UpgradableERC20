const MyToken = artifacts.require("MyToken")
const StorageERC20 = artifacts.require("StorageERC20")

module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(StorageERC20, "UpgradableERC20", "UT").then(
    function () {
      return _deployer.deploy(MyToken, StorageERC20.address)
    }
  )
};
