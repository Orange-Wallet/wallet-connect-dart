import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

enum WCSignType { MESSAGE, PERSONAL_MESSAGE, TYPED_MESSAGE }

class WCEthereumSignMessage {
  final List<String> raw;
  final WCSignType type;
  WCEthereumSignMessage({
    @required this.raw,
    @required this.type,
  });

  String get data {
    switch (type) {
      case WCSignType.MESSAGE:
        return raw[1];
      case WCSignType.TYPED_MESSAGE:
        return raw[1];
      case WCSignType.PERSONAL_MESSAGE:
        return raw[0];
      default:
        return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WCEthereumSignMessage &&
        listEquals(other.raw, raw) &&
        other.type == type;
  }

  @override
  int get hashCode => raw.hashCode ^ type.hashCode;

  @override
  String toString() => 'WCEthereumSignMessage(raw: $raw, type: $type)';
}
