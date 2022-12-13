abstract class IKeyChain {
  abstract final Map<String, String> keychain;
  abstract final String name;
  abstract final String context;

  Future<void> init();
  bool has(String tag, dynamic options);
  Future<void> set(String tag, String key, dynamic options);
  String get(String tag, dynamic options);
  Future<void> del(String tag, dynamic options);
}
