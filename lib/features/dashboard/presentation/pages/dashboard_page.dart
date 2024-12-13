// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/features/dashboard/presentation/widgets/dashboard_event_timer_card.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/section_divider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/section_title.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SafeArea(
            child: Align(
              child: KartjisIconText(
                axis: KartjisIconTextAxis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                textColor: Palette.primaryText,
                textSize: 28,
                iconSize: 16,
              ),
            ),
          ),
          Gap(32),
          DashboardEventTimerCard(),
          SectionDivider(),
          SectionTitle('Overview'),
        ],
      ),
    );
  }
}
