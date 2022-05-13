# Starknet debugging

The goal of this tutorial is to see what tool could be useful to debug a smart contract using 2 different testing frameworks:

- [hardhat](https://github.com/Shard-Labs/starknet-hardhat-plugin)
- [native framework](https://www.cairo-lang.org/docs/hello_starknet/unit_tests.html)

## Smart contract

The first smart contract `array_contract.cairo` is a dumb smart contract which has a [view function](https://www.cairo-lang.org/docs/hello_starknet/intro.html) that will

- compute the product of each array element
- add the current contract’s address to it.

The second smart contract is also a dumb smart contract which will save an array given at the initialization into a mapping and has a [view function](https://www.cairo-lang.org/docs/hello_starknet/intro.html) that will

- compute the product of each mapping element

## Installing the dependencies

### Hardhat

Run the following command in the hardhat directory

```bash
npm i
```

You'll also need `cairo-lang` and the [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet). To setup a full `cairo` env you can take a look at [this article](https://medium.com/starknet-edu/the-ultimate-starknet-dev-environment-716724aef4a7)

```bash
pip install cairo-lang starknet-devnet
```

### Python

To run the python unit test files you'll need pytest and asynctest

```bash
pip install pytest asynctest
```

## Hardhat

You can run any hint on the starknet-devnet if you manage to compile the contract. An option has been added in hardhat to compile a contract without validating the hints in the contract `--disable-hint-validation`. To execute the tests you can run the following script in [`package.json`](hardhat/package.json):
***To debug a smart contract using hardhat you may want to print variables, there is an example in the smart contract.***

```bash
npm run test
```

## Python

The Python testing framework doesn't need to interact with the `starknet-devnet` as it can natively use the testing functions from the `cairo-lang` package so you can also use any python hint you want. To run your python unit tests you can use `pytest`

## Your job

Your job is to fix the smart contract so it passes the test

***hardhat***

```bash
npm run test
```

***python***

```bash
pytest tests/test_array_contract.py -s -W ignore::DeprecationWarning
```

```bash
pytest tests/test_mock_contract.py -s -W ignore::DeprecationWarning
```
