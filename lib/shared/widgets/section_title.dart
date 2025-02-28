// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/theme/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/theme/text_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Column(
            children: [
              SizedBox.square(
                dimension: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.primary,
                  ),
                ),
              ),
              Gap(4),
              SizedBox(
                width: 8,
                height: 20,
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
