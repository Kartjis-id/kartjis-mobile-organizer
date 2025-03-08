// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/providers/manual_providers/focused_event_provider.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/widgets/carousel_card.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/widgets/count_down_card.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/widgets/overview_chart.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/sections/section_divider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/sections/section_title.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SafeArea(
              child: KartjisIconText(
                axis: KartjisIconTextAxis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                textColor: Palette.primaryText,
                textSize: 22,
                iconSize: 18,
              ),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CountDownCard(
                heldDate: DateTime.now().add(const Duration(days: 7)),
              ),
            ),
            const Gap(24),
            const SectionDivider(),
            const Gap(24),
            const SectionTitle(
              'Overview',
              horizontalPadding: 20,
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: OverviewChart(
                      title: 'Total Sales',
                      value: '3.285',
                      description: 'Kartjis',
                      iconPath: AssetPath.getIcon('receipt.svg'),
                      vectorPath: AssetPath.getVector('area_chart.svg'),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: OverviewChart(
                      title: 'Total Income',
                      value: '120M+',
                      description: 'IDR 120.000.000',
                      iconPath: AssetPath.getIcon('wallet.svg'),
                      vectorPath: AssetPath.getVector('bar_chart.svg'),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            const SectionDivider(),
            const Gap(24),
            const SectionTitle(
              'Your Events',
              horizontalPadding: 20,
            ),
            const Gap(16),
            Consumer(
              builder: (context, ref, child) {
                return CarouselSlider.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: CarouselCard(
                        event: events[index],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 350,
                    viewportFraction: 0.75,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    onPageChanged: (index, reason) => ref.read(focusedEventProvider.notifier).state = events[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
