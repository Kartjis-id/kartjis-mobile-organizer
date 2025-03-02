// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' show Client;
import 'package:http_interceptor/http/intercepted_client.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/middlewares/client_interceptor.dart';
import 'package:kartjis_mobile_organizer/core/middlewares/expired_token_policy.dart';

final clientProvider = Provider<Client>(
  (ref) => Client(),
);

final interceptedClientProvider = Provider<Client>(
  (ref) => InterceptedClient.build(
    client: ref.watch(clientProvider),
    interceptors: [
      ClientInterceptor(
        networkInfo: ref.watch(networkInfoProvider),
      ),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(
      client: ref.watch(clientProvider),
      authPreferences: ref.watch(authPreferencesProvider),
    ),
  ),
);
