import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/wallet_connect_v2.dart';

import '../shared/shared_test_values.dart';

// To run this with the URL provided:
// flutter test test/example/koala_test.dart --dart-define=URI='YOUR_WC_URL'

// The WC Modal should disappear, and you can test signing a message.
// The signing will fail, but it will print out the raw TX for you.

main() async {
  // Get the URL from the env variables
  const connectionUri = const String.fromEnvironment(
    'URI',
    defaultValue: '',
  );
  print('URI = $connectionUri');

  if (connectionUri == '') {
    return;
  }

  // 1. Get URI from QR Scanner
  Uri uri = Uri.parse(connectionUri);
  print('uri = $uri');
  print('uri.scheme = ${uri.scheme}');

  test('Can connect to live websites', () async {
    // 2. Initiate wcClient
    // const wcKoalaProjectId = TEST_PR 'c993e66665ac416812435c9f1f07a96c';
    SignClient wcClient = await SignClient.createInstance(
      Core(
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
      ),
      self: PairingMetadata(
        'Koala Wallet',
        'Your Passport to the Kadena Ecosystem',
        'https://koalawallet.io',
        ['https://koalawallet.io/media/png/koala_color.png'],
      ),
    );

    // For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
    late int id;
    wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
      // Handle UI updates using the args.params
      // Keep track of the args.id for the approval response
      id = args!.id;
      print(
        'args!.params.requiredNamespaces = ${args.params.requiredNamespaces}',
      );

      // approve session
      // // Present the UI to the user, and allow them to reject or approve the proposal
      final walletNamespaces = {
        'kadena': Namespace(
          accounts: [
            'kadena:mainnet01:k**cf415c73edb4666a967933bddc2e6c4a6e13b8ec0566e612b9f3cbe4a4d8506e',
            // yes this is correct. They replace ** with - on their end
            'kadena:testnet04:k**cf415c73edb4666a967933bddc2e6c4a6e13b8ec0566e612b9f3cbe4a4d8506e'
          ],
          methods: [
            'kadena_sign',
            'kadena_quicksign',
            'kaddex_sign',
            'kaddex_send_transaction',
            'kaddex_sign_transaction',
          ],
          events: [
            'chainChanged', // Present in swarms.finance, you shouldn't care about this
            'accountsChanged', // Present in swarms.finance, you might need to care about this
            'kadena_transaction_updated',
          ],
        ),
      };
      await wcClient.approve(
        id: id,
        namespaces: walletNamespaces,
      ); // This will have the accounts requested in params
    });

    // Also setup the namespaces and methods that your wallet supports
    final kadenaSignHandler = (dynamic params) async {
      // params is the transaction data that needs to be constructed and signed
      // It is a JSON object, with the format of a Signing Request
      // Please read over my supplied documentation for more information
      // on Signing Requests and capabilities.
      print('received kadena_sign request');
      print(params);

      // Returns an example transaction that says "Test hello"
      // No signers, but it doesn't require any.
      return {
        'hash': 'vVmd6hDD2z8n7Uw_d0YeKky5wa12FVBfQJRC6szFIzY',
        'sigs': [],
        'cmd':
            '{"networkId": "testnet04", "payload": {"exec": {"data": {}, "code": "(format \\"Test {}\\" [\\"hello\\"])"}}, "signers": [], "meta": {"gasLimit": 2500, "chainId": "0", "gasPrice": 1e-05, "sender": "", "ttl": 28000, "creationTime": 1675138667}, "nonce": "20230130211801"}',
      };
    };

    // Looks like kaddex has additional methods that should never be used.
    // I have no idea what they do or why they are there.
    // They were present in swarms.finance
    final List<String> methods = [
      'kadena_sign',
      'kaddex_sign',
      'kaddex_send_transaction',
      'kaddex_sign_transaction',
    ];
    for (final method in methods) {
      wcClient.registerRequestHandler(
        chainId: 'kadena:mainnet01',
        method: method,
        handler: kadenaSignHandler,
      );
      wcClient.registerRequestHandler(
        chainId: 'kadena:testnet04',
        method: method,
        handler: kadenaSignHandler,
      );
    }

    final kadenaQuickSignHandler = (dynamic params) async {
      // TODO implement quick signing
      print('received kadena_quicksign request');
      print(params);
      return 'quicksigned!';
    };
    wcClient.registerRequestHandler(
      chainId: 'kadena',
      method: 'kadena_quicksign',
      handler: kadenaQuickSignHandler,
    );

    PairingInfo pairingInfo = await wcClient.pair(uri: uri);
    print('pairingInfo.topic = ${pairingInfo.topic}');
    print('pairingInfo.relay.protocol = ${pairingInfo.relay.protocol}');
    print('pairingInfo.peerMetadata = ${pairingInfo.peerMetadata}');

    await Future.delayed(Duration(seconds: 10000));
  }, timeout: Timeout(Duration(seconds: 10000)));
}
