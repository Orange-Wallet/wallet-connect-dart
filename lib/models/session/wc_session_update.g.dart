// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCSessionUpdate _$WCSessionUpdateFromJson(Map<String, dynamic> json) =>
    WCSessionUpdate(
      approved: json['approved'] as bool,
      chainId: json['chainId'] as int?,
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WCSessionUpdateToJson(WCSessionUpdate instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'chainId': instance.chainId,
      'accounts': instance.accounts,
    };
