// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/configs/app_config.dart';
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu_item.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utils/keys.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/drawer_menu_item_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/circle_network_image.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 290,
      backgroundColor: Palette.purple700,
      shape: RoundedRectangleBorder(),
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
                    CircleNetworkImage(
                      imageUrl: null,
                      size: 46,
                    ),
                    Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Characella Organizer',
                            style: textTheme.bodyMedium!.semiBold.scaffoldBackgroundColor,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          ),
                          Gap(2),
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
            _DrawerDivider(
              top: 20,
              bottom: 10,
            ),
            ...DrawerMenuItem.values.map(
              (item) => _DrawerMenu(item: item),
            ),
            _DrawerDivider(
              top: 10,
              bottom: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KartjisIconText(
                    axis: KartjisIconTextAxis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textColor: Palette.scaffoldBackground,
                    textSize: 24,
                    iconSize: 16,
                  ),
                  Gap(6),
                  Text(
                    'Version ${AppConfig.version}',
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
        indent: 20,
        endIndent: 20,
        height: 1,
        thickness: 1,
        color: Palette.divider.withOpacity(.25),
      ),
    );
  }
}

class _DrawerMenu extends ConsumerWidget {
  final DrawerMenuItem item;

  const _DrawerMenu({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = item == ref.watch(drawerMenuItemProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        enabled: true,
        minTileHeight: 50,
        horizontalTitleGap: 12,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: SvgAsset(
          AssetPath.getIcon(item.leadingIcon),
          color: selected ? Palette.secondary : Palette.scaffoldBackground,
        ),
        title: Text(
          item.title,
          style: textTheme.bodyMedium!.semiBold.copyWith(
            color: selected ? Palette.secondary : Palette.scaffoldBackground,
          ),
        ),
        selected: selected,
        selectedTileColor: Palette.scaffoldBackground,
        onTap: () {
          ref.read(drawerMenuItemProvider.notifier).state = item;
          scaffoldKey.currentState?.closeDrawer();
        },
      ),
    );
  }
}
