// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/api_configs.dart';
import 'package:kartjis_mobile_organizer/core/errors/exceptions.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences_helper.dart';
import 'package:kartjis_mobile_organizer/core/utils/credential_saver.dart';

abstract class AuthDataSource {
  /// Sign in
  Future<bool> signIn({
    required String username,
    required String password,
  });

  /// Log out
  Future<bool> logOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;
  final AuthPreferencesHelper preferencesHelper;

  AuthDataSourceImpl({
    required this.client,
    required this.preferencesHelper,
  });

  @override
  Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${ApiConfigs.baseUrl}/auth/token'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Basic ${base64Encode(utf8.encode('$username:$password'))}',
        },
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());

        CredentialSaver.accessToken = result['accessToken'];

        return await preferencesHelper.setAccessToken(result['accessToken']);
      } else {
        throw ServerException("${result['message']}");
      }
    } catch (e) {
      exception(e);
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      final result = await preferencesHelper.removeAccessToken();

      CredentialSaver.accessToken = null;

      return result;
    } catch (e) {
      throw PreferencesException(e.toString());
    }
  }
}
