// Flutter imports:
import 'package:flutter/material.dart';

class BrutalismCard extends StatefulWidget {
  final bool enabled;
  final Color primaryColor;
  final Color layerColor;
  final double layerSpace;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsets padding;
  final double radius;
  final VoidCallback? onTap;
  final Widget child;

  const BrutalismCard({
    super.key,
    this.enabled = true,
    required this.primaryColor,
    required this.layerColor,
    required this.layerSpace,
    this.borderColor,
    this.borderWidth,
    this.padding = const EdgeInsets.all(12.0),
    this.radius = 8.0,
    this.onTap,
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
    Future.delayed(const Duration(milliseconds: 200), () {
      onHoverNotifier.value = false;

      widget.onTap?.call();
    });
  }

  void onTapCancel() {
    Future.delayed(const Duration(milliseconds: 200), () {
      onHoverNotifier.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: onHoverNotifier,
      builder: (context, onHover, child) {
        return GestureDetector(
          onTapDown: widget.enabled && widget.onTap != null ? (details) => onHoverNotifier.value = true : null,
          onTapUp: widget.enabled && widget.onTap != null ? (details) => onTapUp() : null,
          onTapCancel: widget.enabled && widget.onTap != null ? onTapCancel : null,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Positioned.fill(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: widget.layerSpace,
                    top: widget.layerSpace,
                  ),
                  decoration: BoxDecoration(
                    color: widget.layerColor,
                    border: Border.all(
                      color: widget.borderColor ?? Colors.black,
                      width: widget.borderWidth ?? 1,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius),
                  ),
                  padding: widget.padding,
                  child: const SizedBox(),
                ),
              ),
              AnimatedContainer(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: onHover || !widget.enabled
                    ? EdgeInsets.only(
                        left: widget.layerSpace,
                        top: widget.layerSpace,
                      )
                    : EdgeInsets.only(
                        right: widget.layerSpace,
                        bottom: widget.layerSpace,
                      ),
                decoration: BoxDecoration(
                  color: widget.enabled ? widget.primaryColor : Colors.white,
                  border: Border.all(
                    color: widget.enabled ? widget.borderColor ?? Colors.black : Colors.grey,
                    width: widget.borderWidth ?? 1,
                  ),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.radius - (widget.layerSpace / 2)),
                  child: Padding(
                    padding: widget.padding,
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
