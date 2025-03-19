// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BrutalismCard(
      radius: 12,
      padding: EdgeInsets.zero,
      primaryColor: Palette.scaffoldBackground,
      borderWidth: 2,
      borderColor: Palette.primaryText,
      layerSpace: 8,
      layerColor: Palette.purpleLight,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetPath.getImage(event.image),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: context.screenWidth,
              minHeight: 160,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Palette.scaffoldBackground,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    event.type,
                    style: textTheme.labelMedium!.bold.tertiaryColor,
                  ),
                  const Divider(),
                  Text(
                    'Tanggal & Waktu',
                    style: textTheme.labelMedium!.bold,
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SvgAsset(
                        AssetPath.getIcon('calendar_check.svg'),
                        color: Palette.primaryText,
                        width: 16,
                      ),
                      const Gap(8),
                      Flexible(
                        child: Text('${event.date}, ${event.time}'),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Text(
                    'Lokasi',
                    style: textTheme.labelMedium!.bold,
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SvgAsset(
                        AssetPath.getIcon('map_pin.svg'),
                        color: Palette.primaryText,
                        width: 16,
                      ),
                      const Gap(8),
                      Flexible(
                        child: Text(event.location),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
