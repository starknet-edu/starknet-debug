import { expect } from "chai";
import { starknet } from "hardhat";
import {
  StarknetContract,
  StarknetContractFactory,
} from "hardhat/types/runtime";

const toStruct = (first: number, second: number) => {
  return { first_member: first, second_member: second };
};

describe("Mock test file", async function () {
  this.timeout(6_000_000);

  let mockContractFactory: StarknetContractFactory;
  let mockContract: StarknetContract;

  before(async () => {
    mockContractFactory = await starknet.getContractFactory("array_contract");
    mockContract = await mockContractFactory.deploy();
  });

  describe("Test that you debugged correctly", async () => {
    it("Let's see if you made it", async () => {
      expect(
        (
          await mockContract.call("view_product", {
            array: [toStruct(1, 2), toStruct(3, 4)],
          })
        ).res
      ).to.deep.eq(BigInt(mockContract.address) + BigInt(24));
    });
  });
});
