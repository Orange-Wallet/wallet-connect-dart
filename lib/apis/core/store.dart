import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect_v2/apis/interfaces/i_store.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';

class Store implements IStore<String> {
  late SharedPreferences prefs;
  bool _initialized = false;

  Map<String, String> _map = <String, String>{};

  @override
  Map<String, String> get map => _map;

  @override
  List<String> get keys => map.keys.toList();

  @override
  List<String> get values => map.values.toList();

  final String _storagePrefix;
  @override
  String get storagePrefix => _storagePrefix;

  Store(this._storagePrefix);

  /// Initializes the store, loading all persistent values into memory.
  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  /// Gets the value of the specified key, if it hasn't been cached yet, it caches it.
  /// If the key doesn't exist it throws an error.
  @override
  String get(String key) {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (_map.containsKey(keyWithPrefix)) {
      return _map[keyWithPrefix]!;
    }

    String value = _getPref(keyWithPrefix);
    _map[keyWithPrefix] = value;
    return value;
  }

  /// Gets all of the values of the store
  @override
  List<String> getAll() {
    _checkInitialized();
    return values;
  }

  /// Sets the value of a key within the store, overwriting the value if it exists.
  @override
  Future<void> set(String key, String value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map[keyWithPrefix] = value;
    await _updatePref(keyWithPrefix, value);
  }

  /// Updates the value of a key. Fails if it does not exist.
  @override
  Future<void> update(String key, String value) async {
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

  String _getPref(String key) {
    if (prefs.containsKey(key)) {
      return prefs.getString(key)!;
    } else {
      throw Errors.getInternalError(Errors.NO_MATCHING_KEY);
    }
  }

  Future<void> _updatePref(String key, String value) async {
    try {
      await prefs.setString(key, value);
    } on Exception catch (e) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: e.toString(),
      );
    }
  }

  Future<void> _removePref(String key) async {
    await prefs.remove(key);
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
