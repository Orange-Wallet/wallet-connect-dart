abstract class IKeyChain {
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
  String get(
    String tag, {
    dynamic options,
  });
  Future<void> delete(
    String tag, {
    dynamic options,
  });
}
