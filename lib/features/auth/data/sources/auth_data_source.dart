// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/api_config.dart';
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/helpers/credential_saver.dart';
import 'package:kartjis_mobile_organizer/core/helpers/http_client.dart';
import 'package:kartjis_mobile_organizer/core/middlewares/expired_token_policy.dart';
import 'package:kartjis_mobile_organizer/core/middlewares/request_interceptor.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSourceImpl(
    client: InterceptedClient.build(
      interceptors: [
        RequestInterceptor(
          networkInfo: ref.watch(networkInfoProvider),
        ),
      ],
      retryPolicy: ExpiredTokenRetryPolicy(
        client: HttpClient().client,
        authPreferences: AuthPreferences(),
      ),
      client: HttpClient().client,
    ),
    authPreferences: AuthPreferences(),
  ),
);

sealed class AuthDataSource {
  /// Login
  Future<bool> login({
    required String username,
    required String password,
  });

  /// Is already login
  Future<bool> isAlreadyLogin();

  /// Logout
  Future<bool> logout();

  /// Get user credential
  // Future<Profile> getCredential();
}

final class AuthDataSourceImpl implements AuthDataSource {
  final Client client;
  final AuthPreferences authPreferences;

  const AuthDataSourceImpl({
    required this.client,
    required this.authPreferences,
  });

  @override
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/token'),
        headers: {
          HttpHeaders.authorizationHeader: 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
        },
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final token = Token.fromJson(result);

        CredentialSaver.token = token;

        return await authPreferences.setToken(token);
      } else {
        throw ServerException("${result['message']}");
      }
    } catch (e) {
      exception(e);
    }
  }

  @override
  Future<bool> isAlreadyLogin() async {
    final token = await authPreferences.getToken();

    return token != null && CredentialSaver.token != null;
  }

  @override
  Future<bool> logout() async {
    CredentialSaver.token = null;

    final result = await authPreferences.removeToken();

    return result;
  }
}
