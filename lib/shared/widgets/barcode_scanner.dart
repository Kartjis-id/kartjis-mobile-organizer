// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/services/image_service.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/providers/manual_providers/scanner_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/kartjis_icon_text.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class BarcodeScanner extends StatefulWidget {
  final void Function(String? data) onDetect;

  const BarcodeScanner({super.key, required this.onDetect});

  @override
  State<BarcodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<BarcodeScanner> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final MobileScannerController scannerController;
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    scannerController = MobileScannerController(
      cameraResolution: const Size(1920, 1080),
      detectionTimeoutMs: 1000,
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
      case AppLifecycleState.resumed:
        scannerController.start();
      case AppLifecycleState.inactive:
        scannerController.stop();
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen(scannerProvider, (_, notifier) {
          if (notifier.paused) {
            scannerController.pause();
          } else {
            scannerController.start();
          }
        });

        return LayoutBuilder(
          builder: (context, constraints) {
            final layoutSize = constraints.biggest;
            final scanWindowSize = layoutSize.width * .7;

            final scanWindow = Rect.fromCenter(
              center: layoutSize.center(const Offset(0, -25)),
              width: scanWindowSize,
              height: scanWindowSize,
            );

            return Stack(
              children: [
                MobileScanner(
                  controller: scannerController,
                  scanWindow: scanWindow,
                  onDetect: (result) => detectAndPauseScanner(ref, result),
                ),
                ScanWindowOverlay(
                  controller: scannerController,
                  scanWindow: scanWindow,
                  color: Palette.primary.withValues(alpha: .6),
                  borderRadius: BorderRadius.circular(20),
                  borderColor: Palette.purpleLight,
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
                              width: scanWindowSize - 6,
                              height: 25,
                              child: Transform.translate(
                                offset: Offset(0, (scanWindowSize - 2) * (animation.value - .5)),
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
                                              Palette.greenLight.withValues(alpha: 0),
                                              Palette.greenLight.withValues(alpha: .1),
                                              Palette.greenLight.withValues(alpha: .3),
                                              Palette.greenLight.withValues(alpha: .5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Palette.greenLight,
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
                                              Palette.greenLight.withValues(alpha: 0),
                                              Palette.greenLight.withValues(alpha: .1),
                                              Palette.greenLight.withValues(alpha: .3),
                                              Palette.greenLight.withValues(alpha: .5),
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
                Positioned.fromRect(
                  rect: scanWindow.translate(0, (scanWindowSize / 1.25)),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SwitchCameraButton(
                        controller: scannerController,
                      ),
                      ToggleFlashlightButton(
                        controller: scannerController,
                      ),
                      AnalyzeImageButton(
                        controller: scannerController,
                        onDetect: (result) => detectAndPauseScanner(ref, result),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  width: constraints.maxWidth,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Powered by',
                                style: textTheme.bodyMedium!.scaffoldBackgroundColor,
                              ),
                              const Gap(4),
                              const KartjisIconText(
                                axis: KartjisIconTextAxis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textColor: Palette.scaffoldBackground,
                                textSize: 22,
                                iconSize: 18,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Scanner Sound',
                                style: textTheme.bodyMedium!.scaffoldBackgroundColor,
                              ),
                              const Gap(2),
                              Switch(
                                value: ref.watch(scannerProvider).enableSound,
                                activeTrackColor: Palette.purpleLight,
                                inactiveTrackColor: Palette.secondaryText,
                                thumbColor: WidgetStateProperty.resolveWith((states) => Palette.scaffoldBackground),
                                trackOutlineColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
                                trackOutlineWidth: WidgetStateProperty.resolveWith((states) => 0),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onChanged: (value) => ref.read(scannerProvider.notifier).enableSound = value,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void detectAndPauseScanner(WidgetRef ref, BarcodeCapture result) async {
    final withSound = ref.watch(scannerProvider).enableSound;

    if (withSound) {
      await FlutterRingtonePlayer().play(
        fromAsset: AssetPath.getSound('scanner_sound.wav'),
        volume: 0.3,
      );
    }

    widget.onDetect(result.barcodes.map((e) => e.displayValue).toList().first);

    ref.read(scannerProvider.notifier).paused = true;
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
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
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

/// Button widget for switch camera function
class SwitchCameraButton extends StatelessWidget {
  /// Construct a new [SwitchCameraButton] instance.
  const SwitchCameraButton({super.key, required this.controller});

  /// Controller which is used to call switchCamera
  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        return ScannerConfigButton(
          heroTag: 'switch_camera_button',
          onPressed: !state.isInitialized || !state.isRunning ? null : onPressed,
          tooltip: 'Switch',
          child: SvgAsset(
            AssetPath.getIcon('camera_rotate.svg'),
            color: Palette.background,
          ),
        );
      },
    );
  }

  void onPressed() => controller.switchCamera();
}

/// Button widget for toggle torch (flash) function
class ToggleFlashlightButton extends StatelessWidget {
  /// Construct a new [ToggleFlashlightButton] instance.
  const ToggleFlashlightButton({super.key, required this.controller});

  /// Controller which is used to call toggleTorch
  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        switch (state.torchState) {
          case TorchState.off:
            return ScannerConfigButton(
              heroTag: 'flashlight_button_off',
              onPressed: !state.isInitialized || !state.isRunning ? null : onPressed,
              tooltip: 'Flash',
              child: SvgAsset(
                AssetPath.getIcon('zap_off.svg'),
                color: Palette.background,
              ),
            );
          case TorchState.on || TorchState.auto:
            return ScannerConfigButton(
              heroTag: 'flashlight_button_on',
              onPressed: !state.isInitialized || !state.isRunning ? null : onPressed,
              tooltip: 'Flash',
              child: SvgAsset(
                AssetPath.getIcon('zap.svg'),
                color: Palette.background,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  void onPressed() => controller.toggleTorch();
}

/// Button widget for analyze image function
class AnalyzeImageButton extends StatelessWidget {
  /// Construct a new [AnalyzeImageButton] instance.
  const AnalyzeImageButton({
    super.key,
    required this.controller,
    required this.onDetect,
  });

  /// Controller which is used to call analyzeImage
  final MobileScannerController controller;

  /// Callback when barcode successfully detected from image
  final void Function(BarcodeCapture result) onDetect;

  @override
  Widget build(BuildContext context) {
    return ScannerConfigButton(
      heroTag: 'analyze_image_button',
      onPressed: onPressed,
      tooltip: 'Gallery',
      child: SvgAsset(
        AssetPath.getIcon('image.svg'),
        color: Palette.background,
      ),
    );
  }

  Future<void> onPressed() async {
    final imagePath = await ImageService.pickImage(ImageSource.gallery);

    if (imagePath == null) return;

    final result = await controller.analyzeImage(imagePath);

    if (result == null) return;

    onDetect(result);
  }
}

class ScannerConfigButton extends StatelessWidget {
  final String? heroTag;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Widget? child;

  const ScannerConfigButton({
    super.key,
    this.heroTag,
    this.onPressed,
    this.tooltip,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      elevation: 0,
      highlightElevation: 0,
      foregroundColor: Palette.background,
      backgroundColor: Palette.purpleDark,
      shape: const CircleBorder(
        side: BorderSide(
          color: Palette.background,
          width: 2,
        ),
      ),
      onPressed: onPressed,
      tooltip: tooltip,
      child: child,
    );
  }
}
