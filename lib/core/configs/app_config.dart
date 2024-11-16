// Package imports:
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  final PackageInfo packageInfo;

  const AppConfig(this.packageInfo);

  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;
}
