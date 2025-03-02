// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu_item.dart';

final selectedMenuProvider = StateProvider<DrawerMenuItem>(
  (ref) => DrawerMenuItem.dashboard,
);
