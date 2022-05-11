# Starknet debugging

The goal of this tutorial is to see what tool could be useful to debug a smart-contract using 3 different testing frameworks (hardhat, protostar, native framework)

## Smart contract

This smart contract is a dumb smart contract which has a view that will compute the product of each array element and then will add the address to it

## Hardhat

To debug a smart contract using hardhat you may want to print variables, there is an example in the smart contract. You can basically run any hint on the starknet-devnet if you manage to compile the contract. An option have be added to hardhat to compile a contract without validating the hints in the contract `--disable-hint-validation`. To execute the tests you can run `npm run test` which is a script accessible in [`package.json`](hardhat/package.json)

### Install the dependencies

```bash
npm i
```

## Your job

Your job is to fix the smart contract so it passes the test
