// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsets padding;

  const SectionTitle(
    this.title, {
    super.key,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          const Column(
            children: [
              SizedBox.square(
                dimension: 6,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.primary,
                  ),
                ),
              ),
              Gap(4),
              SizedBox(
                width: 6,
                height: 18,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Expanded(
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
