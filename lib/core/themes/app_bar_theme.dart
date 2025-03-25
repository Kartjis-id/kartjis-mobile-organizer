// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

const appBarTheme = AppBarTheme(
  toolbarHeight: 68,
  centerTitle: true,
  backgroundColor: Palette.scaffoldBackground,
  surfaceTintColor: Palette.scaffoldBackground,
  systemOverlayStyle: SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: true,
    systemNavigationBarDividerColor: Palette.divider,
  ),
);
