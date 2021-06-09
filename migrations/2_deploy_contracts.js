var TitanFinanceToken = artifacts.require("./TitanFinanceToken.sol");

module.exports = function (deployer) {
  deployer.deploy(TitanFinanceToken);
};
