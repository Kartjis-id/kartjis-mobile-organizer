// Dart imports:
import 'dart:convert';
import 'dart:math' as math;

// Package imports:
import 'package:http/http.dart';
import 'package:http_interceptor/models/retry_policy.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/api_config.dart';
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/helpers/credential_saver.dart';
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
    if (response.statusCode == 401) {
      await _refreshToken();

      return true;
    }

    return false;
  }

  @override
  Duration delayRetryAttemptOnResponse({required int retryAttempt}) {
    return const Duration(milliseconds: 250) * math.pow(2, retryAttempt);
  }

  Future<void> _refreshToken() async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/refresh'),
        body: jsonEncode({
          'refreshToken': CredentialSaver.token?.refreshToken,
        }),
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final token = Token.fromJson(result);

        CredentialSaver.token = token;

        await authPreferences.setToken(token);
      } else {
        throw ServerException("${result['message']}");
      }
    } catch (e) {
      exception(e);
    }
  }
}
