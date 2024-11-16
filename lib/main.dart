// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/app.dart';
import 'package:kartjis_mobile_organizer/core/utils/credential_saver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CredentialSaver.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      // systemNavigationBarColor: Palette.scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    const ProviderScope(
      child: KartjisOrganizerApp(),
    ),
  );
}
