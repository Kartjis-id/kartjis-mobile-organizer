// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/app_config.dart';
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/circle_network_image.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Palette.purpleDark,
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium!.bold.scaffoldBackgroundColor,
                          ),
                          const Gap(2),
                          Text(
                            'Organizer',
                            style: textTheme.bodySmall!.disabledColor,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  event.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.bold.primaryColor,
                ),
              ),
            ),
            const Gap(16),
            const _DrawerDivider(),
            const Gap(10),
            const _DrawerMenuListTile(
              menu: DrawerMenu.dashboard,
            ),
            const Gap(10),
            const _DrawerDivider(),
            const Gap(16),
            const _DrawerSectionTitle('Event'),
            const Gap(6),
            for (var i = 1; i <= 9; i++)
              _DrawerMenuListTile(
                menu: DrawerMenu.values[i],
              ),
            const Gap(16),
            const _DrawerSectionTitle('General'),
            const Gap(6),
            for (var i = 10; i <= 13; i++)
              _DrawerMenuListTile(
                menu: DrawerMenu.values[i],
              ),
            const Gap(10),
            const _DrawerDivider(),
            const Gap(20),
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
                    style: textTheme.bodySmall!.disabledColor,
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
  const _DrawerDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Palette.divider.withValues(alpha: .3),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  final String title;

  const _DrawerSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: textTheme.labelMedium!.bold.disabledColor,
      ),
    );
  }
}

class _DrawerMenuListTile extends ConsumerWidget {
  final DrawerMenu menu;

  const _DrawerMenuListTile({required this.menu});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = menu == ref.watch(selectedMenuProvider);

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
          AssetPath.getIcon(menu.leadingIcon),
          color: selected ? Palette.secondary : Palette.scaffoldBackground,
          width: 20,
        ),
        title: Text(
          menu.title,
          style: textTheme.labelLarge!.copyWith(
            color: selected ? Palette.secondary : Palette.scaffoldBackground,
          ),
        ),
        onTap: () {
          ref.read(selectedMenuProvider.notifier).state = menu;
          scaffoldKey.currentState?.closeDrawer();
        },
      ),
    );
  }
}
