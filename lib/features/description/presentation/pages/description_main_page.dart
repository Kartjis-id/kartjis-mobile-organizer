// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/drawer_menu.dart';
import 'package:kartjis_mobile_organizer/core/enums/event_image_type.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/description/presentation/providers/event_image_type_index_provider.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_menu_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/dashed_divider.dart';
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
          title: SvgAsset(
            AssetPath.getVector('event_description.svg'),
            fit: BoxFit.fitHeight,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Edit',
              icon: SvgAsset(
                AssetPath.getIcon('edit.svg'),
                color: Palette.primaryText,
              ),
            ),
            const Gap(8),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              thickness: 1,
              height: 1,
              color: Palette.divider,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Consumer(
                  builder: (context, ref, child) {
                    final currentIndex = ref.watch(eventImageTypeIndexProvider);

                    return AspectRatio(
                      aspectRatio: EventImageType.values[currentIndex].aspectRatio,
                      child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              AssetPath.getImage(event.image),
                            ),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Palette.divider,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FilledButton.icon(
                          onPressed: () => setEventImageTypeIndex(ref, currentIndex),
                          icon: SvgAsset(
                            AssetPath.getIcon('image.svg'),
                            color: Palette.scaffoldBackground,
                            width: 16,
                          ),
                          label: Text(
                            EventImageType.values[currentIndex].name,
                            style: textTheme.labelMedium!.scaffoldBackgroundColor,
                          ),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 12,
                            ),
                            visualDensity: const VisualDensity(
                              vertical: -2,
                              horizontal: -2,
                            ),
                            backgroundColor: Palette.primary.withValues(alpha: .7),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  event.name,
                  style: textTheme.titleLarge!.copyWith(
                    height: 1.25,
                  ),
                ),
              ),
              const Gap(2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  event.type,
                  style: textTheme.labelLarge!.tertiaryColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DashedDivider(
                  dashWidth: 6,
                  dashSpace: 3,
                  verticalSpacing: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setEventImageTypeIndex(WidgetRef ref, int currentIndex) {
    final nextIndex = currentIndex == EventImageType.values.length - 1 ? 0 : currentIndex + 1;

    ref.read(eventImageTypeIndexProvider.notifier).state = nextIndex;
  }
}
