/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require("dotenv").config();
require("@nomiclabs/hardhat-waffle");

const DEFAULT_COMPILER_SETTINGS = [
  {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  {
    version: "0.8.13",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
];

const NO_OPTIMIZER_COMPILER_SETTINGS = {
  version: "0.8.19",
  settings: {
    optimizer: {
      enabled: false,
      runs: 200
    }
  }
};

const NO_OPTIMIZER_COMPILER_SETTINGS_V4 = {
  version: "0.8.4",
  settings: {
    optimizer: {
      enabled: false,
      runs: 200
    }
  }
};

const { API_URL } = process.env;
module.exports = {
  solidity: {
    compilers: DEFAULT_COMPILER_SETTINGS,
    overrides: {
      "contracts/audits/AK/NewWorldGuardiansNFT.sol":
        NO_OPTIMIZER_COMPILER_SETTINGS,
      "contracts/audits/AK/OefbNFT.sol":
        NO_OPTIMIZER_COMPILER_SETTINGS_V4
    }
  },

  //defaultNetwork: "goerli",
  networks: {
    hardhat: {},
    goerli: {
      url: API_URL,
    }
  }
};
