import 'package:event/src/eventargs.dart';
import 'package:event/src/event.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_expirer.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/core/store/i_store.dart';
import 'package:wallet_connect_v2/apis/core/key_chain/i_key_chain.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';
import 'package:wallet_connect_v2/apis/utils/misc.dart';

class Expirer implements IExpirer {
  static const CONTEXT = 'expirer';
  static const VERSION = '0.3';

  @override
  final Event<ExpirationEvent> created = Event<ExpirationEvent>();
  @override
  final Event<ExpirationEvent> deleted = Event<ExpirationEvent>();
  @override
  final Event sync = Event();
  @override
  final Event<ExpirationEvent> expired = Event<ExpirationEvent>();

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;
  Map<String, int> expirations = {};

  Expirer(this.core);

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.storage.init();
    await restore();

    _initialized = true;
  }

  /// Returns true if the keychain has the given tag
  @override
  bool has(String key) {
    _checkInitialized();
    return expirations.containsKey(key);
  }

  /// Gets the key associated with the provided tag
  @override
  int get(String key) {
    _checkInitialized();
    if (expirations.containsKey(key)) {
      return expirations[key]!;
    }
    return -1;
  }

  /// Sets the value with the given key
  @override
  Future<void> set(String key, int value) async {
    _checkInitialized();
    expirations[key] = value;
    bool expired = this.checkExpiry(key, value);
    if (!expired) {
      created.broadcast(
        ExpirationEvent(
          key,
          value,
        ),
      );
      await persist();
    }
  }

  /// Deletes the key from the keychain
  @override
  Future<void> delete(String key) async {
    _checkInitialized();
    int? expiry = expirations.remove(key);
    expiry ??= -1;
    deleted.broadcast(
      ExpirationEvent(
        key,
        expiry,
      ),
    );
    await persist();
  }

  @override
  bool checkExpiry(String key, int expiry) {
    int msToTimeout = MiscUtils.toMilliseconds(expiry) -
        DateTime.now().toUtc().millisecondsSinceEpoch;
    if (msToTimeout <= 0) {
      expire(key);
      return true;
    }
    return false;
  }

  @override
  void expire(String key) {
    int? expiry = expirations.remove(key);
    if (expiry == null) {
      return;
    }
    expired.broadcast(
      ExpirationEvent(
        key,
        expiry,
      ),
    );
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, expirations);
    sync.broadcast();
  }

  @override
  Future<void> restore() async {
    expirations = MiscUtils.convertMapTo<int>(
      core.storage.get(storageKey),
    );
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
