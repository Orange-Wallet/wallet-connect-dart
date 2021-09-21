import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'wc_session_update.g.dart';

@JsonSerializable()
class WCSessionUpdate {
  final bool approved;
  final int chainId;
  final List<String> accounts;
  WCSessionUpdate({
    @required this.approved,
    this.chainId,
    this.accounts,
  });

  factory WCSessionUpdate.fromJson(Map<String, dynamic> json) =>
      _$WCSessionUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$WCSessionUpdateToJson(this);

  @override
  String toString() =>
      'WCSessionUpdate(approved: $approved, chainId: $chainId, accounts: $accounts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WCSessionUpdate &&
        other.approved == approved &&
        other.chainId == chainId &&
        listEquals(other.accounts, accounts);
  }

  @override
  int get hashCode => approved.hashCode ^ chainId.hashCode ^ accounts.hashCode;
}
