// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

class QrCodeScanner extends ConsumerStatefulWidget {
  const QrCodeScanner({super.key});

  @override
  ConsumerState<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends ConsumerState<QrCodeScanner>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final ValueNotifier<CameraFacing> facing;
  late final ValueNotifier<bool> flash;

  late final MobileScannerController scannerController;
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    facing = ValueNotifier(CameraFacing.back);
    flash = ValueNotifier(false);

    scannerController = MobileScannerController(
      cameraResolution: const Size(1920, 1080),
      facing: facing.value,
      torchEnabled: flash.value,
    );

    super.initState();

    WidgetsBinding.instance.addObserver(this);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    scannerController.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!scannerController.value.hasCameraPermission) return;

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        unawaited(scannerController.start());
      case AppLifecycleState.inactive:
        unawaited(scannerController.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutSize = constraints.biggest;
        final scanWindowSize = layoutSize.width * .7;

        final scanWindow = Rect.fromCenter(
          center: layoutSize.center(const Offset(0, -50)),
          width: scanWindowSize,
          height: scanWindowSize,
        );

        return Stack(
          children: [
            MobileScanner(
              controller: scannerController,
              scanWindow: scanWindow,
            ),
            ScanWindowOverlay(
              controller: scannerController,
              scanWindow: scanWindow,
              color: Palette.primary.withValues(alpha: .6),
              borderRadius: BorderRadius.circular(20),
              borderColor: Palette.purple300,
              borderWidth: 4,
            ),
            Positioned.fromRect(
              rect: scanWindow,
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: animation.value > .2 && animation.value < .8 ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: SizedBox(
                          width: scanWindowSize - 4,
                          height: 25,
                          child: Transform.translate(
                            offset: Offset(0, scanWindowSize * (animation.value - .5)),
                            child: Column(
                              children: [
                                if (animation.status == AnimationStatus.forward)
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Palette.green400.withValues(alpha: 0),
                                          Palette.green400.withValues(alpha: .1),
                                          Palette.green400.withValues(alpha: .3),
                                          Palette.green400.withValues(alpha: .5),
                                        ],
                                      ),
                                    ),
                                  ),
                                Container(
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Palette.green400,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                ),
                                if (animation.status == AnimationStatus.reverse)
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Palette.green400.withValues(alpha: 0),
                                          Palette.green400.withValues(alpha: .1),
                                          Palette.green400.withValues(alpha: .3),
                                          Palette.green400.withValues(alpha: .5),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

/// This widget represents an overlay that paints a scan window cutout.
class ScanWindowOverlay extends StatelessWidget {
  /// Construct a new [ScanWindowOverlay] instance.
  const ScanWindowOverlay({
    super.key,
    required this.controller,
    required this.scanWindow,
    this.borderColor = Colors.white,
    this.borderRadius = BorderRadius.zero,
    this.borderStrokeCap = StrokeCap.butt,
    this.borderStrokeJoin = StrokeJoin.miter,
    this.borderStyle = PaintingStyle.stroke,
    this.borderWidth = 2.0,
    this.color = const Color(0x80000000),
  });

  /// The color for the scan window border.
  ///
  /// Defaults to [Colors.white].
  final Color borderColor;

  /// The border radius for the scan window and its border.
  ///
  /// Defaults to [BorderRadius.zero].
  final BorderRadius borderRadius;

  /// The stroke cap for the border around the scan window.
  ///
  /// Defaults to [StrokeCap.butt].
  final StrokeCap borderStrokeCap;

  /// The stroke join for the border around the scan window.
  ///
  /// Defaults to [StrokeJoin.miter].
  final StrokeJoin borderStrokeJoin;

  /// The style for the border around the scan window.
  ///
  /// Defaults to [PaintingStyle.stroke].
  final PaintingStyle borderStyle;

  /// The width for the border around the scan window.
  ///
  /// Defaults to 2.0.
  final double borderWidth;

  /// The color for the scan window box.
  ///
  /// Defaults to [Colors.black] with 50% opacity.
  final Color color;

  /// The controller that manages the camera preview.
  final MobileScannerController controller;

  /// The scan window for the overlay.
  final Rect scanWindow;

  @override
  Widget build(BuildContext context) {
    if (scanWindow.isEmpty || scanWindow.isInfinite) {
      return const SizedBox();
    }

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        // Not ready.
        if (!value.isInitialized || !value.isRunning || value.error != null || value.size.isEmpty) {
          return const SizedBox();
        }

        return CustomPaint(
          size: value.size,
          painter: ScanWindowPainter(
            borderColor: borderColor,
            borderRadius: borderRadius,
            borderStrokeCap: borderStrokeCap,
            borderStrokeJoin: borderStrokeJoin,
            borderStyle: borderStyle,
            borderWidth: borderWidth,
            scanWindow: scanWindow,
            color: color,
          ),
        );
      },
    );
  }
}

/// This class represents a [CustomPainter] that draws a [scanWindow] rectangle.
class ScanWindowPainter extends CustomPainter {
  /// Construct a new [ScanWindowPainter] instance.
  const ScanWindowPainter({
    required this.borderColor,
    required this.borderRadius,
    required this.borderStrokeCap,
    required this.borderStrokeJoin,
    required this.borderStyle,
    required this.borderWidth,
    required this.color,
    required this.scanWindow,
  });

  /// The color for the scan window border.
  final Color borderColor;

  /// The border radius for the scan window and its border.
  final BorderRadius borderRadius;

  /// The stroke cap for the border around the scan window.
  final StrokeCap borderStrokeCap;

  /// The stroke join for the border around the scan window.
  final StrokeJoin borderStrokeJoin;

  /// The style for the border around the scan window.
  final PaintingStyle borderStyle;

  /// The width for the border around the scan window.
  final double borderWidth;

  /// The color for the scan window box.
  final Color color;

  /// The rectangle that defines the scan window.
  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    if (scanWindow.isEmpty || scanWindow.isInfinite) return;

    // Define the main overlay path covering the entire screen.
    final backgroundPath = Path()..addRect(Offset.zero & size);

    // The cutout rect depends on the border radius.
    final RRect cutoutRect = borderRadius == BorderRadius.zero
        ? RRect.fromRectAndCorners(scanWindow)
        : RRect.fromRectAndCorners(
            scanWindow,
            topLeft: borderRadius.topLeft,
            topRight: borderRadius.topRight,
            bottomLeft: borderRadius.bottomLeft,
            bottomRight: borderRadius.bottomRight,
          );

    // The cutout path is always in the center.
    final Path cutoutPath = Path()..addRRect(cutoutRect);

    // Combine the two paths: overlay minus the cutout area
    final Path overlayWithCutoutPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final Paint overlayWithCutoutPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver; // android

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = borderStyle
      ..strokeWidth = borderWidth
      ..strokeCap = borderStrokeCap
      ..strokeJoin = borderStrokeJoin;

    // Paint the overlay with the cutout.
    canvas.drawPath(overlayWithCutoutPath, overlayWithCutoutPaint);

    // Then, draw the border around the cutout area.
    canvas.drawRRect(cutoutRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScanWindowPainter oldDelegate) {
    return oldDelegate.scanWindow != scanWindow ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}
