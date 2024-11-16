// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

class AuthPreferencesHelper {
  AuthPreferencesHelper._instance();

  static final AuthPreferencesHelper _authPreferencesHelper = AuthPreferencesHelper._instance();

  factory AuthPreferencesHelper() => _authPreferencesHelper;

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
}
