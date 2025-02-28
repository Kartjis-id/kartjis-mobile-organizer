// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/theme/color_scheme.dart';

extension TextStyleExtension on TextStyle {
  // Text weight
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  // Text color
  TextStyle get primaryColor => copyWith(color: Palette.primary);
  TextStyle get secondaryColor => copyWith(color: Palette.secondary);
  TextStyle get tertiaryColor => copyWith(color: Palette.tertiary);
  TextStyle get primaryBackgroundColor => copyWith(color: Palette.background);
  TextStyle get scaffoldBackgroundColor => copyWith(color: Palette.scaffoldBackground);
  TextStyle get primaryTextColor => copyWith(color: Palette.primaryText);
  TextStyle get secondaryTextColor => copyWith(color: Palette.secondaryText);
  TextStyle get dividerColor => copyWith(color: Palette.divider);
  TextStyle get errorColor => copyWith(color: Palette.error);
  TextStyle get successColor => copyWith(color: Palette.success);
  TextStyle get disabledColor => copyWith(color: Palette.disabled);
}
