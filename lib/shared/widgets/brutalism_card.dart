// Flutter imports:
import 'package:flutter/material.dart';

class BrutalismCard extends StatefulWidget {
  final bool isEnabled;
  final Color primaryColor;
  final Color layerColor;
  final Color? borderColor;
  final double? borderWidth;
  final double layerSpace;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Widget child;

  const BrutalismCard({
    super.key,
    this.isEnabled = true,
    required this.primaryColor,
    required this.layerColor,
    this.borderColor,
    this.borderWidth,
    required this.layerSpace,
    this.textColor,
    this.onTap,
    this.padding = const EdgeInsets.all(12.0),
    this.radius = 8.0,
    required this.child,
  });

  @override
  State<BrutalismCard> createState() => _BrutalismCardState();
}

class _BrutalismCardState extends State<BrutalismCard> {
  final ValueNotifier<bool> onHoverNotifier = ValueNotifier(false);

  @override
  void dispose() {
    onHoverNotifier.dispose();

    super.dispose();
  }

  void onTapUp() {
    Future.delayed(const Duration(milliseconds: 150), () {
      onHoverNotifier.value = false;

      widget.onTap!.call();
    });
  }

  void onTapCancel() {
    Future.delayed(const Duration(milliseconds: 150), () {
      onHoverNotifier.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: onHoverNotifier,
      builder: (context, onHover, ___) {
        return GestureDetector(
          onTapDown: widget.isEnabled && widget.onTap != null ? (details) => onHoverNotifier.value = true : null,
          onTapUp: widget.isEnabled && widget.onTap != null ? (details) => onTapUp() : null,
          onTapCancel: widget.isEnabled && widget.onTap != null ? onTapCancel : null,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: widget.layerSpace,
                    top: widget.layerSpace,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius),
                    color: widget.layerColor,
                    border: Border.all(
                      width: widget.borderWidth ?? 1,
                      color: widget.borderColor ?? Colors.black,
                    ),
                  ),
                  padding: widget.padding,
                  child: const SizedBox(),
                ),
              ),
              AnimatedContainer(
                width: double.infinity,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                margin: onHover || !widget.isEnabled
                    ? EdgeInsets.only(
                        left: widget.layerSpace,
                        top: widget.layerSpace,
                      )
                    : EdgeInsets.only(
                        right: widget.layerSpace,
                        bottom: widget.layerSpace,
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  color: widget.isEnabled ? widget.primaryColor : Colors.white,
                  border: Border.all(
                    width: widget.borderWidth ?? 1,
                    color: widget.isEnabled ? widget.borderColor ?? Colors.black : Colors.grey,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.radius - (widget.layerSpace / 2)),
                  child: Padding(
                    padding: widget.padding ?? EdgeInsets.zero,
                    child: widget.child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
