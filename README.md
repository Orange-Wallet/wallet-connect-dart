# Overview
Wallet Connect client in dart highly inspired from [wallet-connect-monorepo](https://github.com/trustwallet/wallet-connect-kotlin) by Wallet Connect.

This package is a work in progress.

Completed APIs as per the spec:

- Core API
  - Crypto API
  - Pairing API
  - Relay API
  - Store API
- Sign API

Pieces that need to be completed:

- Example project and dapp
- General explanation on how to use the library
- Publish to dart pub
- Use pointycastle for ChaChaPoly instead of built in cryptocurency class
- Auth API
- Push API

# To Test

- Pull this repo and set it up: https://github.com/WalletConnect/relay

Build using make dev, docker must be open.
Install dependencies using npm install.
Run it using this command: `PORT=5555 npm run start`.

- Run `flutter test`