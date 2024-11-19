// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/routes/routes_generator.dart';
import 'package:kartjis_mobile_organizer/core/utils/keys.dart';
import 'package:kartjis_mobile_organizer/features/shared/widgets/internet_connection_wrapper.dart';

class KartjisOrganizerApp extends StatelessWidget {
  const KartjisOrganizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartjis Mobile Organizer',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      onGenerateRoute: generateAppRoutes,
      home: InternetConnectionWrapper(),
    );
  }
}
