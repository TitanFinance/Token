const TitanFinanceToken = artifacts.require("TitanFinanceToken");
const BigNumber = require('bignumber.js');

contract("TitanFinanceToken", async (accounts) => {
    const deployer = accounts[0];
    let instance;

    before(async () => {
        instance = await TitanFinanceToken.new({ from: deployer });
    });

    describe("Token", () => {
        it("deploy", async () => {
            const balance = new BigNumber(await instance.balanceOf(deployer));
            const totalSupply = new BigNumber(await instance.totalSupply());
            assert.equal(balance.toString(10), "100000000000000000000");
            assert.equal(totalSupply.toString(10), "100000000000000000000");
        });
        it("send fee", async () => {
            await instance.transfer(accounts[1], "50000000000000000000", { from: deployer });
            let balance = new BigNumber(await instance.balanceOf(deployer));
            let balance1 = new BigNumber(await instance.balanceOf(accounts[1]));
            assert.equal(balance.toString(10), "50000000000000000000");
            assert.equal(balance1.toString(10), "50000000000000000000");

            await instance.transfer(accounts[2], "1000000000000000000", { from: accounts[1] });
            balance = new BigNumber(await instance.balanceOf(deployer));
            balance1 = new BigNumber(await instance.balanceOf(accounts[1]));
            let balance2 = new BigNumber(await instance.balanceOf(accounts[2]));
            assert.equal(balance.toString(10), "50015004501350405121");
            assert.equal(balance1.toString(10), "49014704411323397019");
            assert.equal(balance2.toString(10), "950285085525657697");
        });
    });
});