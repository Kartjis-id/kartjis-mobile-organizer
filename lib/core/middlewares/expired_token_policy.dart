// Dart imports:
import 'dart:convert';
import 'dart:math' as math;

// Package imports:
import 'package:http/http.dart';
import 'package:http_interceptor/models/retry_policy.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/api_config.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_token_saver.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final Client client;
  final AuthPreferences authPreferences;

  ExpiredTokenRetryPolicy({
    required this.client,
    required this.authPreferences,
  });

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401 && response.request?.url.path != '/api/auth/token') {
      await _refreshToken();

      return true;
    }

    return false;
  }

  @override
  Duration delayRetryAttemptOnResponse({required int retryAttempt}) {
    return const Duration(milliseconds: 250) * math.pow(2, retryAttempt);
  }

  @override
  int get maxRetryAttempts => 2;

  Future<void> _refreshToken() async {
    final headers = {
      'content-type': 'application/json',
      'authorization': 'Bearer ${AuthTokenSaver.token?.accessToken}',
    };

    final body = jsonEncode({
      'accessToken': AuthTokenSaver.token?.accessToken,
      'refreshToken': AuthTokenSaver.token?.refreshToken,
    });

    final response = await client.post(
      ApiConfig.url('/auth/refresh'),
      headers: headers,
      body: body,
    );

    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      final token = Token.fromJson(result);

      await authPreferences.setToken(token);
    }
  }
}
