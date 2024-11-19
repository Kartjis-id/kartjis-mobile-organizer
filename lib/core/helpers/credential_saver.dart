// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/token.dart';

class CredentialSaver {
  static Token? token;

  static Future<void> init() async {
    AuthPreferences authPreferences = AuthPreferences();

    token = await authPreferences.getToken();
  }
}
