// Flutter imports:
import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Color? color;
  final double? verticalSpacing;

  const DashedDivider({
    super.key,
    this.dashWidth = 8,
    this.dashSpace = 4,
    this.strokeWidth = 1,
    this.strokeCap = StrokeCap.butt,
    this.color,
    this.verticalSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalSpacing ?? 0),
      child: SizedBox(
        width: double.infinity,
        child: CustomPaint(
          painter: DashedLinePainter(
            dashWidth: dashWidth,
            dashSpace: dashSpace,
            strokeWidth: strokeWidth,
            strokeCap: strokeCap,
            color: color ?? Colors.grey[400]!,
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final Color color;

  const DashedLinePainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
    required this.strokeCap,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..color = color;

    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
