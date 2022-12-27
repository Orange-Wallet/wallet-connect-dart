// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WcPairingDeleteRequest _$WcPairingDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    WcPairingDeleteRequest(
      json['code'] as int,
      json['message'] as String,
    );

Map<String, dynamic> _$WcPairingDeleteRequestToJson(
        WcPairingDeleteRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

WcPairingPingRequest _$WcPairingPingRequestFromJson(
        Map<String, dynamic> json) =>
    WcPairingPingRequest(
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcPairingPingRequestToJson(
        WcPairingPingRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionProposeRequest _$WcSessionProposeRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionProposeRequest(
      (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionProposeRequestToJson(
        WcSessionProposeRequest instance) =>
    <String, dynamic>{
      'relays': instance.relays,
      'requiredNamespaces': instance.requiredNamespaces,
      'proposer': instance.proposer,
    };

WcSessionSettleRequest _$WcSessionSettleRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionSettleRequest(
      Relay.fromJson(json['relay'] as Map<String, dynamic>),
      Namespaces.fromJson(json['namespaces'] as Map<String, dynamic>),
      json['expiry'] as int,
      ConnectionMetadata.fromJson(json['controller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionSettleRequestToJson(
        WcSessionSettleRequest instance) =>
    <String, dynamic>{
      'relay': instance.relay,
      'namespaces': instance.namespaces,
      'expiry': instance.expiry,
      'controller': instance.controller,
    };

WcSessionUpdateRequest _$WcSessionUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionUpdateRequest(
      Namespaces.fromJson(json['namespaces'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionUpdateRequestToJson(
        WcSessionUpdateRequest instance) =>
    <String, dynamic>{
      'namespaces': instance.namespaces,
    };

WcSessionExtendRequest _$WcSessionExtendRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionExtendRequest(
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcSessionExtendRequestToJson(
        WcSessionExtendRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionDeleteRequest _$WcSessionDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionDeleteRequest(
      json['code'] as int,
      json['message'] as String,
    );

Map<String, dynamic> _$WcSessionDeleteRequestToJson(
        WcSessionDeleteRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

WcSessionPingRequest _$WcSessionPingRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionPingRequest(
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcSessionPingRequestToJson(
        WcSessionPingRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionRequestRequest _$WcSessionRequestRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionRequestRequest(
      json['method'] as String,
      json['params'],
      json['chainId'] as String,
    );

Map<String, dynamic> _$WcSessionRequestRequestToJson(
        WcSessionRequestRequest instance) =>
    <String, dynamic>{
      'method': instance.method,
      'params': instance.params,
      'chainId': instance.chainId,
    };

WcSessionEventRequest _$WcSessionEventRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionEventRequest(
      json['name'] as String,
      json['data'],
      json['chainId'] as String,
    );

Map<String, dynamic> _$WcSessionEventRequestToJson(
        WcSessionEventRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
      'chainId': instance.chainId,
    };
