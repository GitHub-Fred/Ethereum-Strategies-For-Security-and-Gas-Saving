const { ethers } = require("hardhat");
const fs = require("fs");
const path = require("path");

const akuArguments = [
  "0x6feA151248f89dbaA5c37b2Ab0135BbfF92bAC17",
  100000000000000,
  0,
  0
];

describe("Test Akutar", async function () {
  it(`Deployment costs`, async function () {
    const contracts = await getContracts(
      // { originalContract, auditedContract }
      "Akutar",
      "AkuAuctionAudited",
      ...akuArguments
    );

    compareContracts(
      contracts[0].deployedContractResponse,
      contracts[1].deployedContractResponse
    );

    return;
  });
});

describe("Test NWGs", async function () {
  it(`Deployment costs and changed functions`, async function () {
    const contracts = await getContracts(
      "NewWorldGuardiansNFT",
      "NewWorldGuardiansNFTAudited"
    );

    compareContracts(
      contracts[0].deployedContractResponse,
      contracts[1].deployedContractResponse
    );
    const [owner, address1, address2] = await ethers.getSigners();

    compareTransactionContracts(
      "setDonationRatio",
      await contracts[0].deployedContract.connect(owner).setDonationRatio(100),
      await contracts[1].deployedContract.connect(owner).setDonationRatio(100)
    );
    compareTransactionContracts(
      "setPublicSaleOpen",
      await contracts[0].deployedContract
        .connect(owner)
        .setPublicSaleOpen(true),
      await contracts[1].deployedContract.connect(owner).setPublicSaleOpen(true)
    );
    const weiAmount = ethers.utils.parseEther("0.48");

    compareTransactionContracts(
      "mint",
      await contracts[0].deployedContract
        .connect(address1)
        .mintNFT(address1.address, 3, { value: weiAmount }),
      await contracts[1].deployedContract
        .connect(address2)
        .mintNFT(address2.address, 3, { value: weiAmount })
    );

    return;
  });
}); 

const roadToDreamsArguments = [
  "PRS",
  "PORSCH",
  "0x12",
  0,
  0,
  1,
  1000,
  10,
  5,
  '0xAC24d3090c63285602940C95630811B43411bF67'
];
describe("Test RoadsToDreams", async function () {
  it(`Deployment costs`, async function () {
    const contracts = await getContracts(
      "RoadsToDreams",
      "RoadsToDreamsAudited",
      ...roadToDreamsArguments
    );

    compareContracts(
      contracts[0].deployedContractResponse,
      contracts[1].deployedContractResponse
    );
    const [owner, address1, address2] = await ethers.getSigners();
  });
});

describe("Test Soccer", async function () {
  it(`Deployment costs and changed functions`, async function () {
    const contracts = await getContracts("OefbNFT", "OefbNFTAudited");

    compareContracts(
      contracts[0].deployedContractResponse,
      contracts[1].deployedContractResponse
    );
    const [owner, address1, address2] = await ethers.getSigners();

    const weiAmount = ethers.utils.parseEther("0.24");

    compareTransactionContracts(
      "mint",
      await contracts[0].deployedContract
        .connect(address1)
        .mintNFT(3, { value: weiAmount }),
      await contracts[1].deployedContract
        .connect(address2)
        .mintNFT(3, { value: weiAmount })
    );

    return;
  });
});

const getFiles = (directory) => {
  fs.readdir(directory, (err, files) => {
    files.forEach((file) => {
      // get the details of the file
      let fileDetails = fs.lstatSync(path.resolve(directory, file));
      // check if the file is directory
      if (fileDetails.isDirectory()) {
        getFiles(directory + "/" + file);
      } else {
        console.log("Contract: " + file);
        var contract = file.replace(".sol", "");
      }
    });
  });
};

const getContracts = async (
  originalContractName,
  auditedContractName,
  ...args
) => {
  return await Promise.all([
    await initializeContract(originalContractName, ...args),
    await initializeContract(auditedContractName, ...args)
  ]);
};

const initializeContract = async (contract, ...args) => {
  const NFTStandard = await ethers.getContractFactory(contract);
  const deployedContract = await NFTStandard.deploy(...args);
  const deployedContractResponse =
    await deployedContract.deployTransaction.wait();
  return { deployedContract, deployedContractResponse };
};

const compareContracts = (originalContract, auditedContract) => {
  console.log(
    "Original Contract",
    originalContract.gasUsed.toNumber(),
    "Audited Contract",
    auditedContract.gasUsed.toNumber(),
    "Gas Difference",
    originalContract.gasUsed - auditedContract.gasUsed
  );
};

const compareTransactionContracts = async (
  transactionName,
  originalTransaction,
  auditedTransaction
) => {
  console.log(`\tOriginal Contract with transaction ${transactionName}:`);
  const gasOriginal = await getTransactionResponseAndLogGas(
    originalTransaction
  );
  console.log(`\tAudited Contract with transaction ${transactionName}:`);
  const gasAudited = await getTransactionResponseAndLogGas(auditedTransaction);
  console.log("\tDifference: ", gasOriginal - gasAudited);
};

/** Call function and log gas */
const getTransactionResponseAndLogGas = async (transaction) => {
  const transactionResponse = await transaction.wait();
  console.log(
    `\tGas cost for transaction:`,
    transactionResponse.gasUsed.toNumber()
  );
  return transactionResponse.gasUsed;
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
