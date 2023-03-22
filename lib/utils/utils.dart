class Utils {
  static String generateNonce() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}