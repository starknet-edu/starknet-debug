# Starknet debugging

The goal of this tutorial is to see what tool could be useful to debug a smart contract using 2 different testing frameworks:

- [hardhat](https://github.com/Shard-Labs/starknet-hardhat-plugin)
- [native framework](https://www.cairo-lang.org/docs/hello_starknet/unit_tests.html)

We'll use a functionnality of the Cairo language called [hints](https://starknet.io/docs/how_cairo_works/hints.html), which allows you to inject python arbitrarily in your code. Hint usage is heavily restricted on StarkNet and is unaplicable in Smart Contracts. But it is extremely useful to debug your contract.

## Smart contract

The first smart contract [`array_contract.cairo`](python/contracts/array_contract.cairo) is a dumb smart contract which has a [view function](https://www.cairo-lang.org/docs/hello_starknet/intro.html) that will

- Compute the product of each array element
- Add the current contract’s address to it.

The second smart contract [`mock_contract.cairo`](python/contracts/mock_contract.cairo) is also a dumb smart contract which will save an array given at the initialization into a mapping and has a view function that will

- Compute the product of each mapping element

## Testing frameworks

### Hardhat

Run the following command in the hardhat directory

```bash
npm i
```

You'll also need `cairo-lang` and the [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet). To setup a full `cairo` env you can take a look at [this article](https://medium.com/starknet-edu/the-ultimate-starknet-dev-environment-716724aef4a7)

```bash
pip install "starknet-devnet>=0.2.1" cairo-lang
```

You can run any hint on the starknet-devnet if you manage to compile the contract. By default, StarkNet contracts can not use any hints in their code. But An option has been added in hardhat to compile a contract without validating the hints in the contract `--disable-hint-validation`. To execute the tests you can run the `test` script in [`package.json`](hardhat/package.json):

***To debug a smart contract using hardhat you may want to print variables, there is an example in the smart contract.***

The contracts to fix are [here](hardhat/contracts).

You can find the test file [here](hardhat/test/test.spec.ts).

The following command will run the hardhat tests and execute the hints in this terminal

```bash
npm run test
```

### Python

To run the python unit test files you'll need pytest and asynctest

```bash
pip install pytest asynctest cairo-lang
```

The Python testing framework doesn't need to interact with the `starknet-devnet` as it can natively use the testing functions from the `cairo-lang` package so you can also use any python hint you want. To run your python unit tests you can run `pytest`

The contracts to fix are [here](python/contracts).

You can find the test script [here](python/test)

Run the tests separately using:

```bash
pytest tests/test_array_contract.py -s -W ignore::DeprecationWarning
```

```bash
pytest tests/test_mock_contract.py -s -W ignore::DeprecationWarning
```

Or all at once with:

```bash
pytest -s -W ignore::DeprecationWarning
```
