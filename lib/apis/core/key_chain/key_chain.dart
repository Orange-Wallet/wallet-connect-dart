import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/store/store.dart';
import 'package:wallet_connect_v2/apis/core/key_chain/i_key_chain.dart';
import 'package:wallet_connect_v2/apis/models/models.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';

class KeyChain implements IKeyChain {
  static const KEYCHAIN = 'keychain';
  static const KEYCHAIN_STORAGE_VERSION = '0.3';

  bool _initialized = false;

  String get name => KEYCHAIN;
  String get version => KEYCHAIN_STORAGE_VERSION;

  late Store store;

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    store = Store(_storagePrefix);
    await store.init();

    _initialized = true;
  }

  /// Returns true if the keychain has the given tag
  @override
  bool has(
    String tag, {
    dynamic options,
  }) {
    _checkInitialized();
    return store.map.containsKey(_addPrefix(tag));
  }

  /// Gets the key associated with the provided tag
  @override
  String get(
    String tag, {
    dynamic options,
  }) {
    _checkInitialized();
    return store.get(tag);
  }

  /// Sets the value with the given key
  @override
  Future<void> set(
    String tag,
    String key, {
    dynamic options,
  }) async {
    _checkInitialized();
    await store.set(tag, key);
  }

  /// Deletes the key from the keychain
  @override
  Future<void> delete(
    String tag, {
    dynamic options,
  }) async {
    _checkInitialized();
    await store.delete(tag);
  }

  String get _storagePrefix =>
      '${WalletConnectConstants.CORE_STORAGE_PREFIX}$version//$name';

  String _addPrefix(String key) {
    return '$_storagePrefix$key';
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
