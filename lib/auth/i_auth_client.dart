import 'package:wallet_connect/auth/i_auth_engine.dart';

abstract class IAuthClient extends IAuthEngine {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IAuthEngine engine;
}
