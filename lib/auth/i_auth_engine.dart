import 'package:wallet_connect/auth/i_auth_engine_app.dart';
import 'package:wallet_connect/auth/i_auth_engine_wallet.dart';

abstract class IAuthEngine implements IAuthEngineWallet, IAuthEngineApp {}
