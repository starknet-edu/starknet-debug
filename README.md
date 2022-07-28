# Starknet debugging

Welcome! This tutorial will show you how to use StarkNet development tools to debug a smart contract using 3 different testing frameworks:

- [Hardhat](https://github.com/Shard-Labs/starknet-hardhat-plugin)
- [StarkNet's native framework](https://www.cairo-lang.org/docs/hello_starknet/unit_tests.html)
- [Ape](https://github.com/ApeWorX/ape-starknet)

We'll use a functionality of the Cairo language called [hints](https://starknet.io/docs/how_cairo_works/hints.html), which allows you to inject python arbitrarily in your code. Hint usage is heavily restricted on StarkNet and is unapplicable in Smart Contracts. But it is extremely useful to debug your contract.

## Introduction

### How it works

For each framework, there is a folder with broken or incomplete smart contracts that you need to fix. Each framework also includes a set of tests that the contract needs to pass.

Your objective is to use the debugging features outlined in the readme to understand the bug, fix it, and have the tests pass.

### Where am I?

This workshop is the fifth in a series aimed at teaching how to build on StarkNet. Checkout out the following:

|Topic|GitHub repo|
|---|---|
|Learn how to read Cairo code |[Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)|
|Deploy and customize an ERC721 NFT |[StarkNet ERC721](https://github.com/starknet-edu/starknet-erc721)|
|Deploy and customize an ERC20 token|[StarkNet ERC20](https://github.com/starknet-edu/starknet-erc20)|
|Build a cross layer application|[StarkNet messaging bridge](https://github.com/starknet-edu/starknet-messaging-bridge)|
|Debug your Cairo contracts easily (you are here)|[StarkNet debug](https://github.com/starknet-edu/starknet-debug)|
|Design your own account contract|[StarkNet account abstraction](https://github.com/starknet-edu/starknet-accounts)|

### Providing feedback & getting help

Once you are done working on this tutorial, your feedback would be greatly appreciated!

**Please fill out [this form](https://forms.reform.app/starkware/untitled-form-4/kaes2e) to let us know what we can do to make it better.**

​
And if you struggle to move forward, do let us know! This workshop is meant to be as accessible as possible; we want to know if it's not the case.

​
Do you have a question? Join our [Discord server](https://discord.gg/5QetpWWPE5), register, and join channel #tutorials-support
​
Are you interested in following online workshops about learning how to dev on StarkNet? [Subscribe here](http://eepurl.com/hFnpQ5)

### Contributing

This project can be made better and will evolve as StarkNet matures. Your contributions are welcome! Here are things that you can do to help:

- Create a branch with a translation to your language
- Correct bugs if you find some
- Add an explanation in the comments of the exercise if you feel it needs more explanation

​
​

## Getting started

### Smart contracts that need fixing

The first smart contract [`array_contract.cairo`](python/contracts/array_contract.cairo) is a dummy smart contract which has a [view function](https://www.cairo-lang.org/docs/hello_starknet/intro.html) that needs to

- Compute the product of each array element
- Add the current contract’s address to it.

The second smart contract [`mock_contract.cairo`](python/contracts/mock_contract.cairo) is also a dummy smart contract which will save an array given at the initialization into a mapping and has a view function that needs to

- Compute the product of each mapping element

For each of those contracts, and each framework, your goal is that the tests pass correctly.

​
​

## Debugging with Hardhat

### Installing

Run the following command in the hardhat directory to install all dependencies, as well `cairo-lang` and the [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet).

```bash
npm i
pip install "starknet-devnet>=0.2.1" cairo-lang
```

To setup a full `cairo` env you can take a look at [this article](https://medium.com/starknet-edu/the-ultimate-starknet-dev-environment-716724aef4a7).

### Including hints in your contract

By default, StarkNet contracts can not use any [hints](https://starknet.io/docs/how_cairo_works/hints.html) in their code. `cairo-lang` refuses to compile contracts including hints.

However, starknet-devnet lets you run hints if you compile your contracts so that they include them.

Luckily, an flag has been added in hardhat to compile a contract that includes hints: `--disable-hint-validation`.

***To debug a smart contract using hardhat you may want to print variables, there is an example in the smart contract.***

### Running tests

The following command will run the hardhat tests that need to pass, and execute any hints included in the contract in the terminal

```bash
npm run test
```

Your goal is to have this test pass.

The contracts to fix are [here](hardhat/contracts).

You can find the test file [here](hardhat/test/test.spec.ts).

​
​

## Python

### Installing

To run the python unit test files you'll need pytest and asynctest

```bash
pip install pytest asynctest cairo-lang
```

### Running tests

The Python testing framework doesn't need to interact with the `starknet-devnet` as it can natively use the testing functions from the `cairo-lang` package so you can also use any python hint you want.

You can even add a `breakpoint` in a contract. How powerful is that ?

You can run your python unit tests with

```bash
pytest
```

 and inspect whatever you want in your contract.

The contracts to fix are [here](python/contracts).

You can find the test script [here](python/test).

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

​
​

## Ape

### Installing

To run the ape unit test files you'll need ape installed and configured. This is how you can do it:

```bash
pip install eth-ape "starknet.py==0.2.2a0"
ape plugins install cairo starknet
```

If you were starting from scratch you would have to init your project and update the [`ape-config.yaml`](ape/ape-config.yaml) file. Here it's already been done for your convenience.

If you want to learn a little bit more about ape [here](https://www.youtube.com/watch?v=6nfUpYKLe6Q) is a video that you can watch which explains the basis of ape for StarkNet.

Since ape hides everything printed by the devnet we can use `print` to debug the contract. I chose to save the logs in a file but we could also setup a server that would receive data from the smart-contract execution or whatever other technique you can think of.

### Running tests

To run the tests run the following command:

```bash
ape test
```

The contracts to fix are [here](ape/contracts).

You can find the test script [here](ape/tests).
