// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/helpers/helper_function.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/providers/generated_providers/count_down_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/circle_background_icon.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class CountDownCard extends StatelessWidget {
  final DateTime heldDate;

  const CountDownCard({super.key, required this.heldDate});

  @override
  Widget build(BuildContext context) {
    final durationInSeconds = heldDate.difference(DateTime.now()).inSeconds;
    final countDownProvider = CountDownProvider(durationInSeconds);

    return BrutalismCard(
      radius: 12,
      padding: EdgeInsets.zero,
      color: Palette.purpleDark,
      layerColor: Palette.tertiary,
      layerSpace: 6,
      borderColor: Palette.primaryText,
      borderWidth: 2,
      child: Stack(
        children: [
          Positioned(
            left: -40,
            bottom: -50,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: .18),
              ),
            ),
          ),
          Positioned(
            right: -40,
            top: -50,
            child: Container(
              width: 155,
              height: 155,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: .18),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleBackgroundIcon(
                      icon: SvgAsset(
                        AssetPath.getIcon('hourglass.svg'),
                        color: Palette.purpleDark,
                        width: 16,
                      ),
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        event.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelLarge!.primaryBackgroundColor,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Consumer(
                  builder: (context, ref, child) {
                    final seconds = ref.watch(countDownProvider).whenOrNull(data: (data) => data);
                    final duration = FunctionHelper.formattedDurationMap(seconds ?? durationInSeconds);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DurationText(
                          duration: duration['day']!,
                          text: 'DAYS',
                        ),
                        const _DurationSeparator(),
                        _DurationText(
                          duration: duration['hour']!,
                          text: 'HOURS',
                        ),
                        const _DurationSeparator(),
                        _DurationText(
                          duration: duration['min']!,
                          text: 'MINUTES',
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationText extends StatelessWidget {
  final String duration;
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
            duration,
            style: textTheme.displayMedium!.scaffoldBackgroundColor.copyWith(
              height: 1,
            ),
          ),
          const Gap(6),
          Text(
            text,
            style: textTheme.labelMedium!.scaffoldBackgroundColor,
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        ':',
        style: textTheme.displayMedium!.scaffoldBackgroundColor.copyWith(
          height: 0.9,
        ),
      ),
    );
  }
}
