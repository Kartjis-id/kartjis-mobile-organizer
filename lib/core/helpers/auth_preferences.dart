// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

class AuthPreferences {
  AuthPreferences._instance();

  static final AuthPreferences _authPreferencesHelper = AuthPreferences._instance();

  factory AuthPreferences() => _authPreferencesHelper;

  SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  /// Set [accessToken] to persistent storage
  Future<bool> setAccessToken(String accessToken) async {
    final pr = await preferences;

    return await pr.setString(accessTokenKey, accessToken);
  }

  /// Get access token from persistent storage
  Future<String?> getAccessToken() async {
    final pr = await preferences;

    if (pr.containsKey(accessTokenKey)) {
      return pr.getString(accessTokenKey);
    }

    return null;
  }

  /// Remove access token from persistent storage
  Future<bool> removeAccessToken() async {
    final pr = await preferences;

    return await pr.remove(accessTokenKey);
  }

  /// Set [refreshToken] to persistent storage
  Future<bool> setRefreshToken(String refreshToken) async {
    final pr = await preferences;

    return await pr.setString(refreshTokenKey, refreshToken);
  }

  /// Get refresh token from persistent storage
  Future<String?> getRefreshToken() async {
    final pr = await preferences;

    if (pr.containsKey(refreshTokenKey)) {
      return pr.getString(refreshTokenKey);
    }

    return null;
  }

  /// Remove refresh token from persistent storage
  Future<bool> removeRefreshToken() async {
    final pr = await preferences;

    return await pr.remove(refreshTokenKey);
  }
}
