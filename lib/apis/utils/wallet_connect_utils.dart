import 'dart:io';

import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/models/basic_errors.dart';

class WalletConnectUtils {
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
    return 'unknown'; // TODO: implement
  }

  static String formatUA(
    String protocol,
    int version,
    String sdkVersion,
  ) {
    String os = getOS();
    String id = getId();
    return <String>[
      [protocol, version].join('-'),
      <String>['Dart', sdkVersion].join('-'),
      os,
      id,
    ].join('/');
  }

  static String formatRelayRpcUrl({
    required String protocol,
    required int version,
    required String relayUrl,
    required String sdkVersion,
    required String auth,
    String? projectId,
  }) {
    final Uri uri = Uri.parse(relayUrl);
    final Map<String, String> queryParams = Uri.splitQueryString(uri.query);
    String ua = formatUA(
      protocol,
      version,
      sdkVersion,
    );

    final Map<String, String> relayParams = {
      'auth': auth,
      if (projectId != null && projectId.isNotEmpty) 'projectId': projectId,
      'ua': ua,
    };
    queryParams.addAll(relayParams);
    return uri.replace(queryParameters: queryParams).toString();
  }

  /// ---- URI HANDLING --- ///

  static Map<String, dynamic> parseUri(Uri uri) {
    Map<String, dynamic> ret = {};
    String protocol = uri.scheme;
    String path = uri.path;
    int at = path.indexOf('@');
    if (at == -1) {
      throw Error(-1, 'Invalid URI: Missing @');
    }
    ret['protocol'] = protocol;
    ret['topic'] = path.substring(0, at);
    ret['version'] = path.substring(at + 1);
    ret['symKey'] = uri.queryParameters['symKey']!;
    ret['relay'] = Relay(
      uri.queryParameters['relay-protocol']!,
      data: uri.queryParameters.containsKey('relay-data')
          ? uri.queryParameters['relay-data']
          : null,
    );
    // print(ret);
    return ret;
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

    return Uri(
        scheme: protocol, path: '$topic@$version', queryParameters: params);
  }

  static Map<String, T> convertMapTo<T>(Map<String, dynamic> inMap) {
    Map<String, T> m = {};
    for (var entry in inMap.entries) {
      m[entry.key] = entry.value as T;
    }
    return m;
  }
}
