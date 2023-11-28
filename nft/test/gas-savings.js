const { ethers } = require("hardhat");
const { expect } = require("chai");

const MAX_BATCH_SIZE = 5;
const ERC_1155 = "MyErc1155";

describe("OpenZeppelin ERC721Enumerable", function () {
  const ercStandard = "StandardErc721";

  it(`can batch mint`, async function () {
    await MintFromContractWithBatchFunction(ercStandard);
  });

  it(`Try mint more then maxBatchSize`, async function () {
    await MintOverMaxBatchSize(ercStandard);
  });

  it(`Transfer token after minting a batch of NFTs`, async function () {
    await MintAndTransferFromContractWithBatchFunction(ercStandard);
  });
});

describe("Azuki ERC721A", async function () {
  const ercStandard = "Erc721Azuki";

  it(`can batch mint`, async function () {
    await MintFromContractWithBatchFunction(ercStandard);
  });

  it(`Try mint more then maxBatchSize`, async function () {
    await MintOverMaxBatchSize(ercStandard);
  });

  it(`Transfer token after minting a batch of NFTs`, async function () {
    await MintAndTransferFromContractWithBatchFunction(ercStandard);
  });
});

describe("Tiny ERC721", async function () {
  const ercStandard = "TinyErc721";

  it(`can batch mint`, async function () {
    await MintFromContractWithBatchFunction(ercStandard);
  });

  //Bug in Implementation of TinyErc721 therefore cannot run
  /*it(`Try mint more then maxBatchSize`, async function () {
    await MintOverMaxBatchSize(ercStandard);
  });*/

  it(`Transfer token after minting a batch of NFTs`, async function () {
    await MintAndTransferFromContractWithBatchFunction(ercStandard);
  });
});

describe("ERC 1155", async function () {
  it(`can batch mint`, async function () {
    await MintFromContractWithBatchFunction(ERC_1155);
  });
  it(`Try mint more then maxBatchSize`, async function () {
    await MintOverMaxBatchSize(ERC_1155);
  });

  it(`Transfer token after minting a batch of NFTs`, async function () {
    await MintAndTransferFromContractWithBatchFunction(ERC_1155);
  });
});

const MintFromContractWithBatchFunction = async (contract) => {
  for (var i = 1; i <= MAX_BATCH_SIZE; i++) {
    const deployedContract = await initializeContract(contract, MAX_BATCH_SIZE);

    const [_, mintAddress] = await ethers.getSigners(); // create a user wallet.

    if (contract === ERC_1155) {
      await mintAndLogGasErc1155(deployedContract, mintAddress, i);
    } else {
      await mintAndLogGas(deployedContract, mintAddress, i);
    }
  }
};

const MintAndTransferFromContractWithBatchFunction = async (contract) => {
  for (var i = 1; i < 6; i++) {
    for (var n = i - 1; n > -1; n--) {
      const deployedContract = await initializeContract(contract, MAX_BATCH_SIZE);

      const [_, addr1] = await ethers.getSigners();

    if (contract === ERC_1155) {
      await mintAndTransferErc1155(deployedContract, addr1, i, 1);
    } else {
      await mintAndTransfer(deployedContract, addr1, i, n);
    }
    }
  }
};

const MintOverMaxBatchSize = async (contract) => {
  const deployedContract = await initializeContract(contract, MAX_BATCH_SIZE);
  const [_, mintAddress] = await ethers.getSigners();

  let assertionError = false;
  try {
    if (contract === ERC_1155) {
      await mintAndLogGasErc1155(
        deployedContract,
        mintAddress,
        2 * MAX_BATCH_SIZE
      );
    } else {
      await await mintAndLogGas(
        deployedContract,
        mintAddress,
        2 * MAX_BATCH_SIZE
      );
    }
  } catch (AssertionError) {
    assertionError = true;
  } finally {
    expect(assertionError).to.be.true;
  }
};

const initializeContract = async (contract, maxBatchSize) => {
  const NFTStandard = await ethers.getContractFactory(contract);
  const deployedContract = await NFTStandard.deploy(maxBatchSize);

  return deployedContract;
};

/** Mint with different batch sizes and log costs */
const mintAndLogGas = async (contract, account, quantity) => {
  const mint = await contract.connect(account).mint(account.address, quantity);
  const mintTransactionResponse = await mint.wait();
  console.log(
    `\tGas cost for minting ${quantity}:`,
    mintTransactionResponse.gasUsed.toString()
  );
};

const mintAndLogGasErc1155 = async (contract, account, quantity) => {
  const mint = await contract
    .connect(account)
    .mint(account.address, 1, quantity, []);
  const mintTransactionResponse = await mint.wait();
  console.log(
    `\tGas cost for minting ${quantity}:`,
    mintTransactionResponse.gasUsed.toString()
  );
};

/** Mint NFTS and transfer them to other accounts */
const mintAndTransferErc1155 = async (contract, account, quantity, tokenId) => {
  const mintTx = await contract
    .connect(account)
    .mint(account.address, 1, quantity, []);
  await mintTx.wait();

  const transferTx = await contract
    .connect(account)
    ["safeTransferFrom(address,address,uint256,uint256,bytes)"](
      account.address,
      "0x000000000000000000000000000000000000dEaD",
      tokenId,
      1,
    []
    );
  const transferReceipt = await transferTx.wait();
  console.log(
    `\tMinted ${quantity}, transferred Token with id: ${tokenId}, cost: ${transferReceipt.gasUsed.toString()}`
  );
};

/** Mint NFTS and transfer them to other accounts */
const mintAndTransfer = async (contract, account, quantity, tokenId) => {
  const mintTx = await contract
    .connect(account)
    .mint(account.address, quantity);
  await mintTx.wait();

  const transferTx = await contract
    .connect(account)
    ["safeTransferFrom(address,address,uint256)"](
      account.address,
      "0x000000000000000000000000000000000000dEaD",
      tokenId
    );
  const transferReceipt = await transferTx.wait();
  console.log(
    `\tMinted ${quantity}, transferred Token with id: ${tokenId}, cost: ${transferReceipt.gasUsed.toString()}`
  );
};
