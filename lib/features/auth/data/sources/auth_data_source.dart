// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/api_config.dart';
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/helpers/http_client.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/user.dart';

final authDataSourceProvider = Provider.autoDispose<AuthDataSource>(
  (ref) => AuthDataSourceImpl(
    client: ref.watch(interceptedClientProvider),
    authPreferences: ref.watch(authPreferencesProvider),
  ),
);

sealed class AuthDataSource {
  /// Login
  Future<bool> login({
    required String username,
    required String password,
  });

  /// Get user info
  Future<User> getUserInfo();

  /// Is already login
  Future<bool> isAlreadyLogin();

  /// Logout
  Future<bool> logout();
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
      final headers = {'authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}'};

      final response = await client.post(
        ApiConfig.url('/auth/token'),
        headers: headers,
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return await authPreferences.setToken(Token.fromJson(result));
      } else {
        throw ServerException("${result['message']}");
      }
    } catch (e) {
      exception(e);
    }
  }

  @override
  Future<User> getUserInfo() async {
    try {
      final response = await client.post(ApiConfig.url('/auth/userinfo'));

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return User.fromJson(result);
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

    return token != null;
  }

  @override
  Future<bool> logout() async {
    final result = await authPreferences.removeToken();

    return result;
  }
}
