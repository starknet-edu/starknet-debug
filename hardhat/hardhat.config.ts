import { HardhatUserConfig } from "hardhat/types";
import "@shardlabs/starknet-hardhat-plugin";

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const config: HardhatUserConfig = {
  starknet: {
    venv: "active",
    network: "integratedDevnet",
  },
  networks: {
    integratedDevnet: {
      url: "http://127.0.0.1:5050",
      args: ["--lite-mode"],

      stdout: "STDOUT",
    },
    testnet: {
      url: "http://127.0.0.1:5050",
    },
  },
};

export default config;
