// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/widgets/event_count_down_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/sections/section_divider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/sections/section_title.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          EventCountDownCard(
            DateTime.now().add(const Duration(days: 1)),
          ),
          const SectionDivider(),
          const SectionTitle(
            'Overview',
            padding: EdgeInsets.fromLTRB(20, 0, 16, 20),
          ),
        ],
      ),
    );
  }
}
