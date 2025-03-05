// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double horizontalPadding;

  const SectionTitle(
    this.title, {
    super.key,
    this.horizontalPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          const Column(
            children: [
              SizedBox(
                width: 6,
                height: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.primary,
                  ),
                ),
              ),
              Gap(2),
              SizedBox(
                width: 6,
                height: 16,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Flexible(
            child: Text(
              title,
              style: textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
