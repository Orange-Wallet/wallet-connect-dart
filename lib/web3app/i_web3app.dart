import 'package:wallet_connect/auth/i_auth_engine.dart';
import 'package:wallet_connect/auth/i_auth_engine_app.dart';
import 'package:wallet_connect/sign/i_sign_engine.dart';
import 'package:wallet_connect/sign/i_sign_engine_app.dart';

abstract class IWeb3App implements ISignEngineApp, IAuthEngineApp {
  final String protocol = 'wc';
  final int version = 2;

  abstract final ISignEngine signEngine;
  abstract final IAuthEngine authEngine;
}
