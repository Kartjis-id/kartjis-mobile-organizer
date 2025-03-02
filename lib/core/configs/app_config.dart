// Package imports:
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  static String? appName;
  static String? packageName;
  static String? version;
  static String? buildNumber;

  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }
}
