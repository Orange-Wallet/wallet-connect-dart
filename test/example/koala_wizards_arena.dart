import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/apis/core/core.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/sign_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/sign_client.dart';

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
          'wc:2d6ddffd0af65f7dc42046e7782f8d72d2d8426380f62b813b75033d2b7c112a@2?relay-protocol=irn&symKey=453620c27e47f6db8a2e1eb963c03e7dd6c54c6474c0c857f7f98b4dc4bd1c02';
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
