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
  static const primary = Color(0xFF2C1F63);
  static const secondary = Color(0xFFDF135C);
  static const tertiary = Color(0xFFFFC351);
  static const background = Color(0xFFF6F7F9);
  static const scaffoldBackground = Color(0xFFFFFFFF);
  static const primaryText = Color(0xFF1E293B);
  static const secondaryText = Color(0xFFBBBEC1);
  static const divider = Color(0xFFE4E4E4);
  static const error = Color(0xFFD90429);
  static const success = Color(0xFF3E9D9D);
  static const disabled = Color(0xFFC9C9C9);
  static const purple300 = Color(0xFF9F77E2);
  static const purple700 = Color(0xFF490B99);
  static const green400 = Color(0xFF28DCA6);
}
