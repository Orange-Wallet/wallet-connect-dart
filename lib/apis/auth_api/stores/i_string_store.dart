import 'package:wallet_connect_v2_dart/apis/core/store/i_store_user.dart';

abstract class IStringStore extends IStoreUser {
  Future<void> init();
  bool has(String key);
  Future<void> set(String key, String value);
  String? get(String key);
  List<String> getAll();
  Future<void> delete(String topic);
}
