import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_utils.dart';

import 'shared_test_values.dart';

void main() {
  final TEST_MESSAGE = jsonEncode({
    'id': 1,
    'jsonrpc': "2.0",
    'method': "test_method",
    'params': {},
  });

  final TEST_SELF = TEST_KEY_PAIRS['A']!;
  final TEST_PEER = TEST_KEY_PAIRS['B']!;

  const TEST_IV = "717765636661617364616473";

  const TEST_SEALED =
      "7a5a1e843debf98b01d6a75718b5ee27115eafa3caba9703ca1c5601a6af2419045320faec2073cc8b6b8dc439e63e21612ff3883c867e0bdcd72c833eb7f7bb2034a9ec35c2fb03d93732";

  const TEST_ENCODED_TYPE_0 =
      "AHF3ZWNmYWFzZGFkc3paHoQ96/mLAdanVxi17icRXq+jyrqXA8ocVgGmryQZBFMg+uwgc8yLa43EOeY+IWEv84g8hn4L3Ncsgz6397sgNKnsNcL7A9k3Mg==";
  const TEST_ENCODED_TYPE_1 =
      "Af96fVdnw2KwoXrZIpnr23gx3L2aVpWcATaMdARUOzNCcXdlY2ZhYXNkYWRzeloehD3r+YsB1qdXGLXuJxFer6PKupcDyhxWAaavJBkEUyD67CBzzItrjcQ55j4hYS/ziDyGfgvc1yyDPrf3uyA0qew1wvsD2Tcy";

  setUpAll(() {});

  group('Crypto Utils', () {
    test('should generate keypairs properly', () {
      KeyPair kp = CryptoUtils.generateKeyPair();
      expect(kp.privateKey.length, 64);
      expect(kp.publicKey.length, 64);
    });

    test('can derive the sym key', () async {
      KeyPair kp1 = CryptoUtils.generateKeyPair();
      KeyPair kp2 = CryptoUtils.generateKeyPair();
      final String symKeyA = await CryptoUtils.deriveSymKey(
        kp1.privateKey,
        kp2.publicKey,
      );
      final String symKeyB = await CryptoUtils.deriveSymKey(
        kp2.privateKey,
        kp1.publicKey,
      );
      expect(symKeyA, symKeyB);
    });

    test('hashes key correctly', () {
      final String hashedKey = CryptoUtils.hashKey(TEST_SHARED_KEY);
      expect(hashedKey, TEST_HASHED_KEY);
    });

    test('hashes messages correctly', () {
      const TEST_HASHED_MESSAGE =
          "15112289b5b794e68d1ea3cd91330db55582a37d0596f7b99ea8becdf9d10496";
      final String hashedKey = CryptoUtils.hashMessage(TEST_MESSAGE);
      expect(hashedKey, TEST_HASHED_MESSAGE);
    });

    test('encrypt type 0 envelope', () async {
      final String encoded = await CryptoUtils.encrypt(
        TEST_MESSAGE,
        TEST_SYM_KEY,
        iv: TEST_IV,
      );
      expect(encoded, TEST_ENCODED_TYPE_0);
      final EncodingParams deserialized = CryptoUtils.deserialize(encoded);
      final String iv = hex.encode(deserialized.iv);
      expect(iv, TEST_IV);
      final String sealed = hex.encode(deserialized.sealed);
      expect(sealed, TEST_SEALED);
    });
  });

  test('decrypts type 0 envelope properly', () async {
    final String decrypted = await CryptoUtils.decrypt(
      TEST_SYM_KEY,
      TEST_ENCODED_TYPE_0,
    );
    expect(decrypted, TEST_MESSAGE);
  });

  test("encrypt (type 1)", () async {
    final String encoded = await CryptoUtils.encrypt(
      TEST_MESSAGE,
      TEST_SYM_KEY,
      type: 1,
      iv: TEST_IV,
      senderPublicKey: TEST_SELF.publicKey,
    );
    expect(encoded, TEST_ENCODED_TYPE_1);
    final EncodingParams deserialized = CryptoUtils.deserialize(encoded);
    final String iv = hex.encode(deserialized.iv);
    expect(iv, TEST_IV);
    final String sealed = hex.encode(deserialized.sealed);
    expect(sealed, TEST_SEALED);
  });

  test("decrypt (type 1)", () async {
    const encoded = TEST_ENCODED_TYPE_1;
    final EncodingValidation params = CryptoUtils.validateDecoding(
      encoded,
      receiverPublicKey: TEST_PEER.publicKey,
    );
    expect(CryptoUtils.isTypeOneEnvelope(params), true);
    expect(params.type, 1);
    expect(params.senderPublicKey, TEST_SELF.publicKey);
    expect(params.receiverPublicKey, TEST_PEER.publicKey);
    print(await CryptoUtils.deriveSymKey(
        TEST_PEER.privateKey, TEST_SELF.publicKey));
    final String symKey = await CryptoUtils.deriveSymKey(
        TEST_PEER.privateKey, params.senderPublicKey!);
    expect(symKey, TEST_SYM_KEY);
    final String decrypted = await CryptoUtils.decrypt(symKey, encoded);
    expect(decrypted, TEST_MESSAGE);
  });
}
