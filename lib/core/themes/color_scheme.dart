// Flutter imports:
import 'package:flutter/material.dart';

// Color scheme
final colorScheme = ColorScheme.fromSeed(
  seedColor: Palette.primary,
  primary: Palette.primary,
  onPrimary: Palette.scaffoldBackground,
  secondary: Palette.secondary,
  onSecondary: Palette.scaffoldBackground,
  tertiary: Palette.tertiary,
  onTertiary: Palette.scaffoldBackground,
  surface: Palette.background,
  onSurface: Palette.primaryText,
  error: Palette.error,
  errorContainer: Palette.error,
  onError: Palette.scaffoldBackground,
);

// Color palette
class Palette {
  static Color primary = const Color(0xFF2C1F63);
  static Color secondary = const Color(0xFFDF135C);
  static Color tertiary = const Color(0xFFFFC351);
  static Color background = const Color(0xFFF6F7F9);
  static Color scaffoldBackground = const Color(0xFFFFFFFF);
  static Color primaryText = const Color(0xFF1E293B);
  static Color secondaryText = const Color(0xFFBBBEC1);
  static Color divider = const Color(0xFFE4E4E4);
  static Color error = const Color(0xFFD90429);
  static Color success = const Color(0xFF3E9D9D);
  static Color onDisable = const Color(0xFFC9C9C9);

  static Color purple2 = const Color(0xFF9F77E2);
  static Color green2 = const Color(0xFF28DCA6);
}
