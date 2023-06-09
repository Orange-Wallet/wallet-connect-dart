import 'package:wallet_connect/core/store/i_store_user.dart';

abstract class IKeyChain extends IStoreUser {
  Future<void> init();
  bool has(
    String tag, {
    dynamic options,
  });
  Future<void> set(
    String tag,
    String key, {
    dynamic options,
  });
  String? get(
    String tag, {
    dynamic options,
  });
  Future<void> delete(
    String tag, {
    dynamic options,
  });
}
