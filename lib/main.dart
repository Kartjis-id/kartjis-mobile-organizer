// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/app.dart';
import 'package:kartjis_mobile_organizer/core/configs/app_config.dart';
import 'package:kartjis_mobile_organizer/core/helpers/credential_saver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.init();
  await CredentialSaver.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Palette.scaffoldBackgroundColor,
    ),
  );

  runApp(
    const ProviderScope(
      child: KartjisOrganizerApp(),
    ),
  );
}
