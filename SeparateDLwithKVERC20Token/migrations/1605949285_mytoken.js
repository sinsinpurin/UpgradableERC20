const MyToken = artifacts.require("MyToken")
const Storage = artifacts.require("Storage")

module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(Storage).then(
    function () {
      return _deployer.deploy(MyToken, Storage.address)
    }
  )
};
