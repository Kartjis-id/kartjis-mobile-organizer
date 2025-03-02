// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/app.dart';
import 'package:kartjis_mobile_organizer/core/configs/app_config.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_token_saver.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Palette.scaffoldBackground,
    ),
  );

  await AppConfig.init();
  await AuthTokenSaver.init();

  runApp(
    const ProviderScope(
      child: KartjisOrganizerApp(),
    ),
  );
}
