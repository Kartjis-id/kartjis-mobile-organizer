// Project imports:
import 'package:kartjis_mobile_organizer/core/helper/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';

class AuthTokenSaver {
  static Token? token;

  static Future<void> init() async {
    AuthPreferences authPreferences = AuthPreferences();

    token = await authPreferences.getToken();
  }
}
