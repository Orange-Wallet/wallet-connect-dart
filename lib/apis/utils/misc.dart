import 'dart:io';

import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';

class MiscUtils {
  static bool isExpired(int expiry) {
    return DateTime.now().toUtc().compareTo(
              DateTime.fromMillisecondsSinceEpoch(
                toMilliseconds(expiry),
              ),
            ) >=
        0;
  }

  static int toMilliseconds(int seconds) {
    return seconds * 1000;
  }

  static int calculateExpiry(int offset) {
    return DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000 + offset;
  }

  static String getOS() {
    return <String>[Platform.operatingSystem, Platform.operatingSystemVersion]
        .join('-');
  }

  static String getId() {
    return Platform.environment.values.join(':');
  }

  static String formatUA(
    String protocol,
    String version,
    String sdkVersion,
  ) {
    String os = getOS();
    String id = getId();
    return <String>[
      <String>[protocol, version].join('-'),
      <String>['FLUTTER', sdkVersion].join('-'),
      os,
      id,
    ].join('/');
  }

  /// ---- URI HANDLING --- ///

  static Map<String, dynamic> parseUri(Uri uri) {
    Map<String, dynamic> ret = {};
    String path = uri.path;
    int colon = path.indexOf('%3A');
    int at = path.indexOf('@');
    ret['protocol'] = path.substring(0, colon);
    ret['topic'] = path.substring(colon + 3, at);
    ret['version'] = path.substring(at + 1);
    ret['relay'] = Relay(
      uri.queryParameters['relay-protocol']!,
      data: uri.queryParameters.containsKey('relay-data')
          ? uri.queryParameters['relay-data']
          : null,
    );
    print(ret);
    return ret;
  }

  static String formatRelayRpcUrl(
    String protocol,
    String version,
    String relayUrl,
    String sdkVersion,
    String auth,
    String projectId,
  ) {
    List<String> splitUrl = relayUrl.split('?');
    String ua = formatUA(
      protocol,
      version,
      sdkVersion,
    );
    String params = splitUrl.length > 1 ? splitUrl[1] : '';
    String queryString = '$params&$auth&$ua&$projectId';
    return '${splitUrl[0]}?$queryString';
  }

  static Map<String, String> formatRelayParams(
    Relay relay, {
    String delimiter = '-',
  }) {
    Map<String, String> params = {};
    params[['relay', 'protocol'].join(delimiter)] = relay.protocol;
    if (relay.data != null) {
      params[['relay', 'data'].join(delimiter)] = relay.data!;
    }
    return params;
  }

  static Uri formatUri(
    String protocol,
    String version,
    String topic,
    String symKey,
    Relay relay,
  ) {
    Map<String, String> params = formatRelayParams(relay);
    params['symKey'] = symKey;

    return Uri(path: '$protocol:$topic@$version', queryParameters: params);
  }

  static Map<String, T> convertMapTo<T>(Map<String, dynamic> inMap) {
    Map<String, T> m = {};
    for (var entry in inMap.entries) {
      m[entry.key] = entry.value as T;
    }
    return m;
  }
}
