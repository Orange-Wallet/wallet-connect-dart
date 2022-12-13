import 'package:wallet_connect_v2/apis/interfaces/i_key_chain.dart';

class KeyChain implements IKeyChain {
  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement context
  String get context => throw UnimplementedError();

  @override
  // TODO: implement keychain
  Map<String, String> get keychain => throw UnimplementedError();

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  bool has(String tag, options) {
    // TODO: implement has
    throw UnimplementedError();
  }

  @override
  String get(String tag, options) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> set(String tag, String key, options) {
    // TODO: implement set
    throw UnimplementedError();
  }

  @override
  Future<void> del(String tag, options) {
    // TODO: implement del
    throw UnimplementedError();
  }
}
