// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalism_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/custom_circle_icon.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class DashboardEventTimerCard extends StatelessWidget {
  const DashboardEventTimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BrutalismCard(
        primaryColor: Palette.purple700,
        borderColor: Palette.primaryText,
        layerColor: Palette.tertiary,
        padding: EdgeInsets.zero,
        borderWidth: 2,
        layerSpace: 6,
        radius: 16,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 160,
            ),
            Positioned(
              left: -40,
              bottom: -50,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(.1),
                ),
              ),
            ),
            Positioned(
              right: -40,
              top: -50,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCircleIcon(
                        icon: SvgAsset(
                          AssetPath.getIcon('hourglass_outlined.svg'),
                          color: Palette.purple700,
                          width: 18,
                        ),
                      ),
                      Gap(10),
                      Flexible(
                        child: Text(
                          'Event will start on',
                          style: textTheme.labelLarge!.primaryBackgroundColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DurationText(
                        duration: 10,
                        text: 'DAYS',
                      ),
                      _DurationSeparator(),
                      _DurationText(
                        duration: 23,
                        text: 'HOURS',
                      ),
                      _DurationSeparator(),
                      _DurationText(
                        duration: 59,
                        text: 'MINUTES',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DurationText extends StatelessWidget {
  final int duration;
  final String text;

  const _DurationText({
    required this.duration,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Text(
            '$duration',
            style: textTheme.displayMedium!.bold.scaffoldBackgroundColor,
          ),
          Text(
            text,
            style: textTheme.labelMedium!.semiBold.copyWith(
              color: Palette.scaffoldBackground.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationSeparator extends StatelessWidget {
  const _DurationSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        ':',
        style: textTheme.displayMedium!.bold.scaffoldBackgroundColor.copyWith(
          height: 1.25,
        ),
      ),
    );
  }
}
