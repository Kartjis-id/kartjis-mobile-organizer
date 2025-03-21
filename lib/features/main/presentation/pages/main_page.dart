// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:kartjis_mobile_organizer/features/description/presentation/pages/description_main_page.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/pages/live_report_main_page.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/search_provider.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/widgets/main_drawer.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MainDrawer(),
      drawerEdgeDragWidth: context.screenWidth * 0.1,
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: context.screenWidth,
              maxHeight: context.screenHeight,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final selectedMenu = ref.watch(selectedMenuProvider);

                switch (selectedMenu) {
                  case DrawerMenu.dashboard:
                    return const DashboardPage();
                  case DrawerMenu.eventLiveReport:
                    return const LiveReportMainPage();
                  case DrawerMenu.eventDescription:
                    return const DescriptionMainPage();
                  default:
                    return const SizedBox.expand();
                }
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final isSearching = ref.watch(searchProvider).isSearching;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isSearching
                        ? IconButton(
                            key: const ValueKey(1),
                            onPressed: () => ref.read(searchProvider.notifier).isSearching = !isSearching,
                            tooltip: 'Back',
                            icon: SvgAsset(
                              AssetPath.getIcon('arrow_left.svg'),
                              color: Palette.primaryText,
                            ),
                          )
                        : Consumer(
                            builder: (context, ref, child) {
                              final selectedMenu = ref.watch(selectedMenuProvider);

                              return IconButton(
                                key: const ValueKey(2),
                                onPressed: () => scaffoldKey.currentState?.openDrawer(),
                                tooltip: 'Menu',
                                icon: SvgAsset(
                                  AssetPath.getIcon('list.svg'),
                                  color: getMenuIconButtonColor(selectedMenu),
                                ),
                                style: getMenuIconButtonStyle(selectedMenu),
                              );
                            },
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getMenuIconButtonColor(DrawerMenu selectedMenu) {
    return switch (selectedMenu) {
      DrawerMenu.eventDescription => Palette.scaffoldBackground,
      _ => Palette.primaryText,
    };
  }

  ButtonStyle? getMenuIconButtonStyle(DrawerMenu selectedMenu) {
    return switch (selectedMenu) {
      DrawerMenu.dashboard => IconButton.styleFrom(
          backgroundColor: Palette.divider.withValues(alpha: .7),
        ),
      _ => null,
    };
  }
}
