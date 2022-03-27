// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCSessionStore _$$_WCSessionStoreFromJson(Map<String, dynamic> json) =>
    _$_WCSessionStore(
      session: WCSession.fromJson(json['session'] as Map<String, dynamic>),
      peerMeta: WCPeerMeta.fromJson(json['peerMeta'] as Map<String, dynamic>),
      remotePeerMeta:
          WCPeerMeta.fromJson(json['remotePeerMeta'] as Map<String, dynamic>),
      chainId: json['chainId'] as int,
      peerId: json['peerId'] as String,
      remotePeerId: json['remotePeerId'] as String,
    );

Map<String, dynamic> _$$_WCSessionStoreToJson(_$_WCSessionStore instance) =>
    <String, dynamic>{
      'session': instance.session.toJson(),
      'peerMeta': instance.peerMeta.toJson(),
      'remotePeerMeta': instance.remotePeerMeta.toJson(),
      'chainId': instance.chainId,
      'peerId': instance.peerId,
      'remotePeerId': instance.remotePeerId,
    };
