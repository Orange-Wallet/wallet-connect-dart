import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_connect/models/message_type.dart';

part 'wc_socket_message.freezed.dart';
part 'wc_socket_message.g.dart';

@immutable
@freezed
class WCSocketMessage with _$WCSocketMessage {
  factory WCSocketMessage({
    required String topic,
    required MessageType type,
    required String payload,
  }) = _WCSocketMessage;

  factory WCSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WCSocketMessageFromJson(json);
}
