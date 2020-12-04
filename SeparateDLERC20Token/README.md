# Separate Logic and Data Contracts

## Deploy

1. StorageERC20.sol(Storage部分)をデプロイ
    コンストラクタでname, symbol, decimalsを初期化

2. MyToken.sol(Logic部分)をデプロイ
    コンストラクタでStorageの参照先を初期化

3. StorageERC20.solのアクセスをMyTokenのコントラクトアドレスに限定
    `changeAccessAddress(address newAccessAddress)`を実行

4. MyTokenの初期化
    `initMint`を実行

## Run Truffle

```js

$> let SE = await StorageERC20.deployed();
$> let MT = await MyToken.deployed();
$> SE.changeAccessAddress(MT.address);
$> MT.initMint() 

```