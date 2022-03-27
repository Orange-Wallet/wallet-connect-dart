// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCSessionUpdate _$$_WCSessionUpdateFromJson(Map<String, dynamic> json) =>
    _$_WCSessionUpdate(
      approved: json['approved'] as bool,
      chainId: json['chainId'] as int?,
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_WCSessionUpdateToJson(_$_WCSessionUpdate instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'chainId': instance.chainId,
      'accounts': instance.accounts,
    };
