// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/core/routes/routes_generator.dart';
import 'package:kartjis_mobile_organizer/core/themes/app_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';

class KartjisOrganizerApp extends StatelessWidget {
  const KartjisOrganizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartjis Mobile Organizer',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: wrapperRoute,
      onGenerateRoute: generateAppRoutes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
