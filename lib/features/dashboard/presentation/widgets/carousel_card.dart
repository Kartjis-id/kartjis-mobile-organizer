// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/providers/focused_event_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class CarouselCard extends StatelessWidget {
  final Event event;

  const CarouselCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BrutalismCard(
      radius: 12,
      padding: EdgeInsets.zero,
      primaryColor: Palette.scaffoldBackground,
      borderWidth: 2,
      borderColor: Palette.primaryText,
      layerSpace: 6,
      layerColor: Palette.purple300,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Positioned.fill(
            child: Consumer(
              builder: (context, ref, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  foregroundDecoration: BoxDecoration(
                    color: event == ref.watch(focusedEventProvider) ? null : Colors.black.withValues(alpha: .4),
                  ),
                  child: Image.asset(
                    AssetPath.getImage(event.image),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.tertiary,
                ),
                child: Center(
                  child: Text(
                    '${event.number}',
                    style: textTheme.bodyMedium!.bold.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Consumer(
              builder: (context, ref, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  height: event == ref.watch(focusedEventProvider) ? 180 : 0,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 2,
                        color: Palette.primaryText,
                      ),
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Palette.scaffoldBackground,
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.name,
                              style: textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              event.type,
                              style: textTheme.labelMedium!.bold.tertiaryColor,
                            ),
                            const Divider(
                              color: Palette.divider,
                            ),
                            Text(
                              'Tanggal & Waktu',
                              style: textTheme.labelMedium!.bold,
                            ),
                            const Gap(6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgAsset(
                                  AssetPath.getIcon('calendar_check.svg'),
                                  width: 16,
                                ),
                                const Gap(6),
                                Flexible(
                                  child: Text(
                                    '${event.date}, ${event.time}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              'Lokasi',
                              style: textTheme.labelMedium!.bold,
                            ),
                            const Gap(6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgAsset(
                                  AssetPath.getIcon('map_pin.svg'),
                                  width: 16,
                                ),
                                const Gap(6),
                                Flexible(
                                  child: Text(
                                    event.location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
