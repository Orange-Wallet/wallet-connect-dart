import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/generic_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/proposal_models.dart';

part 'session_models.g.dart';

class SessionProposalCompleter {
  String selfPublicKey;
  String pairingTopic;
  Map<String, RequiredNamespace> requiredNamespaces;
  Completer completer;

  SessionProposalCompleter(
    this.selfPublicKey,
    this.pairingTopic,
    this.requiredNamespaces,
    this.completer,
  );
}

@JsonSerializable()
class BaseNamespace {
  final List<String> accounts;
  final List<String> methods;
  final List<String> events;

  BaseNamespace({
    required this.accounts,
    required this.methods,
    required this.events,
  });

  factory BaseNamespace.fromJson(Map<String, dynamic> json) =>
      _$BaseNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$BaseNamespaceToJson(this);

  @override
  bool operator ==(Object other) {
    return other is BaseNamespace && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      accounts.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      methods.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      events.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      );
}

@JsonSerializable()
class Namespace extends BaseNamespace {
  final List<BaseNamespace> extension;

  Namespace({
    required List<String> accounts,
    required List<String> methods,
    List<String> events = const [],
    this.extension = const [],
  }) : super(
          accounts: accounts,
          methods: methods,
          events: events,
        );

  factory Namespace.fromJson(Map<String, dynamic> json) =>
      _$NamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$NamespaceToJson(this);

  @override
  bool operator ==(Object other) {
    return other is Namespace && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      super.hashCode +
      extension.fold<int>(
        0,
        (previousValue, element) => previousValue + element.hashCode,
      );
}

@JsonSerializable()
class SessionData {
  String topic;
  Relay relay;
  int expiry;
  bool acknowledged;
  String controller;
  Map<String, Namespace> namespaces;
  Map<String, RequiredNamespace>? requiredNamespaces;
  ConnectionMetadata self;
  ConnectionMetadata peer;

  SessionData({
    required this.topic,
    required this.relay,
    required this.expiry,
    required this.acknowledged,
    required this.controller,
    required this.namespaces,
    required this.self,
    required this.peer,
    this.requiredNamespaces,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);
}
