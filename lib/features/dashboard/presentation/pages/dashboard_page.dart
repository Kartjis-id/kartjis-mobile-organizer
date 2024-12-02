// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: KartjisIconText(
              axis: KartjisIconTextAxis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              textColor: Palette.primary,
              textSize: 24,
              iconSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
