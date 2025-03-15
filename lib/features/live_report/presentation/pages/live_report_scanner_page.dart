// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/qr_code_scanner.dart';

class LiveReportScannerPage extends ConsumerWidget {
  const LiveReportScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(updateAttendanceScannerProvider, (_, state) {
    //   state.whenOrNull(
    //     loading: () => context.showLoadingDialog(),
    //     error: (error, stackTrace) {
    //       if (!qrScannerNotifier.autoConfirm) {
    //         navigatorKey.currentState!.pop();
    //       }

    //       navigatorKey.currentState!.pop();
    //       context.responseError(error, stackTrace);
    //     },
    //     data: (data) {
    //       if (data != null) {
    //         if (!qrScannerNotifier.autoConfirm) {
    //           navigatorKey.currentState!.pop();
    //         }

    //         navigatorKey.currentState!.pop();
    //         ref.invalidate(meetingAttendancesProvider);

    //         final attendance = args.attendances.where((e) => e.student!.id == data);

    //         if (attendance.isNotEmpty) {
    //           showAttendanceStatusDialog(context, ref, attendance.first.student!);
    //         }
    //       }
    //     },
    //   );
    // });

    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Palette.primary,
        systemNavigationBarDividerColor: Palette.primary,
      ),
      child: Scaffold(
        backgroundColor: Palette.primary,
        body: QrCodeScanner(),
      ),
    );
  }

  // void submit(BuildContext context, WidgetRef ref, String studentId) {
  //   if (DateTime.now().secondsSinceEpoch < args.meeting.date! + 86400) {
  //     final attendance = AttendancePost(
  //       status: 'ATTEND',
  //       studentId: studentId,
  //     );

  //     ref.read(updateAttendanceScannerProvider.notifier).updateAttendanceScanner(
  //           args.meeting.id!,
  //           attendance,
  //         );
  //   } else {
  //     context.showSnackBar(
  //       title: 'Pertemuan Telah Selesai',
  //       message: 'Kamu sudah tidak bisa mengabsen peserta pada pertemuan ini.',
  //       type: SnackBarType.error,
  //     );

  //     if (!ref.watch(qrScannerProvider).autoConfirm) {
  //       navigatorKey.currentState!.pop();
  //     }
  //   }
  // }

  // Future<void> showConfirmModalBottomSheet(
  //   BuildContext context,
  //   WidgetRef ref,
  // ) async {
  //   return showModalBottomSheet(
  //     context: context,
  //     enableDrag: false,
  //     isScrollControlled: true,
  //     builder: (context) => BottomSheet(
  //       onClosing: () {},
  //       enableDrag: false,
  //       builder: (context) => Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(24),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               '${args.meeting.lesson}',
  //               style: textTheme.bodyMedium!.copyWith(
  //                 color: Palette.purple3,
  //               ),
  //             ),
  //             const SizedBox(height: 2),
  //             Text(
  //               'Pertemuan ${args.meeting.number}',
  //               style: textTheme.titleLarge!.copyWith(
  //                 color: Palette.purple2,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             ListTile(
  //               contentPadding: EdgeInsets.zero,
  //               minLeadingWidth: 48,
  //               horizontalTitleGap: 14,
  //               leading: CircleNetworkImage(
  //                 imageUrl: student.profilePicturePath,
  //                 size: 48,
  //               ),
  //               title: Text(
  //                 '${student.fullname}',
  //                 style: textTheme.titleMedium!.copyWith(
  //                   color: Palette.disabledText,
  //                 ),
  //               ),
  //               subtitle: Text(
  //                 '${student.username}',
  //                 style: textTheme.bodySmall!.copyWith(
  //                   color: Palette.disabledText,
  //                 ),
  //               ),
  //             ),
  //             FilledButton(
  //               onPressed: () => submit(context, ref, student.id!),
  //               child: const Text('Konfirmasi'),
  //             ).fullWidth(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ).whenComplete(() => ref.read(qrScannerProvider.notifier).reset());
  // }

  // Future<void> showAttendanceStatusDialog(
  //   BuildContext context,
  //   WidgetRef ref,
  //   Profile student,
  // ) async {
  //   Timer? timer = Timer(
  //     const Duration(seconds: 3),
  //     () => navigatorKey.currentState!.pop(),
  //   );

  //   showDialog(
  //     context: context,
  //     builder: (context) => AttendanceStatusDialog(
  //       student: student,
  //       meeting: args.meeting,
  //       attendanceType: AttendanceType.meeting,
  //       isAttend: true,
  //     ),
  //   ).then((_) {
  //     timer?.cancel();
  //     timer = null;
  //   }).whenComplete(() => ref.read(qrScannerProvider.notifier).reset());
  // }

  // Future<void> showErrorModalBottomSheet(
  //   BuildContext context,
  //   WidgetRef ref,
  // ) async {
  //   return showModalBottomSheet(
  //     context: context,
  //     enableDrag: false,
  //     isScrollControlled: true,
  //     builder: (context) => BottomSheet(
  //       onClosing: () {},
  //       enableDrag: false,
  //       builder: (context) => Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(24),
  //         child: Stack(
  //           clipBehavior: Clip.none,
  //           alignment: AlignmentDirectional.topCenter,
  //           children: [
  //             Positioned(
  //               top: -150,
  //               child: SizedBox(
  //                 width: 250,
  //                 height: 250,
  //                 child: RiveAnimation.asset(
  //                   AssetPath.getRive('error_icon.riv'),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 44),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     'Peserta Tidak Ditemukan!',
  //                     textAlign: TextAlign.center,
  //                     style: textTheme.titleLarge!.copyWith(
  //                       color: Palette.purple2,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 2),
  //                   Text(
  //                     'Peserta tidak ditemukan. Silahkan coba lagi.',
  //                     textAlign: TextAlign.center,
  //                     style: textTheme.bodySmall!.copyWith(
  //                       color: Palette.error,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ).whenComplete(() => ref.read(qrScannerProvider.notifier).reset());
  // }
}
