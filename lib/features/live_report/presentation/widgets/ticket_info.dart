// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:rive/rive.dart' hide Image;

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/scanned_status.dart';
import 'package:kartjis_mobile_organizer/core/extensions/string_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_button.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class TicketInfo extends StatelessWidget {
  final ScannedStatus scannedStatus;
  final Ticket? ticket;

  const TicketInfo({
    super.key,
    required this.scannedStatus,
    this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                color: Palette.scaffoldBackground.withValues(alpha: .9),
              ),
              child: Image.asset(
                AssetPath.getImage(event.image),
                fit: BoxFit.cover,
                color: Colors.grey,
                colorBlendMode: BlendMode.saturation,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 4,
          child: IconButton(
            onPressed: () => navigatorKey.currentState?.pop(),
            tooltip: 'Close',
            icon: SvgAsset(
              AssetPath.getIcon('close.svg'),
              color: Palette.secondaryText,
              width: 20,
            ),
          ),
        ),
        Positioned(
          top: 10,
          child: SizedBox(
            width: 170,
            height: 170,
            child: RiveAnimation.asset(
              animationAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(170),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    verificationStatusTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),
                  if (ticket != null)
                    SelectableText(
                      'ID: ${ticket!.id}',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium!.secondaryTextColor,
                    )
                  else
                    Text(
                      'Make sure the barcode provided is correct. Contact Kartjis Admin if you think this is an error.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium!.secondaryTextColor,
                    )
                ],
              ),
            ),
            const Gap(12),
            if (ticket != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: DecoratedBox(
                            position: DecorationPosition.foreground,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Palette.primaryText,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Image.asset(
                                  AssetPath.getImage(event.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleMedium!.copyWith(
                                  height: 1.25,
                                ),
                              ),
                              const Gap(6),
                              Container(
                                padding: const EdgeInsets.fromLTRB(6, 4, 8, 4),
                                decoration: BoxDecoration(
                                  color: Palette.primary,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgAsset(
                                      AssetPath.getIcon('tag.svg'),
                                      color: Palette.scaffoldBackground,
                                      width: 14,
                                    ),
                                    const Gap(4),
                                    Flexible(
                                      child: Text(
                                        ticket!.category,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.labelMedium!.scaffoldBackgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _TicketInfoSection(
                      label: 'Customer',
                      title: ticket!.buyer.fullName,
                      subtitle: ticket!.buyer.email,
                      capitalizedTitle: true,
                    ),
                  ),
                  const Divider(
                    height: 32,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _TicketInfoSection(
                      label: 'Ticket Order',
                      title: '2/3 Ticket(s)',
                      subtitle: 'Ticket 2 of 3 purchased',
                    ),
                  ),
                  const Divider(
                    height: 32,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _TicketInfoSection(
                      label: 'Verified By',
                      title: 'atlantis.eo',
                      subtitle: '23:59 31/12/2025',
                    ),
                  ),
                  const Divider(
                    height: 32,
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BrutalismButton(
                text: 'Close',
                textColor: Palette.primaryText,
                primaryColor: closeButtonColor,
                borderColor: Palette.primaryText,
                borderWidth: 1.5,
                layerColor: Palette.primaryText,
                layerSpace: 4,
                onTap: () => navigatorKey.currentState?.pop(),
              ),
            ),
            const Gap(20),
          ],
        ),
      ],
    );
  }

  String get animationAsset {
    return switch (scannedStatus) {
      ScannedStatus.availableUnverified => AssetPath.getAnimation('checkmark_icon.riv'),
      ScannedStatus.availableVerified => AssetPath.getAnimation('alert_icon.riv'),
      ScannedStatus.unavailable => AssetPath.getAnimation('error_icon.riv'),
    };
  }

  String get verificationStatusTitle {
    return switch (scannedStatus) {
      ScannedStatus.availableUnverified => 'Verification Success!',
      ScannedStatus.availableVerified => 'Ticket Has Been Verified!',
      ScannedStatus.unavailable => 'Ticket Not Found!',
    };
  }

  Color get closeButtonColor {
    return switch (scannedStatus) {
      ScannedStatus.availableUnverified => Palette.greenLight,
      ScannedStatus.availableVerified => Palette.tertiary,
      ScannedStatus.unavailable => Palette.secondary,
    };
  }
}

class _TicketInfoSection extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final bool capitalizedTitle;

  const _TicketInfoSection({
    required this.label,
    required this.title,
    this.subtitle,
    this.capitalizedTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium!.primaryColor,
        ),
        const Gap(8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                capitalizedTitle ? title.toCapitalize() : title,
                textAlign: TextAlign.right,
                style: textTheme.bodyMedium!.bold.primaryColor,
              ),
              Text(
                subtitle ?? '',
                textAlign: TextAlign.right,
                style: textTheme.bodySmall!.secondaryTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
