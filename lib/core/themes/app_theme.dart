// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

ThemeData get appTheme {
  return ThemeData.from(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
  ).copyWith(
    dividerColor: Palette.divider,
    cardColor: Palette.background,
    scaffoldBackgroundColor: Palette.scaffoldBackground,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
