
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/apis/core/core.dart';
import 'package:wallet_connect_v2_dart/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2_dart/apis/core/i_core.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/sign_client.dart';

import '../core_api/shared/shared_test_utils.mocks.dart';

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
          'wc:38d5743f87264253cb529e6eb98c5c51a4c3782598c098d27b762d6e5806399a@2?relay-protocol=irn&symKey=b569599ad1a1e50c01403cead1e41c5e826c74e60a335ba46af75f01f1d895fa';
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

      PairingInfo pairingInfo = await wcClient.pair(PairParams(uri: uri));
      print('pairingInfo.topic = ${pairingInfo.topic}');
      print('pairingInfo.relay.protocol = ${pairingInfo.relay.protocol}');
      print('pairingInfo.peerMetadata = ${pairingInfo.peerMetadata}');
    });
  });
}
