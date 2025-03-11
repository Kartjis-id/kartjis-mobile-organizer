// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';
import 'package:kartjis_mobile_organizer/core/helpers/helper_function.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/selected_verification_status.dart';
import 'package:kartjis_mobile_organizer/shared/providers/manual_providers/is_searching_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/animated_fab.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LiveReportPage extends StatefulWidget {
  const LiveReportPage({super.key});

  @override
  State<LiveReportPage> createState() => _LiveReportPageState();
}

class _LiveReportPageState extends State<LiveReportPage> with SingleTickerProviderStateMixin {
  late final AnimationController fabAnimationController;
  late final ScrollController scrollController;

  @override
  void initState() {
    fabAnimationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..forward();

    scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    fabAnimationController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          return FunctionHelper.handleFabVisibilityOnScroll(fabAnimationController, notification);
        },
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
                    Consumer(
                      builder: (context, ref, child) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          child: ref.watch(isSearchingProvider)
                              ? AppBar(
                                  key: const ValueKey(1),
                                  toolbarHeight: 72,
                                  backgroundColor: Palette.scaffoldBackground,
                                  surfaceTintColor: Palette.scaffoldBackground,
                                )
                              : AppBar(
                                  key: const ValueKey(2),
                                  toolbarHeight: 72,
                                  centerTitle: true,
                                  backgroundColor: Palette.scaffoldBackground,
                                  surfaceTintColor: Palette.scaffoldBackground,
                                  title: SvgAsset(
                                    AssetPath.getVector('live_report.svg'),
                                  ),
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        ref.read(isSearchingProvider.notifier).update((state) => !state);
                                      },
                                      tooltip: 'Search',
                                      icon: SvgAsset(
                                        AssetPath.getIcon('search.svg'),
                                        color: Palette.primaryText,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
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
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        animationController: fabAnimationController,
        onPressed: () {},
        tooltip: 'Scanner',
        child: SvgAsset(
          AssetPath.getIcon('scan.svg'),
          color: Palette.primaryText,
        ),
      ),
    );
  }
}
