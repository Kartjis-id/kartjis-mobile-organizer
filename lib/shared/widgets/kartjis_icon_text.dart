// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

enum KartjisIconTextAxis {
  vertical,
  horizontal,
}

class KartjisIconText extends StatelessWidget {
  final KartjisIconTextAxis axis;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double? iconSize;
  final double? textSize;
  final Color? textColor;
  final double gap;

  const KartjisIconText({
    super.key,
    this.axis = KartjisIconTextAxis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.iconSize,
    this.textSize,
    this.textColor,
    this.gap = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final kartjisWidgets = [
      SvgAsset(
        AssetPath.getIcon('kartjis.svg'),
        width: iconSize,
      ),
      Gap(gap),
      Text(
        'KARTJIS',
        style: TextStyle(
          fontFamily: 'Titillium Web',
          fontWeight: FontWeight.bold,
          fontSize: textSize,
          color: textColor,
          height: 1,
        ),
      ),
    ];

    return axis == KartjisIconTextAxis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: kartjisWidgets,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: kartjisWidgets,
          );
  }
}
