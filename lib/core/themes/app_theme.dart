// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/app_bar_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/bottom_sheet_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/button_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/dialog_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/input_decoration_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

final appTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: textTheme,
).copyWith(
  dividerColor: Palette.divider,
  scaffoldBackgroundColor: Palette.scaffoldBackground,
  appBarTheme: appBarTheme,
  dialogTheme: dialogTheme,
  bottomSheetTheme: bottomSheetTheme,
  inputDecorationTheme: inputDecorationTheme,
  segmentedButtonTheme: segmentedButtonTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
