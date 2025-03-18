// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/scanner_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/barcode_scanner.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LiveReportScannerPage extends ConsumerWidget {
  const LiveReportScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: BarcodeScanner(
        onDetect: (data) => showConfirmModalBottomSheet(context, ref, data),
      ),
    );
  }

  Future<void> showConfirmModalBottomSheet(
    BuildContext context,
    WidgetRef ref,
    String? data,
  ) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 16,
            child: SizedBox(
              width: 170,
              height: 170,
              child: RiveAnimation.asset(
                AssetPath.getAnimation('alert_icon.riv'),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(176),
              Text(
                'Verification Success!',
                textAlign: TextAlign.center,
                style: textTheme.titleLarge,
              ),
              const Gap(16),
              const Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 4,
            child: IconButton(
              onPressed: () => navigatorKey.currentState?.pop(),
              tooltip: 'Back',
              icon: SvgAsset(
                AssetPath.getIcon('close.svg'),
                color: Palette.secondaryText,
                width: 20,
              ),
            ),
          ),
        ],
      ),
    ).whenComplete(() => ref.read(scannerProvider.notifier).paused = false);
  }
}
