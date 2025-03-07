// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';

final selectedMenuProvider = StateProvider<DrawerMenu>(
  (ref) => DrawerMenu.dashboard,
);
