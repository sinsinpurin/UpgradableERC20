# Separate Logic and Data Contracts with Data as Key-Value Pairs

## Deploy

1. Storage.sol(Storage部分)をデプロイ

2. MyToken.sol(Logic部分)をデプロイ
    コンストラクタでStorageの参照先を初期化

3. StorageERC20.solのアクセスをMyTokenのコントラクトアドレスに限定
    `changeAccessAddress(address newAccessAddress)`を実行

4. MyTokenの初期化
    `initMyToken`を実行

## Upgrade
1. NewMyToken.sol(Logic部分)をデプロイ
    コンストラクタで参照先の初期化
2. StorageERC20.solのアクセスをMyTokenのコントラクトアドレスに変更

## Run Truffle

```js
$ truffle migrate
$ truffle console
$> let SE = await Storage.deployed();
$> let MT = await MyToken.deployed();
$> SE.changeAccessAddress(MT.address);
$> MT.initMyToken()；

```