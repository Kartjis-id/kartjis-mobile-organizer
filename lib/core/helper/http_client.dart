// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' show Client;
import 'package:http_interceptor/http/intercepted_client.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connection/network_info.dart';
import 'package:kartjis_mobile_organizer/core/helper/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/middleware/client_interceptor.dart';
import 'package:kartjis_mobile_organizer/core/middleware/expired_token_policy.dart';

final httpClientProvider = Provider<HttpClient>(
  (ref) => HttpClient(),
);

final interceptedClientProvider = Provider<Client>(
  (ref) => InterceptedClient.build(
    client: ref.watch(httpClientProvider).client,
    interceptors: [
      ClientInterceptor(
        networkInfo: ref.watch(networkInfoProvider),
      ),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(
      client: ref.watch(httpClientProvider).client,
      authPreferences: ref.watch(authPreferencesProvider),
    ),
  ),
);

class HttpClient {
  HttpClient._instance();

  static final HttpClient _httpClient = HttpClient._instance();

  factory HttpClient() => _httpClient;

  Client? _client;

  Client get client => _client ??= Client();
}
