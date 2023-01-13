# Overview

Wallet Connect V2 client forked from <https://github.com/Orange-Wallet/wallet-connect-dart> and heavily extended and tested.

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
- Reduce number of crypto libraries used for encryption, shared key, etc.
- Auth API
- Push API

# To Use

## Setup

The following code provides an example for setting up the wallet connect client.

```dart
import 'package:wallet_connect_v2/wallet_connect_v2.dart';

SignClient wcClient = await SignClient.createInstance(
  Core(
    'wss://relay.walletconnect.com', // The relay websocket URL
    '123', // The project ID
  ),
  self: PairingMetadata(
    'Wallet (Responder)',
    'A wallet that can be requested to sign transactions',
    'https://walletconnect.com',
    ['https://avatars.githubusercontent.com/u/37784886'],
  ),
);
```

## Pair, Approve, and Sign

Now that you have a wallet connect client, you can pair with a dApp,
approve a session and sign from the wallet.

### dApp Flow
```dart
// For a dApp, you would connect with specific parameters, then display
// the returned URI.
ConnectResponse resp = await wcClient.connect(
  ConnectParams(
    requiredNamespaces: {
      'eip155': RequiredNamespace(
        chains: ['eip155:1'], // Ethereum chain
        methods: ['eth_signTransaction'], // Requestable Methods
      ),
      'kadena': RequiredNamespace(
        chains: ['kadena:1'], // Kadena chain
        methods: ['quicksign'], // Requestable Methods
      ),
    }
  )
)
Uri? uri = resp.uri;

// Once you've display the URI, you can wait for the future, and hide the QR code once you've received session data
final SessionData session = await resp.session.future;

// Now that you have a session, you can request signatures
final sig = await wcClient.request(
  RequestParams(
    topic: session.topic,
    request: WcSessionRequestRequest(
      chainId: 'eip155',
      method: 'eth_signTransaction',
      params: 'transaction',
    ),
  ),
);
```

### Wallet Flow
```dart
// For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
late int id;
wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
  // Handle UI updates using the args.params
  // Keep track of the args.id for the approval response
  id = args!.id;
})

// Also setup the methods and chains that your wallet supports
final handler = (dynamic params) async {
  return 'signed!';
};
wcClient.registerRequestHandler(
  'eip155:1',
  'eth_signTransaction',
  handler,
);

// Then, scan the QR code and parse the URI, and pair with the dApp
// On the first pairing, you will immediately recieve a onSessionProposal request.
Uri uri = Uri.parse(scannedUriString);
await wcClient.pair(PairParams(uri: uri));

// Present the UI to the user, and allow them to reject or approve the proposal
final walletNamespaces = {
  'eip155:1': Namespace(
    accounts: ['abc'],
    methods: ['eth_signTransaction'],
  ),
  'kadena': Namespace(
    accounts: ['k:abc'],
    methods: ['sign', 'quicksign'],
  ),
}
await wcClient.approve(
  ApproveParams(
    id: id,
    namespaces: walletNamespaces // This will have the accounts requested in params
  )
);
// Or to reject...
await wcClient.reject(
  RejectParams(
    id: id,
    reason: "Thou shall not pass!"
  )
);

// Your wallet is setup and ready to go!
```

A wallet exposes different methods for different chains using the `request` function. To register functions that will immediately respond to different requests you must call the 

# To Test

- Pull this repo and set it up: <https://github.com/WalletConnect/relay>

Build using make dev, docker must be open.
Install dependencies using npm install.
Run it using this command: `PORT=5555 npm run start`.

- Run `flutter test`