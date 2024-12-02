// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu_item.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utils/keys.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:kartjis_mobile_organizer/features/event/presentation/pages/event_page.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/pages/live_report_page.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/drawer_menu_item_provider.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/widgets/custom_drawer.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/loading_indicator.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      drawerScrimColor: Colors.black45,
      drawerEdgeDragWidth: context.screenWidth * 0.5,
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
                  case DrawerMenuItem.liveReport:
                    return LiveReportPage();
                  case DrawerMenuItem.dashboard:
                    return DashboardPage();
                  case DrawerMenuItem.event:
                    return EventPage();
                  default:
                    return LoadingIndicator();
                }
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: IconButton.filledTonal(
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
                icon: SvgAsset(
                  AssetPath.getIcon('list_outlined.svg'),
                  color: Palette.primaryText,
                ),
                style: IconButton.styleFrom(
                  elevation: 3,
                  shadowColor: Palette.divider.withOpacity(.5),
                  backgroundColor: Palette.background,
                ),
                tooltip: 'Menu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
