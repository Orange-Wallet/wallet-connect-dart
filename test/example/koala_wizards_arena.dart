import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/wallet_connect_v2.dart';

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Pairing Test', () {
    // ICore core = Core(projectId: '');
    // late Crypto crypto;
    // late RelayClient relayClient;
    // MockMessageTracker messageTracker = MockMessageTracker();
    // MockTopicMap topicMap = MockTopicMap();
    setUp(() async {
      // crypto = MockCrypto();
    });
    test('Test connecting to dapp', () async {
      // 1. Get URI from QR Scanner
      const wizardsArenaQrURI =
          'wc:ece55398da6475a5caacab3c1764de849cb0da8e8720f82567324f6c3436682a@2?relay-protocol=irn&symKey=1e4c487b6933ad1877fcb7d94ab60c08d1d7282ab67bcd1b3c1dc90402c77db3';
      Uri uri = Uri.parse(wizardsArenaQrURI);
      print('uri = $uri');
      print('uri.scheme = ${uri.scheme}');

      // 2. Initiate wcClient
      const wcKoalaProjectId = 'c993e66665ac416812435c9f1f07a96c';
      SignClient wcClient = await SignClient.createInstance(
        Core(
          projectId: wcKoalaProjectId,
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
        print('args!.params.requiredNamespaces = ${args!.params.requiredNamespaces}');

        // approve session
        // // Present the UI to the user, and allow them to reject or approve the proposal
        final walletNamespaces = {
          'kadena': Namespace(
            accounts: ['kadena:mainnet01:cf415c73edb4666a967933bddc2e6c4a6e13b8ec0566e612b9f3cbe4a4d8506e', 'kadena:testnet04:cf415c73edb4666a967933bddc2e6c4a6e13b8ec0566e612b9f3cbe4a4d8506e'],
            methods: ['kadena_sign', 'kadena_quicksign'],
            events: ['kadena_transaction_updated'],
          ),
        };
        await
        wcClient.approve(
            ApproveParams(
                id: id,
                namespaces: walletNamespaces // This will have the accounts requested in params
            )
        );
      });

      PairingInfo pairingInfo = await wcClient.pair(PairParams(uri: uri));
      print('pairingInfo.topic = ${pairingInfo.topic}');
      print('pairingInfo.relay.protocol = ${pairingInfo.relay.protocol}');
      print('pairingInfo.peerMetadata = ${pairingInfo.peerMetadata}');

      // 3.

      // 3. Create Session

      await Future.delayed(Duration(seconds: 10000));
    });
  });
}
