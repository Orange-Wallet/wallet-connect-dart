// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WcPairingDeleteRequest _$WcPairingDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    WcPairingDeleteRequest(
      code: json['code'] as int,
      message: json['message'] as String,
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
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcPairingPingRequestToJson(
        WcPairingPingRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionProposeRequest _$WcSessionProposeRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionProposeRequest(
      id: json['id'] as int,
      relays: (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      proposer:
          ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionProposeRequestToJson(
        WcSessionProposeRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relays': instance.relays,
      'requiredNamespaces': instance.requiredNamespaces,
      'proposer': instance.proposer,
    };

WcSessionProposeResponse _$WcSessionProposeResponseFromJson(
        Map<String, dynamic> json) =>
    WcSessionProposeResponse(
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      responderPublicKey: json['responderPublicKey'] as String,
    );

Map<String, dynamic> _$WcSessionProposeResponseToJson(
        WcSessionProposeResponse instance) =>
    <String, dynamic>{
      'relay': instance.relay,
      'responderPublicKey': instance.responderPublicKey,
    };

WcSessionSettleRequest _$WcSessionSettleRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionSettleRequest(
      id: json['id'] as int,
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      expiry: json['expiry'] as int,
      controller: ConnectionMetadata.fromJson(
          json['controller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionSettleRequestToJson(
        WcSessionSettleRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relay': instance.relay,
      'namespaces': instance.namespaces,
      'requiredNamespaces': instance.requiredNamespaces,
      'expiry': instance.expiry,
      'controller': instance.controller,
    };

WcSessionUpdateRequest _$WcSessionUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionUpdateRequest(
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$WcSessionUpdateRequestToJson(
        WcSessionUpdateRequest instance) =>
    <String, dynamic>{
      'namespaces': instance.namespaces,
    };

WcSessionExtendRequest _$WcSessionExtendRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionExtendRequest(
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcSessionExtendRequestToJson(
        WcSessionExtendRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionDeleteRequest _$WcSessionDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionDeleteRequest(
      code: json['code'] as int,
      message: json['message'] as String,
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
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcSessionPingRequestToJson(
        WcSessionPingRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionRequestRequest _$WcSessionRequestRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionRequestRequest(
      chainId: json['chainId'] as String,
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$WcSessionRequestRequestToJson(
        WcSessionRequestRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'method': instance.method,
      'params': instance.params,
    };

WcSessionEventRequest _$WcSessionEventRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionEventRequest(
      name: json['name'] as String,
      data: json['data'],
      chainId: json['chainId'] as String,
    );

Map<String, dynamic> _$WcSessionEventRequestToJson(
        WcSessionEventRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
      'chainId': instance.chainId,
    };
