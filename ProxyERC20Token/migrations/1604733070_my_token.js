const MyToken = artifacts.require("MyToken")
const Proxy = artifacts.require("Proxy")

module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(MyToken)
  _deployer.deploy(Proxy)
};
