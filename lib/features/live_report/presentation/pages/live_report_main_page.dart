// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';
import 'package:kartjis_mobile_organizer/core/helpers/helper_function.dart';
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/search_provider.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/selected_verification_status_provider.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/ticket_list_provider.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/widgets/ticket_list.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/animated_floating_action_button.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/input_fields/search_field.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LiveReportMainPage extends StatefulWidget {
  const LiveReportMainPage({super.key});

  @override
  State<LiveReportMainPage> createState() => _LiveReportMainPageState();
}

class _LiveReportMainPageState extends State<LiveReportMainPage> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final ScrollController scrollController;
  late final PageController pageController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..forward();

    super.initState();

    scrollController = ScrollController();
    pageController = PageController();
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
        final isSearching = ref.watch(searchProvider.select((notifier) => notifier.isSearching));

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) => FunctionHelper.handleSearchingOnPop(
            ref,
            didPop,
            isSearching,
            postHandledCallback: () => ref.read(selectedMenuProvider.notifier).state = DrawerMenu.dashboard,
          ),
          child: Scaffold(
            backgroundColor: Palette.background,
            body: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
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
                                      AppBar(),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () => toggleSearch(ref, isSearching),
                                              tooltip: 'Back',
                                              icon: SvgAsset(
                                                AssetPath.getIcon('arrow_left.svg'),
                                                color: Palette.primaryText,
                                              ),
                                            ),
                                            Expanded(
                                              child: Consumer(
                                                builder: (context, ref, child) {
                                                  return SearchField(
                                                    text: ref.watch(searchProvider).searchText,
                                                    autoFocus: true,
                                                    hintText: 'Search ticket/buyer',
                                                    onChanged: (text) => searchTicket(ref, text),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : AppBar(
                                    title: SvgAsset(
                                      AssetPath.getVector('live_report.svg'),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    actions: [
                                      IconButton(
                                        onPressed: () => toggleSearch(ref, isSearching),
                                        tooltip: 'Search',
                                        icon: SvgAsset(
                                          AssetPath.getIcon('search.svg'),
                                          color: Palette.primaryText,
                                        ),
                                      ),
                                      const Gap(8),
                                    ],
                                  ),
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final verificationStatus = ref.watch(selectedVerificationStatusProvider);

                            return SegmentedButton<VerificationStatus>(
                              segments: const [
                                ButtonSegment(
                                  value: VerificationStatus.unverified,
                                  icon: Icon(Icons.arrow_circle_up),
                                  label: Text('3618'),
                                ),
                                ButtonSegment(
                                  value: VerificationStatus.verified,
                                  icon: Icon(Icons.arrow_circle_down),
                                  label: Text('372'),
                                ),
                              ],
                              expandedInsets: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                              selected: {verificationStatus},
                              showSelectedIcon: false,
                              onSelectionChanged: (selection) {
                                ref.read(selectedVerificationStatusProvider.notifier).state = selection.first;

                                pageController.animateToPage(
                                  verificationStatus == VerificationStatus.verified ? 0 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final ticketList = ref.watch(ticketListProvider);

                      return PageView(
                        controller: pageController,
                        children: [
                          TicketList(
                            animationController: animationController,
                            scrollController: scrollController,
                            tickets: ticketList.where((e) => !e.verified).toList(),
                            onRefresh: () async {},
                          ),
                          TicketList(
                            animationController: animationController,
                            scrollController: scrollController,
                            tickets: ticketList.where((e) => e.verified).toList(),
                            onRefresh: () async {},
                          ),
                        ],
                        onPageChanged: (page) {
                          final status = page == 0 ? VerificationStatus.unverified : VerificationStatus.verified;

                          ref.read(selectedVerificationStatusProvider.notifier).state = status;

                          pageController.animateToPage(
                            page,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: AnimatedFloatingActionButton(
              animationController: animationController,
              onPressed: () => navigatorKey.currentState?.pushNamed(liveReportScannerRoute),
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

  void toggleSearch(WidgetRef ref, bool isSearching) {
    ref.read(searchProvider.notifier).isSearching = !isSearching;
  }

  void searchTicket(WidgetRef ref, String text) {
    ref.read(searchProvider.notifier).searchText = text;

    final newTicketList = tickets.where((ticket) {
      final query = text.toLowerCase();
      final fullName = ticket.buyer.fullName.toLowerCase();
      final email = ticket.buyer.email.toLowerCase();

      return fullName.contains(query) || email.contains(query);
    }).toList();

    ref.read(ticketListProvider.notifier).state = newTicketList;
  }
}
