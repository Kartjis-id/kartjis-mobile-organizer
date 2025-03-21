// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class DescriptionMainPage extends StatelessWidget {
  const DescriptionMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 72,
              expandedHeight: 225,
              centerTitle: true,
              title: const Text('Event Description'),
              titleTextStyle: textTheme.titleMedium!.scaffoldBackgroundColor,
              backgroundColor: Palette.primary,
              surfaceTintColor: Palette.primary,
              actions: [
                IconButton(
                  onPressed: () {},
                  tooltip: 'Edit',
                  icon: SvgAsset(
                    AssetPath.getIcon('edit.svg'),
                    color: Palette.scaffoldBackground,
                    width: 22,
                  ),
                ),
                const Gap(4),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.asset(
                      AssetPath.getImage(event.image),
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black87,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black12,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: true,
              ),
            ),
          ];
        },
        body: const SingleChildScrollView(),
      ),
    );
  }
}
