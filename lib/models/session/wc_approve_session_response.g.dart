// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_approve_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCApproveSessionResponse _$$_WCApproveSessionResponseFromJson(
        Map<String, dynamic> json) =>
    _$_WCApproveSessionResponse(
      approved: json['approved'] as bool? ?? true,
      chainId: json['chainId'] as int?,
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      peerId: json['peerId'] as String,
      peerMeta: WCPeerMeta.fromJson(json['peerMeta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WCApproveSessionResponseToJson(
        _$_WCApproveSessionResponse instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'chainId': instance.chainId,
      'accounts': instance.accounts,
      'peerId': instance.peerId,
      'peerMeta': instance.peerMeta.toJson(),
    };
