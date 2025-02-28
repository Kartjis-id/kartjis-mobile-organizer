// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/theme/color_scheme.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/section_title.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SafeArea(
            child: KartjisIconText(
              axis: KartjisIconTextAxis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              textColor: Palette.primaryText,
              textSize: 22,
              iconSize: 18,
            ),
          ),
          SectionTitle(
            'Dashboard',
            padding: EdgeInsets.only(
              top: 36,
              bottom: 24,
            ),
          ),
        ],
      ),
    );
  }
}
