// Flutter imports:
import 'package:flutter/material.dart';

class BrutalismButton extends StatefulWidget {
  final bool enabled;
  final double radius;
  final Color color;
  final Color layerColor;
  final double layerSpace;
  final Color? borderColor;
  final double? borderWidth;
  final Color? textColor;
  final String text;
  final Widget? leading;
  final VoidCallback? onTap;

  const BrutalismButton({
    super.key,
    this.enabled = true,
    this.radius = 8.0,
    required this.color,
    required this.layerColor,
    required this.layerSpace,
    this.borderColor,
    this.borderWidth,
    this.textColor,
    required this.text,
    this.leading,
    this.onTap,
  });

  @override
  State<BrutalismButton> createState() => _BrutalismButtonState();
}

class _BrutalismButtonState extends State<BrutalismButton> {
  final ValueNotifier<bool> onHoverNotifier = ValueNotifier(false);

  @override
  void dispose() {
    onHoverNotifier.dispose();

    super.dispose();
  }

  void onTapUp() {
    FocusManager.instance.primaryFocus?.unfocus();

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
      builder: (context, onHover, ___) {
        return GestureDetector(
          onTapDown: widget.enabled ? (details) => onHoverNotifier.value = true : null,
          onTapUp: widget.enabled ? (details) => onTapUp() : null,
          onTapCancel: widget.enabled ? onTapCancel : null,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                height: 44,
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
                child: const SizedBox(),
              ),
              AnimatedContainer(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                height: 44,
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
                  color: widget.enabled ? widget.color : Colors.white,
                  border: Border.all(
                    color: widget.enabled ? widget.borderColor ?? Colors.black : Colors.grey,
                    width: widget.borderWidth ?? 1,
                  ),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(width: 4),
                    ],
                    Center(
                      child: Text(
                        widget.text,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: widget.enabled ? widget.textColor ?? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
