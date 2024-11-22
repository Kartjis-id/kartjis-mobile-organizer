// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/auth_token_saver.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';

final authPreferencesProvider = Provider<AuthPreferences>(
  (ref) => AuthPreferences(),
);

class AuthPreferences {
  AuthPreferences._instance();

  static final AuthPreferences _authPreferences = AuthPreferences._instance();

  factory AuthPreferences() => _authPreferences;

  SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  /// Set [Token] to persistent storage
  Future<bool> setToken(Token token) async {
    AuthTokenSaver.token = token;

    final pr = await preferences;

    return await pr.setString(tokenKey, jsonEncode(token.toJson()));
  }

  /// Get [Token] from persistent storage
  Future<Token?> getToken() async {
    final pr = await preferences;

    if (pr.containsKey(tokenKey)) {
      final tokenString = pr.getString(tokenKey) ?? '';

      final tokenJson = jsonDecode(tokenString) as Map<String, dynamic>;

      return Token.fromJson(tokenJson);
    }

    return null;
  }

  /// Remove [Token] from persistent storage
  Future<bool> removeToken() async {
    AuthTokenSaver.token = null;

    final pr = await preferences;

    return await pr.remove(tokenKey);
  }
}
