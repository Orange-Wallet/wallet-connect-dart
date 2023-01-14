import 'package:wallet_connect_v2_dart/apis/core/store/i_store_user.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/proposal_models.dart';

abstract class IProposals extends IStoreUser {
  Future<void> init();
  bool has(String id);
  Future<void> set(String id, ProposalData value);
  // Future<void> update(
  //   String topic, {
  //   int? expiry,
  //   bool? active,
  //   ProposalData? metadata,
  // });
  ProposalData? get(String id);
  List<ProposalData> getAll();
  Future<void> delete(String id);
}
