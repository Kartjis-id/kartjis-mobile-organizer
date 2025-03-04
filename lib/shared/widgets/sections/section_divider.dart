// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

class SectionDivider extends StatelessWidget {
  final double topPadding;
  final double bottomPadding;

  const SectionDivider({
    super.key,
    this.topPadding = 24.0,
    this.bottomPadding = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Divider(
        height: 8,
        thickness: 8,
        color: Palette.divider.withValues(alpha: .75),
      ),
    );
  }
}
