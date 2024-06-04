// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/src/presentation/features/auth/pages/login_page.dart';
import 'package:kartjis_mobile_organizer/src/presentation/features/common/wrapper.dart';

// Register the RouteObserver as a navigation observer
final routeObserver = RouteObserver<ModalRoute<void>>();

// App routes generator
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
    default:
      return null;
  }
}
