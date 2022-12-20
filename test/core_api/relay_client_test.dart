import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';

import 'shared/shared_test_utils.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const TEST_PUB_KEY =
      '9088c381b2022c6311d9b4738e221029ff4b8f3c13860a795c960eac043e7d28';
  const TEST_PRIV_KEY =
      'f24230adbb096e81f4a2a06450c206cafaf49dc6a60daf25d09e05c011e47ed2';
  const TEST_TOPIC = 'abc123';
  const TEST_MESSAGE = 'swagmaster';
  const TEST_RELAY_URL = 'ws://0.0.0.0:5555';
  const TEST_PROJECT_ID = 'abc';

  group('Relay Client', () {
    late Crypto crypto;
    late RelayClient relayClient;

    setUp(() async {
      crypto = MockCrypto();

      MockStore messageTracker = MockStore();
      MockStore topicMap = MockStore();
      when(topicMap.has(TEST_TOPIC)).thenReturn(true);

      relayClient = RelayClient(
        TEST_PROJECT_ID,
        crypto,
        CryptoUtils(),
        test: true,
        messageTracker: messageTracker,
        topicMap: topicMap,
      );
      await relayClient.init();
    });

    // tearDown(() async {
    //   await relayClient.disconnect();
    // });

    test('Handle publish broadcasts and stores the message event', () async {
      int counter = 0;
      relayClient.onRelayClientMessage.subscribe((args) {
        print('swag 4');
        counter++;
      });

      bool published = await relayClient.handlePublish(
        TEST_TOPIC,
        TEST_MESSAGE,
      );
      expect(published, true);
      // await Future.delayed(const Duration(milliseconds: 500));
      // expect(counter, 1);

      Map<String, String>? message = relayClient.messageRecords[TEST_TOPIC];
      if (message == null) {
        expect(false, true);
      }

      expect(message, {
        'f745695b2a861fd6f0d99893793b6c3ca63b333c7d95194d575165a35a7ca02d':
            'swagmaster',
      });
    });
  });
}
