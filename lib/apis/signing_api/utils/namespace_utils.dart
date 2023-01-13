import 'package:wallet_connect_v2_dart/apis/signing_api/models/session_models.dart';

class NamespaceUtils {
  static List<String> getAccountsChains(List<String> accounts) {
    List<String> chains = [];
    accounts.forEach((account) {
      List<String> parts = account.split(":");
      String chain = parts[0];
      String chainId = parts[1];
      chains.add("$chain:$chainId");
    });

    return chains;
  }

  static List<String> getNamespacesChains(Map<String, Namespace> namespaces) {
    List<String> chains = [];

    namespaces.values.forEach((namespace) {
      chains.addAll(getAccountsChains(namespace.accounts));

      namespace.extension.forEach((extension) {
        chains.addAll(getAccountsChains(extension.accounts));
      });
    });

    return chains;
  }

  static List<dynamic> getNamespacesMethodsForChainId(
    Map<String, Namespace> namespaces,
    String chainId,
  ) {
    List<dynamic> methods = [];
    namespaces.values.forEach((namespace) {
      List<String> chains = getAccountsChains(namespace.accounts);
      if (chains.contains(chainId)) methods.addAll(namespace.methods);

      namespace.extension.forEach((extension) {
        List<String> extensionChains = getAccountsChains(extension.accounts);
        if (extensionChains.contains(chainId))
          methods.addAll(extension.methods);
      });
    });

    return methods;
  }

  static List<dynamic> getNamespacesEventsForChainId(
    Map<String, Namespace> namespaces,
    String chainId,
  ) {
    List<dynamic> events = [];
    namespaces.values.forEach((namespace) {
      List<String> chains = getAccountsChains(namespace.accounts);
      if (chains.contains(chainId)) events.addAll(namespace.events);

      namespace.extension.forEach((extension) {
        List<String> extensionChains = getAccountsChains(extension.accounts);
        if (extensionChains.contains(chainId)) events.addAll(extension.events);
      });
    });

    return events;
  }
}
