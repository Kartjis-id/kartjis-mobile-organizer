// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

const bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Palette.scaffoldBackground,
  modalBackgroundColor: Palette.scaffoldBackground,
  surfaceTintColor: Palette.scaffoldBackground,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  ),
  dragHandleSize: Size(40, 5),
  dragHandleColor: Palette.secondaryText,
);
