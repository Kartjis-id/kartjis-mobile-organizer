// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/scanner_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/barcode_scanner.dart';

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
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$data',
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() => ref.read(scannerProvider.notifier).paused = false);
  }
}
