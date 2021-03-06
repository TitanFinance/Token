# Titan Finance Token

## Introduction
Welcome to Titan Finance Token

<div>
  <img src="https://user-images.githubusercontent.com/57055334/121403027-da08f280-c99d-11eb-9a6f-685a5d4f5721.png" height="50" />
<div>
<br />

Do you have what it takes?
Visit [Official site](https://www.TitanFinance.com/) to find out.

## How to start?

This project utilizes [Truffle Suite](https://www.trufflesuite.com/) to automate testing.

You will need to install [Truffle](https://www.trufflesuite.com/truffle):

```
npm install truffle -g
```

and [Ganache CLI](https://github.com/trufflesuite/ganache-cli):

```
npm install -g ganache-cli
```

Once installed, run Ganache CLI in a terminal:

```
My-Comp:~ johndoe$ ganache-cli
```

Then, from the root of this project, run the tests:

```
truffle test
```

## Titan Finance Token Testing

You can test contract by forking mainnet into local.
You will need to copy `start.sh.example` to `start.sh` in root directory.
And please add your infura id and mnemonic.

Then, from the root of this project, run the tests:

```
sh ./start.sh
```

```
truffle test
```
or

```
truffle test ./test/erc20.test.js
```
