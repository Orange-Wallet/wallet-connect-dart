import 'package:freezed_annotation/freezed_annotation.dart';

part 'wc_session_update.freezed.dart';
part 'wc_session_update.g.dart';

@immutable
@freezed
class WCSessionUpdate with _$WCSessionUpdate {
  factory WCSessionUpdate({
    required bool approved,
    int? chainId,
    List<String>? accounts,
  }) = _WCSessionUpdate;

  factory WCSessionUpdate.fromJson(Map<String, dynamic> json) =>
      _$WCSessionUpdateFromJson(json);
}
