// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

class CircleBackgroundIcon extends StatelessWidget {
  final Widget icon;
  final EdgeInsets? padding;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;

  const CircleBackgroundIcon({
    super.key,
    required this.icon,
    this.padding,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Palette.scaffoldBackground,
        border: borderWidth != null
            ? Border.all(
                width: borderWidth!,
                color: borderColor ?? Palette.primaryText,
              )
            : null,
      ),
      child: icon,
    );
  }
}
