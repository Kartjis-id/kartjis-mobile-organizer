// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/circle_background_icon.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class OverviewChart extends StatelessWidget {
  final String title;
  final String value;
  final String description;
  final String iconPath;
  final String vectorPath;

  const OverviewChart({
    super.key,
    required this.title,
    required this.value,
    required this.description,
    required this.iconPath,
    required this.vectorPath,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalismCard(
      radius: 8,
      padding: EdgeInsets.zero,
      color: Palette.scaffoldBackground,
      layerColor: Palette.scaffoldBackground,
      layerSpace: 4,
      borderColor: Palette.primaryText,
      borderWidth: 1.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleBackgroundIcon(
                      icon: SvgAsset(
                        iconPath,
                        color: Palette.primaryText,
                        width: 16,
                      ),
                      padding: const EdgeInsets.all(6),
                      backgroundColor: Palette.grey,
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        title,
                        style: textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                const Gap(24),
                Text(
                  value,
                  style: textTheme.displaySmall!.copyWith(
                    height: 1,
                  ),
                ),
                const Gap(2),
                Text(
                  description,
                  style: textTheme.bodyMedium!.secondaryTextColor,
                ),
              ],
            ),
          ),
          const Gap(8),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: context.screenWidth,
              maxWidth: context.screenWidth,
            ),
            child: SvgAsset(
              vectorPath,
              fit: context.screenWidth < 480 ? BoxFit.cover : BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
