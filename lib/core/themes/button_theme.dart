// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

final segmentedButtonTheme = SegmentedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    side: WidgetStateProperty.all(
      const BorderSide(
        style: BorderStyle.none,
      ),
    ),
    iconColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Palette.primaryText;
      }

      return Palette.secondaryText;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Palette.primaryText;
      }

      return Palette.secondaryText;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Palette.purpleLight;
      }

      return Palette.divider.withValues(alpha: .7);
    }),
    iconSize: WidgetStateProperty.all(24),
    textStyle: WidgetStateProperty.all(textTheme.bodyLarge!.medium),
  ),
);
