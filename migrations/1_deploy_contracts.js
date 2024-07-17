const Contacts = artifacts.require("PasswordManager.sol");

module.exports = function(deployer) {
  deployer.deploy(Contacts);
  
};