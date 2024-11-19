// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/utils/const.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';

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
    final pr = await preferences;

    return await pr.remove(tokenKey);
  }
}
