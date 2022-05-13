import { expect } from "chai";
import { starknet } from "hardhat";
import {
  StarknetContract,
  StarknetContractFactory,
} from "hardhat/types/runtime";

const toStruct = (first: number, second: number) => {
  return { first_member: first, second_member: second };
};

const ARRAY = [1, 2, 3, 4, 5, 6];

describe("Testing the contracts", async function () {
  this.timeout(6_000_000);

  let mockContractFactory: StarknetContractFactory;
  let mockContract: StarknetContract;

  let arrayContractFactory: StarknetContractFactory;
  let arrayContract: StarknetContract;

  before(async () => {
    arrayContractFactory = await starknet.getContractFactory("array_contract");
    arrayContract = await arrayContractFactory.deploy();

    mockContractFactory = await starknet.getContractFactory("mock_contract");
    mockContract = await mockContractFactory.deploy({
      array: ARRAY,
    });
  });

  describe("Test that you debugged the mock contract correctly", async () => {
    it("Let's see if you made it", async () => {
      expect(
        (
          await arrayContract.call("view_product", {
            array: [toStruct(1, 2), toStruct(3, 4)],
          })
        ).res
      ).to.deep.eq(BigInt(arrayContract.address) + BigInt(24));
    });
  });

  describe("Test that you debugged the array contract correctly", async () => {
    it("Let's see if you made it", async () => {
      expect((await mockContract.call("product_mapping")).res).to.deep.eq(
        BigInt(ARRAY.reduce((a, b) => a * b, 1))
      );
    });
  });
});
