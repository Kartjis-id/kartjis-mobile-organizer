// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu_item.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:kartjis_mobile_organizer/features/event/presentation/pages/event_description_page.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/drawer_menu_item_provider.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/widgets/main_drawer.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/loading_indicator.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MainDrawer(),
      drawerScrimColor: Colors.black45,
      drawerEdgeDragWidth: context.screenWidth * 0.4,
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: context.screenWidth,
              maxHeight: context.screenHeight,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final selectedMenu = ref.watch(drawerMenuItemProvider);

                switch (selectedMenu) {
                  case DrawerMenuItem.dashboard:
                    return const DashboardPage();
                  case DrawerMenuItem.eventDescription:
                    return const EventDescriptionPage();
                  default:
                    return const LoadingIndicator();
                }
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                    icon: SvgAsset(
                      AssetPath.getIcon('list.svg'),
                      color: Palette.primaryText,
                    ),
                    style: IconButton.styleFrom(
                      elevation: 4,
                      shadowColor: Palette.divider.withValues(alpha: .3),
                      backgroundColor: Palette.background,
                    ),
                    tooltip: 'Menu',
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
