# Starknet debugging

The goal of this tutorial is to see what tool could be useful to debug a smart contract using 3 different testing frameworks:
- [hardhat](https://github.com/Shard-Labs/starknet-hardhat-plugin)
- [protostar](https://github.com/software-mansion/protostar)
- [native framework](https://www.cairo-lang.org/docs/hello_starknet/unit_tests.html)

## Smart contract

This smart contract is a dumb smart contract which has a [view function](https://www.cairo-lang.org/docs/hello_starknet/intro.html) that will
- compute the product of each array element
- add the current contract’s address to it.

## Hardhat

You can run any hint on the starknet-devnet if you manage to compile the contract. An option has been added in hardhat to compile a contract without validating the hints in the contract `--disable-hint-validation`. To execute the tests you can run the following script in [`package.json`](hardhat/package.json):
***To debug a smart contract using hardhat you may want to print variables, there is an example in the smart contract.***
```
npm run test
``` 

### Install the dependencies

```bash
npm i
```

## Your job

Your job is to fix the smart contract so it passes the test

***hardhat***
```
npm run test
```

***python***
```
pytest tests -s -W ignore::DeprecationWarning
```