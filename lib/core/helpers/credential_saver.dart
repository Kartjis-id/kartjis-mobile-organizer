// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';

class CredentialSaver {
  static String? accessToken;
  static String? refreshToken;

  static Future<void> init() async {
    AuthPreferences authPreferences = AuthPreferences();

    accessToken = await authPreferences.getAccessToken();
    refreshToken = await authPreferences.getRefreshToken();
  }
}
