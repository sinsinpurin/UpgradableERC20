# 手順

1. Proxyコントラクトのインスタンス化
2. MyTokenコントラクトのインスタンス化
3. Proxyコントラクトの参照先(MyTokenコントラクト)の設定
4. MyTokenのAbiを読み込んだProxyコントラクトのインスタンスの作成(ProxyMyToken)
5. ProxyMyTokenの初期化

# Truffle Console　の実行確認

```js
let Proxy = await Proxy.deployed()
let MyToken = await MyToken.deployed()

// Proxy先を更新
Proxy.upgradeTo(MyToken.address)

// MyTokenのAbiを読み込んだProxyコントラクトのインスタンスの作成
var ProxyMyToken = new web3.eth.Contract(MyToken.abi, Proxy.address)

// initMyToken実行
ProxyMyToken.methods.initMyToken().send({from:accounts[0], gas: 400000, gasPrice: 21000000000});

// ProxyMyTokenのname
ProxyMyToken.methods.name().call()
```