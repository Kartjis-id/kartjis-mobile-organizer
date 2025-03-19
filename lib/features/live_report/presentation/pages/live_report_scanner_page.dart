// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/scanned_status.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/scanner_provider.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/widgets/ticket_info.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/barcode_scanner.dart';

class LiveReportScannerPage extends ConsumerWidget {
  const LiveReportScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: BarcodeScanner(
        onDetect: (data) => showTicketInfoModalBottomSheet(context, ref, data ?? ''),
      ),
    );
  }

  Future<void> showTicketInfoModalBottomSheet(
    BuildContext context,
    WidgetRef ref,
    String data,
  ) async {
    final ticket = switch (data) {
      'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2' => tickets.last,
      '5b2c0654-de5e-3153-ac1f-751cac718e4e' => tickets.first,
      _ => null,
    };

    final scannedStatus = switch (data) {
      'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2' => ScannedStatus.availableUnverified,
      '5b2c0654-de5e-3153-ac1f-751cac718e4e' => ScannedStatus.availableVerified,
      _ => ScannedStatus.unavailable,
    };

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TicketInfo(
        ticket: ticket,
        scannedStatus: scannedStatus,
      ),
    ).whenComplete(() => ref.read(scannerProvider.notifier).paused = false);
  }
}
