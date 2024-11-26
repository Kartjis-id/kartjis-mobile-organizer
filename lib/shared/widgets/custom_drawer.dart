// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu_item.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: Palette.purple700,
      shape: RoundedRectangleBorder(),
      child: ListView.builder(
        itemBuilder: (context, index) => _DrawerMenu(
          item: DrawerMenuItem.values[index],
        ),
        itemCount: DrawerMenuItem.values.length,
      ),
    );
  }
}

final drawerMenuItemProvider = StateProvider<DrawerMenuItem>((ref) => DrawerMenuItem.dashboard);

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
          color: selected ? Palette.secondary : Palette.background,
        ),
        title: Text(
          item.title,
          style: textTheme.bodyMedium!.semiBold.copyWith(
            color: selected ? Palette.secondary : Palette.background,
          ),
        ),
        selected: selected,
        selectedTileColor: Palette.background,
        onTap: () => setSelectedMenuItem(ref),
        onLongPress: () {},
      ),
    );
  }

  void setSelectedMenuItem(WidgetRef ref) => ref.read(drawerMenuItemProvider.notifier).state = item;
}
