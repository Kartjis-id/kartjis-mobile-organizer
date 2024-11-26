// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/pages/login_page.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/wrapper.dart';

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
    case dashboardRoute:
      return MaterialPageRoute(
        builder: (_) => const DashboardPage(),
      );
    default:
      return null;
  }
}
