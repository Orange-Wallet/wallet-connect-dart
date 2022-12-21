import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect_v2/apis/core/store/i_store.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';

class GetStorageStore<T> implements IStore<T> {
  late GetStorage box;
  bool _initialized = false;

  Map<String, T> _map = <String, T>{};

  @override
  Map<String, T> get map => _map;

  @override
  List<String> get keys => map.keys.toList();

  @override
  List<T> get values => map.values.toList();

  @override
  String get storagePrefix => WalletConnectConstants.CORE_STORAGE_PREFIX;

  final T defaultValue;
  final bool memoryStore;

  GetStorageStore(
    this.defaultValue, {
    this.memoryStore = false,
  });

  /// Initializes the store, loading all persistent values into memory.
  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    if (!memoryStore) {
      GetStorage.init();
      box = GetStorage();
    }

    _initialized = true;
  }

  /// Gets the value of the specified key, if it hasn't been cached yet, it caches it.
  /// If the key doesn't exist it throws an error.
  @override
  T get(String key) {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (_map.containsKey(keyWithPrefix)) {
      return _map[keyWithPrefix]!;
    }

    T value = _getPref(keyWithPrefix);
    _map[keyWithPrefix] = value;
    return value;
  }

  @override
  bool has(String key) {
    return _map.containsKey(key);
  }

  /// Gets all of the values of the store
  @override
  List<T> getAll() {
    _checkInitialized();
    return values;
  }

  /// Sets the value of a key within the store, overwriting the value if it exists.
  @override
  Future<void> set(String key, T value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map[keyWithPrefix] = value;
    await _updatePref(keyWithPrefix, value);
  }

  /// Updates the value of a key. Fails if it does not exist.
  @override
  Future<void> update(String key, T value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (!map.containsKey(keyWithPrefix)) {
      throw Errors.getInternalError(Errors.NO_MATCHING_KEY);
    } else {
      _map[keyWithPrefix] = value;
      await _updatePref(keyWithPrefix, value);
    }
  }

  /// Removes the key from the persistent store
  @override
  Future<void> delete(String key) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map.remove(keyWithPrefix);
    await _removePref(keyWithPrefix);
  }

  T _getPref(String key) {
    if (memoryStore) {
      return defaultValue;
    }

    if (box.hasData(key)) {
      return box.read(key);
    } else {
      throw Errors.getInternalError(Errors.NO_MATCHING_KEY);
    }
  }

  Future<void> _updatePref(String key, T value) async {
    if (memoryStore) {
      return;
    }
    try {
      await box.write(key, value);
    } on Exception catch (e) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: e.toString(),
      );
    }
  }

  Future<void> _removePref(String key) async {
    if (memoryStore) {
      return;
    }
    await box.remove(key);
  }

  String _addPrefix(String key) {
    return '$storagePrefix$key';
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
