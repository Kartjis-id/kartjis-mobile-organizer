// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/dialog_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/input_decoration_theme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

ThemeData get appTheme {
  return ThemeData.from(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
  ).copyWith(
    scaffoldBackgroundColor: Palette.scaffoldBackground,
    dialogTheme: dialogTheme,
    inputDecorationTheme: inputDecorationTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
