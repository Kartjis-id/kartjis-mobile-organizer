// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

class CustomCircleIcon extends StatelessWidget {
  final Widget icon;
  final EdgeInsets? padding;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;

  const CustomCircleIcon({
    super.key,
    required this.icon,
    this.padding,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Palette.scaffoldBackground,
        border: borderWidth != null
            ? Border.all(
                width: borderWidth!,
                color: borderColor ?? Palette.primary,
              )
            : null,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(6),
        child: icon,
      ),
    );
  }
}
