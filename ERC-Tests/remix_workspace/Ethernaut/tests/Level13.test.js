// Right click on the script name and hit "Run" to execute
const {expect} = require('chai')
const {ethers} = require('hardhat')

describe('Storage', function () {
    it('test initial value', async function () {
        
    const keeperContract = await ethers.getContractFactory("GatekeeperOne");
    const keeper = await keeperContract.deploy();
    await keeper.deployed();

    //bytes8 key = bytes8(0x6fea151248f89dbaa5c37b2ab0135bbff92bac17) & 0xFFFFFFFF0000FFFF;
    
    for(i = 0; i < 8191; i++) {
        try {
            keeper.enter(keeper.address,  )
        } catch (error){}
    }
            console.log(`${i} success`)


    })
})

 require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        
        

      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part
