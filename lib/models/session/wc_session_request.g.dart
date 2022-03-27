// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCSessionRequest _$$_WCSessionRequestFromJson(Map<String, dynamic> json) =>
    _$_WCSessionRequest(
      peerId: json['peerId'] as String,
      peerMeta: WCPeerMeta.fromJson(json['peerMeta'] as Map<String, dynamic>),
      chainId: json['chainId'] as int?,
    );

Map<String, dynamic> _$$_WCSessionRequestToJson(_$_WCSessionRequest instance) =>
    <String, dynamic>{
      'peerId': instance.peerId,
      'peerMeta': instance.peerMeta.toJson(),
      'chainId': instance.chainId,
    };
