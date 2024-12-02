// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/pages/login_page.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/screens/main_screen.dart';
import 'package:kartjis_mobile_organizer/wrapper.dart';

/// App routes generator
Route<dynamic>? generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    case wrapperRoute:
      return MaterialPageRoute(
        builder: (_) => const Wrapper(),
      );
    case loginRoute:
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
      );
    case mainRoute:
      return MaterialPageRoute(
        builder: (_) => const MainScreen(),
      );
    default:
      return null;
  }
}
