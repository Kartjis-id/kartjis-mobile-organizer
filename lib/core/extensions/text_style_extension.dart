// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

extension TextStyleExtension on TextStyle {
  // Weight
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  // Color
  TextStyle get primary => copyWith(color: Palette.primary);
  TextStyle get secondary => copyWith(color: Palette.secondary);
  TextStyle get tertiary => copyWith(color: Palette.tertiary);
  TextStyle get background => copyWith(color: Palette.background);
  TextStyle get scaffoldBackground => copyWith(color: Palette.scaffoldBackground);
  TextStyle get primaryText => copyWith(color: Palette.primaryText);
  TextStyle get secondaryText => copyWith(color: Palette.secondaryText);
  TextStyle get divider => copyWith(color: Palette.divider);
  TextStyle get error => copyWith(color: Palette.error);
  TextStyle get success => copyWith(color: Palette.success);
  TextStyle get disabled => copyWith(color: Palette.disabled);
}
