import 'package:wallet_connect/auth/i_auth_engine.dart';
import 'package:wallet_connect/auth/i_auth_engine_wallet.dart';
import 'package:wallet_connect/sign/i_sign_engine.dart';
import 'package:wallet_connect/sign/i_sign_engine_wallet.dart';

abstract class IWeb3Wallet implements ISignEngineWallet, IAuthEngineWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final ISignEngine signEngine;
  abstract final IAuthEngine authEngine;
}
