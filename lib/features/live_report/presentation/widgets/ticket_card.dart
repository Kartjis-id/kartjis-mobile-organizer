// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return BrutalismCard(
      radius: 8,
      primaryColor: Palette.scaffoldBackground,
      borderWidth: 1.5,
      borderColor: Palette.primaryText,
      layerSpace: 5,
      layerColor: ticket.status == VerificationStatus.verified ? Palette.greenLight : Palette.secondary,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 6,
                ),
                decoration: BoxDecoration(
                  color: Palette.purpleLight,
                  border: Border.all(
                    color: Palette.primaryText,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '#',
                  style: textTheme.labelLarge!.bold.copyWith(
                    height: 1,
                  ),
                ),
              ),
              const Gap(6),
              Flexible(
                child: Text(
                  '5b2c0654-de5e-3153-ac1f-751cac718e4e',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            ticket.buyer.fullName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium,
          ),
          Text(
            ticket.buyer.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.secondaryTextColor,
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(6, 3, 8, 3),
                decoration: BoxDecoration(
                  color: Palette.tertiary,
                  border: Border.all(
                    color: Palette.primaryText,
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgAsset(
                      AssetPath.getIcon('tag.svg'),
                      color: Palette.primaryText,
                      width: 14,
                    ),
                    const Gap(4),
                    Flexible(
                      child: Text(
                        ticket.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              if (ticket.status == VerificationStatus.verified)
                Expanded(
                  child: Text(
                    'Verified by @admin at 23:59 31/12/2025',
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall!.secondaryTextColor,
                  ),
                )
              else
                Expanded(
                  child: Text(
                    'Unverified',
                    textAlign: TextAlign.right,
                    style: textTheme.labelSmall!.secondaryTextColor,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
