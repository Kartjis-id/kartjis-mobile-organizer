// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/theme/color_scheme.dart';

enum SnackBarType {
  success(Icons.check_circle_outlined, Palette.success),
  error(Icons.cancel_outlined, Palette.error),
  info(Icons.error_outline_outlined, Palette.primary);

  final IconData leadingIcon;
  final Color backgroundColor;

  const SnackBarType(
    this.leadingIcon,
    this.backgroundColor,
  );
}
