// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/app_config.dart';
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu_item.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/widgets/select_event_dialog.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/circle_network_image.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Palette.purple700,
      shape: const RoundedRectangleBorder(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const CircleNetworkImage(
                      imageUrl: null,
                      size: 48,
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event Organizer',
                            style: textTheme.bodyMedium!.bold.scaffoldBackgroundColor,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          ),
                          const Gap(2),
                          Text(
                            'Organizer',
                            style: textTheme.bodySmall!.secondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                minTileHeight: 48,
                tileColor: Palette.scaffoldBackground.withValues(alpha: .6),
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  'The Eras Tour',
                  style: textTheme.bodyMedium!.bold.primaryColor,
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: Palette.primary,
                ),
                onTap: () {
                  context.showCustomDialog(const SelectEventDialog());
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ),
            const _DrawerDivider(
              top: 16,
              bottom: 10,
            ),
            const _DrawerMenu(
              item: DrawerMenuItem.dashboard,
            ),
            const _DrawerDivider(
              top: 10,
              bottom: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Event',
                style: textTheme.labelMedium!.bold.secondaryTextColor,
              ),
            ),
            const Gap(6),
            for (var i = 1; i <= 8; i++)
              _DrawerMenu(
                item: DrawerMenuItem.values[i],
              ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Others',
                style: textTheme.labelMedium!.bold.secondaryTextColor,
              ),
            ),
            const Gap(6),
            for (var i = 9; i <= 12; i++)
              _DrawerMenu(
                item: DrawerMenuItem.values[i],
              ),
            const _DrawerDivider(
              top: 10,
              bottom: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KartjisIconText(
                    axis: KartjisIconTextAxis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textColor: Palette.scaffoldBackground,
                    textSize: 22,
                    iconSize: 18,
                  ),
                  const Gap(8),
                  Text(
                    'App version ${AppConfig.version}',
                    style: textTheme.labelSmall!.secondaryTextColor,
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

class _DrawerDivider extends StatelessWidget {
  final double top;
  final double bottom;

  const _DrawerDivider({
    this.top = 0.0,
    this.bottom = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
      ),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Palette.divider.withValues(alpha: .25),
      ),
    );
  }
}

class _DrawerMenu extends ConsumerWidget {
  final DrawerMenuItem item;

  const _DrawerMenu({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = item == ref.watch(selectedMenuProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        selected: selected,
        selectedTileColor: Palette.scaffoldBackground,
        minTileHeight: 48,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: SvgAsset(
          AssetPath.getIcon(item.leadingIcon),
          width: 20,
          color: selected ? Palette.secondary : Palette.scaffoldBackground,
        ),
        title: Text(
          item.title,
          style: textTheme.labelLarge!.copyWith(
            color: selected ? Palette.secondary : Palette.scaffoldBackground,
          ),
        ),
        onTap: () {
          ref.read(selectedMenuProvider.notifier).state = item;
          scaffoldKey.currentState?.closeDrawer();
        },
      ),
    );
  }
}
