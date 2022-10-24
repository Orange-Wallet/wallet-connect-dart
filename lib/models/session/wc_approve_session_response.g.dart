// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_approve_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCApproveSessionResponse _$WCApproveSessionResponseFromJson(
        Map<String, dynamic> json) =>
    WCApproveSessionResponse(
      approved: json['approved'] as bool? ?? true,
      chainId: json['chainId'] as int?,
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      peerId: json['peerId'] as String,
      peerMeta: WCPeerMeta.fromJson(json['peerMeta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WCApproveSessionResponseToJson(
        WCApproveSessionResponse instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'chainId': instance.chainId,
      'accounts': instance.accounts,
      'peerId': instance.peerId,
      'peerMeta': instance.peerMeta,
    };
