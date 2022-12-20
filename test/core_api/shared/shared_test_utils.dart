import 'package:mockito/annotations.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/key_chain/key_chain.dart';

@GenerateMocks([
  KeyChain,
  CryptoUtils,
])
class SharedTestUtils {}
