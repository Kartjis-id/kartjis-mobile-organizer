// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/api_config.dart';
import 'package:kartjis_mobile_organizer/core/errors/exceptions.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/core/helpers/credential_saver.dart';
import 'package:kartjis_mobile_organizer/core/helpers/http_client.dart' as http_client;

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSourceImpl(
    client: http_client.HttpClient().client,
    authPreferences: AuthPreferences(),
  ),
);

sealed class AuthDataSource {
  /// Sign in
  Future<bool> signIn({
    required String username,
    required String password,
  });

  /// Log out
  Future<bool> logOut();
}

final class AuthDataSourceImpl implements AuthDataSource {
  final Client client;
  final AuthPreferences authPreferences;

  AuthDataSourceImpl({
    required this.client,
    required this.authPreferences,
  });

  @override
  Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/token'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
        },
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());

        CredentialSaver.accessToken = result['accessToken'];

        return await authPreferences.setAccessToken(result['accessToken']);
      } else {
        throw ServerException("${result['message']}");
      }
    } catch (e) {
      exception(e);
    }
  }

  @override
  Future<bool> logOut() async {
    final result = await authPreferences.removeAccessToken();

    CredentialSaver.accessToken = null;

    return result;
  }
}
