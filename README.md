Wallet Connect client in dart highly inspired from [wallet-connect-monorepo](https://github.com/trustwallet/wallet-connect-kotlin) by Wallet Connect.

This package is a work in progress.

Pieces that need to be completed:

- Core API
  - Crypto API
  - Pairing API
  - Relay API
  - Store API
- Sign API
- Auth API
- Push API

I am beginning with the Core API. Once that is completed the others should fall into place.

For all JSONRPC calls, I plan on using the [json_rpc_2](https://pub.dev/packages/json_rpc_2) package for dart.

For all crypto related needs, such as generating keys and DH encryption/decryption, I plan on using a custom version of 