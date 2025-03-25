// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class DescriptionMainPage extends ConsumerWidget {
  const DescriptionMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        ref.read(selectedMenuProvider.notifier).state = DrawerMenu.dashboard;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Event Description',
            style: textTheme.titleMedium,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Edit',
              icon: SvgAsset(
                AssetPath.getIcon('edit.svg'),
                color: Palette.primaryText,
                width: 22,
              ),
            ),
            const Gap(8),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Palette.divider,
            ),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
