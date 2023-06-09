import 'package:wallet_connect/core/store/i_store_user.dart';
import 'package:wallet_connect/sign/models/proposal_models.dart';

abstract class IProposals extends IStoreUser {
  Future<void> init();
  bool has(String id);
  Future<void> set(String id, ProposalData value);
  ProposalData? get(String id);
  List<ProposalData> getAll();
  Future<void> delete(String id);
}
