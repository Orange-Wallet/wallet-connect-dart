const JSONRPC_VERSION = '2.0';

/// Wallet Connect Constants
const CORE_PROTOCOL = 'wc';
const CORE_VERSION = 2;
const CORE_CONTEXT = 'core';

const DEFAULT_RELAY_URL = 'wss://relay.walletconnect.org';

const CORE_STORAGE_PREFIX = '$CORE_PROTOCOL@$CORE_VERSION:$CORE_CONTEXT:';

const THIRTY_SECONDS = 30;
const ONE_MINUTE = 60;
const FIVE_MINUTES = ONE_MINUTE * 5;
const ONE_HOUR = ONE_MINUTE * 60;
const ONE_DAY = ONE_MINUTE * 24 * 60;
const SEVEN_DAYS = ONE_DAY * 7;
const THIRTY_DAYS = ONE_DAY * 30;

const RELAYER_DEFAULT_PROTOCOL = 'irn';
const SDK_VERSION = '2.1.3';

/// Sign
const String CONTEXT_PROPOSALS = 'proposals';
const String VERSION_PROPOSALS = '1.0';

const String CONTEXT_PENDING_REQUESTS = 'pendingRequests';
const String VERSION_PENDING_REQUESTS = '1.0';

/// Auth
const AUTH_REQUEST_EXPIRY_MIN = FIVE_MINUTES;
const AUTH_REQUEST_EXPIRY_MAX = SEVEN_DAYS;

const AUTH_DEFAULT_URL = 'https://rpc.walletconnect.com/v1';

const AUTH_CLIENT_PUBLIC_KEY_NAME = 'PUB_KEY';

const CONTEXT_AUTH_KEYS = 'authKeys';
const VERSION_AUTH_KEYS = '2.0';
const CONTEXT_PAIRING_TOPICS = 'authPairingTopics';
const VERSION_PAIRING_TOPICS = '2.0';
const CONTEXT_AUTH_REQUESTS = 'authRequests';
const VERSION_AUTH_REQUESTS = '2.0';
const CONTEXT_COMPLETE_REQUESTS = 'completeRequests';
const VERSION_COMPLETE_REQUESTS = '2.1';