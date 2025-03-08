// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LiveReportPage extends StatelessWidget {
  const LiveReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true,
              floating: true,
              centerTitle: true,
              toolbarHeight: 70,
              backgroundColor: Palette.scaffoldBackground,
              surfaceTintColor: Palette.scaffoldBackground,
              title: SvgAsset(
                AssetPath.getVector('live_report.svg'),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  tooltip: 'Search',
                  icon: SvgAsset(
                    AssetPath.getIcon('search.svg'),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Item $index'),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(8);
                },
                itemCount: 25,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Scanner',
        child: SvgAsset(
          AssetPath.getIcon('scan.svg'),
        ),
      ),
    );
  }
}
