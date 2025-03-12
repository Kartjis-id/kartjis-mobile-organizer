// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';
import 'package:kartjis_mobile_organizer/core/helpers/helper_function.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/selected_verification_status_provider.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/widgets/ticket_card.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/shared/providers/manual_providers/search_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/animated_fab.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/input_fields/search_field.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LiveReportPage extends StatefulWidget {
  const LiveReportPage({super.key});

  @override
  State<LiveReportPage> createState() => _LiveReportPageState();
}

class _LiveReportPageState extends State<LiveReportPage> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final ScrollController scrollController;
  late final PageController pageController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..forward();
    scrollController = ScrollController();
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isSearching = ref.watch(searchProvider).isSearching;
        final searchText = ref.watch(searchProvider).searchText;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) => FunctionHelper.handleSearchingOnPop(
            ref,
            didPop,
            isSearching,
            postHandleCallback: () => ref.read(selectedMenuProvider.notifier).state = DrawerMenu.dashboard,
          ),
          child: Scaffold(
            backgroundColor: Palette.background,
            body: NotificationListener<UserScrollNotification>(
              onNotification: (notification) => FunctionHelper.handleFabVisibilityOnScroll(
                animationController,
                notification,
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  PinnedHeaderSliver(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Palette.scaffoldBackground,
                        border: Border(
                          bottom: BorderSide(
                            color: Palette.divider,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          SafeArea(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              child: isSearching
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AppBar(
                                          toolbarHeight: 72,
                                          backgroundColor: Palette.scaffoldBackground,
                                          surfaceTintColor: Palette.scaffoldBackground,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 20,
                                          ),
                                          child: Row(
                                            children: [
                                              Opacity(
                                                opacity: 0,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.arrow_back),
                                                ),
                                              ),
                                              Expanded(
                                                child: SearchField(
                                                  text: searchText,
                                                  autoFocus: true,
                                                  hintText: 'Search ticket owner',
                                                  onChanged: (text) {
                                                    ref.read(searchProvider.notifier).searchText = text;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : AppBar(
                                      toolbarHeight: 72,
                                      backgroundColor: Palette.scaffoldBackground,
                                      surfaceTintColor: Palette.scaffoldBackground,
                                      centerTitle: true,
                                      title: SvgAsset(
                                        AssetPath.getVector('live_report.svg'),
                                      ),
                                      actions: [
                                        IconButton(
                                          onPressed: () => ref.read(searchProvider.notifier).isSearching = !isSearching,
                                          tooltip: 'Search',
                                          icon: SvgAsset(
                                            AssetPath.getIcon('search.svg'),
                                            color: Palette.primaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return SegmentedButton<VerificationStatus>(
                                segments: const [
                                  ButtonSegment(
                                    value: VerificationStatus.unverified,
                                    icon: Icon(Icons.arrow_circle_up),
                                    label: Text('Unverified'),
                                  ),
                                  ButtonSegment(
                                    value: VerificationStatus.verified,
                                    icon: Icon(Icons.arrow_circle_down),
                                    label: Text('Verified'),
                                  ),
                                ],
                                expandedInsets: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                                selected: {ref.watch(selectedVerificationStatusProvider)},
                                showSelectedIcon: false,
                                onSelectionChanged: (selection) {
                                  ref.read(selectedVerificationStatusProvider.notifier).state = selection.first;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        return TicketCard(
                          ticket: unverifiedTickets[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(12);
                      },
                      itemCount: unverifiedTickets.length,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: AnimatedFloatingActionButton(
              animationController: animationController,
              onPressed: () {},
              tooltip: 'Scanner',
              child: SvgAsset(
                AssetPath.getIcon('scan.svg'),
                color: Palette.primaryText,
              ),
            ),
          ),
        );
      },
    );
  }
}
