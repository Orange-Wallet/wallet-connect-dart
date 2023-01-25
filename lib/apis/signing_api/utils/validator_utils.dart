import 'package:wallet_connect_v2_dart/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/utils/namespace_utils.dart';
import 'package:wallet_connect_v2_dart/apis/utils/errors.dart';

class ValidatorUtils {
  static bool isSessionCompatible(SessionData session, FindParams params) {
    Map<String, RequiredNamespace> requiredNamespaces =
        params.requiredNamespaces;
    List<String> sessionKeys = session.namespaces.keys.toList();
    List<String> paramsKeys = requiredNamespaces.keys.toList();
    bool compatible = true;

    if (!hasOverlap(paramsKeys, sessionKeys)) return false;

    sessionKeys.forEach((key) {
      Namespace namespace = session.namespaces[key]!;
      List<String> accounts = namespace.accounts;
      List<dynamic> methods = namespace.methods;
      List<dynamic> events = namespace.events;
      List<BaseNamespace>? extension = namespace.extension;
      List<String> chains = NamespaceUtils.getAccountsChains(accounts);
      RequiredNamespace requiredNamespace = requiredNamespaces[key]!;

      if (!hasOverlap(requiredNamespace.chains, chains) ||
          !hasOverlap(requiredNamespace.methods, methods) ||
          !hasOverlap(requiredNamespace.events, events)) {
        compatible = false;
      }

      if (compatible && extension != null) {
        extension.forEach((extensionNamespace) {
          if (requiredNamespace.extension != null) {
            List<String> accounts = extensionNamespace.accounts;
            List<dynamic> methods = extensionNamespace.methods;
            List<dynamic> events = extensionNamespace.events;
            List<String> chains = NamespaceUtils.getAccountsChains(accounts);

            bool overlap = requiredNamespace.extension!.any((ext) =>
                hasOverlap(ext.chains, chains) &&
                hasOverlap(ext.methods, methods) &&
                hasOverlap(ext.events, events));
            if (!overlap) {
              compatible = false;
            }
          } else {
            compatible = false;
          }
        });
      }
    });

    return compatible;
  }

  static bool isValidChainId(String value) {
    if (value.contains(":")) {
      List<String> split = value.split(":");
      return split.length == 2;
    }
    return false;
  }

  static bool isValidAccountId(String value) {
    if (value.contains(":")) {
      List<String> split = value.split(":");
      if (split.length == 3) {
        String chainId = split[0] + ":" + split[1];
        return split.length >= 2 && isValidChainId(chainId);
      }
    }
    return false;
  }

  static bool isValidUrl(String value) {
    try {
      Uri url = Uri.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidChains(
    String key,
    List<String> chains,
    String context,
  ) {
    for (String c in chains) {
      if (!isValidChainId(c) || !c.contains(key)) {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context:
              '$context, chain $c should be a string and conform to "namespace:chainId" format',
        );
      }
    }
    return true;
  }

  static bool isValidNamespaceChains(
    Map<String, RequiredNamespace> namespaces,
    String method,
  ) {
    namespaces.forEach((key, namespace) {
      isValidChains(key, namespace.chains, '$method requiredNamespace');

      if (namespace.extension != null) {
        for (var ext in namespace.extension!) {
          isValidChains(key, ext.chains, '$method extension');
        }
      }
    });

    return true;
  }

  static bool isValidAccounts(
    List<String> accounts,
    String context,
  ) {
    for (String account in accounts) {
      if (!isValidAccountId(account)) {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_ACCOUNTS,
          context:
              '$context, account $account should be a string and conform to "namespace:chainId:address" format',
        );
      }
    }

    return true;
  }

  static bool isValidNamespaceAccounts(
    Map<String, Namespace> namespaces,
    String method,
  ) {
    namespaces.forEach((key, namespace) {
      isValidAccounts(namespace.accounts, '$method namespace');

      if (namespace.extension != null) {
        for (var ext in namespace.extension!) {
          isValidAccounts(ext.accounts, '$method namespace');
        }
      }
    });

    return true;
  }

  static bool isValidRequiredNamespaces(
    Map<String, RequiredNamespace> input,
    String method,
  ) {
    return isValidNamespaceChains(input, method);
  }

  static bool isValidNamespaces(
    Map<String, Namespace> input,
    String method,
  ) {
    return isValidNamespaceAccounts(input, method);
  }

  static bool isValidNamespacesChainId(
    Map<String, Namespace> namespaces,
    String chainId,
  ) {
    if (!isValidChainId(chainId)) {
      return false;
    }
    List<String> chains = NamespaceUtils.getNamespacesChains(namespaces);
    if (!chains.contains(chainId)) {
      return false;
    }

    return true;
  }

  static bool isValidNamespacesRequest(
    Map<String, Namespace> namespaces,
    String chainId,
    String method,
  ) {
    List<dynamic> methods = NamespaceUtils.getNamespacesMethodsForChainId(
      namespaces,
      chainId,
    );
    return methods.contains(method);
  }

  static bool isValidNamespacesEvent(
    Map<String, Namespace> namespaces,
    String chainId,
    String eventName,
  ) {
    List<dynamic> methods = NamespaceUtils.getNamespacesEventsForChainId(
      namespaces,
      chainId,
    );
    return methods.contains(eventName);
  }

  static void isConformingNamespaces(
    Map<String, RequiredNamespace> requiredNamespaces,
    Map<String, Namespace> namespaces,
    String context,
  ) {
    List<String> requiredNamespaceKeys = requiredNamespaces.keys.toList();
    List<String> namespaceKeys = namespaces.keys.toList();

    if (!hasOverlap(requiredNamespaceKeys, namespaceKeys)) {
      throw Errors.getInternalError(
        Errors.NON_CONFORMING_NAMESPACES,
        context: "$context namespaces keys don't satisfy requiredNamespaces",
      );
    } else {
      requiredNamespaceKeys.forEach((key) {
        List<dynamic> requiredNamespaceChains = requiredNamespaces[key]!.chains;
        List<dynamic> namespaceChains = NamespaceUtils.getAccountsChains(
          namespaces[key]!.accounts,
        );

        if (!hasOverlap(requiredNamespaceChains, namespaceChains)) {
          throw Errors.getInternalError(
            Errors.NON_CONFORMING_NAMESPACES,
            context:
                "$context namespaces accounts don't satisfy requiredNamespaces chains for $key",
          );
        } else if (!hasOverlap(
            requiredNamespaces[key]!.methods, namespaces[key]!.methods)) {
          throw Errors.getInternalError(
            Errors.NON_CONFORMING_NAMESPACES,
            context:
                "$context namespaces methods don't satisfy requiredNamespaces methods for $key",
          );
        } else if (!hasOverlap(
            requiredNamespaces[key]!.events, namespaces[key]!.events)) {
          throw Errors.getInternalError(
            Errors.NON_CONFORMING_NAMESPACES,
            context:
                "$context namespaces events don't satisfy requiredNamespaces events for $key",
          );
        }

        // Check each required extension
        if (requiredNamespaces[key]!.extension != null) {
          for (var requiredExt in requiredNamespaces[key]!.extension!) {
            // Make sure that some extension in the namespaces satisfies it
            if (namespaces[key]!.extension != null) {
              for (var ext in namespaces[key]!.extension!) {
                List<dynamic> accChains = NamespaceUtils.getAccountsChains(
                  ext.accounts,
                );
                // If the required extension is satisfied, break out of the loop so we don't throw
                if (hasOverlap(requiredExt.chains, accChains) &&
                    hasOverlap(requiredExt.events, ext.events) &&
                    hasOverlap(requiredExt.methods, ext.methods)) {
                  break;
                }
              }
            }

            throw Errors.getInternalError(
              Errors.NON_CONFORMING_NAMESPACES,
              context:
                  "$context namespaces extension doesn't satisfy requiredNamespaces extension for $key",
            );
          }
        }
      });
    }
  }

  static bool hasOverlap(List<dynamic> a, List<dynamic> b) {
    List<dynamic> matches = a.where((x) => b.contains(x)).toList();
    return matches.length == a.length;
  }
}
