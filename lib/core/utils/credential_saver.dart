// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences_helper.dart';

class CredentialSaver {
  static String? accessToken;

  static Future<void> init() async {
    if (accessToken == null) {
      AuthPreferencesHelper preferencesHelper = AuthPreferencesHelper();

      accessToken = await preferencesHelper.getAccessToken();
    }
  }
}
