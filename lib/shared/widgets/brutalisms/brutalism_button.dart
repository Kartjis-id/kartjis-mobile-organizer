// Flutter imports:
import 'package:flutter/material.dart';

class BrutalismButton extends StatefulWidget {
  final bool enabled;
  final String text;
  final Color? textColor;
  final Color primaryColor;
  final Color layerColor;
  final double layerSpace;
  final Color? borderColor;
  final Widget? leading;
  final double radius;
  final VoidCallback? onTap;

  const BrutalismButton({
    super.key,
    this.enabled = true,
    required this.text,
    this.textColor,
    required this.primaryColor,
    required this.layerColor,
    required this.layerSpace,
    this.borderColor,
    this.leading,
    this.radius = 8.0,
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
                  ),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                padding: const EdgeInsets.all(12),
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
                  color: widget.enabled ? widget.primaryColor : Colors.white,
                  border: Border.all(
                    color: widget.enabled ? widget.borderColor ?? Colors.black : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                padding: const EdgeInsets.all(12),
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
