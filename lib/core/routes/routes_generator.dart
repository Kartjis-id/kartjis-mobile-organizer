// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/pages/login_page.dart';
import 'package:kartjis_mobile_organizer/features/shared/widgets/internet_connection_wrapper.dart';

/// App routes generator
Route<dynamic>? generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    case wrapperRoute:
      return MaterialPageRoute(
        builder: (_) => const InternetConnectionWrapper(),
      );
    case loginRoute:
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
      );
    default:
      return null;
  }
}
