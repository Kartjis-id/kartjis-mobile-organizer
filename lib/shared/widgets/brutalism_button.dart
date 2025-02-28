// Flutter imports:
import 'package:flutter/material.dart';

class BrutalismButton extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color layerColor;
  final Color? borderColor;
  final Color? textColor;
  final double layerSpace;
  final VoidCallback onTap;
  final bool isEnabled;
  final Widget? leading;
  final double radius;

  const BrutalismButton({
    super.key,
    required this.title,
    required this.primaryColor,
    required this.layerColor,
    this.borderColor,
    this.textColor,
    required this.layerSpace,
    required this.onTap,
    this.isEnabled = true,
    this.leading,
    this.radius = 8.0,
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

    Future.delayed(const Duration(milliseconds: 150), () {
      onHoverNotifier.value = false;

      widget.onTap.call();
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
          onTapDown: widget.isEnabled ? (details) => onHoverNotifier.value = true : null,
          onTapUp: widget.isEnabled ? (details) => onTapUp() : null,
          onTapCancel: widget.isEnabled ? onTapCancel : null,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 44,
                margin: EdgeInsets.only(
                  left: widget.layerSpace,
                  top: widget.layerSpace,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  color: widget.layerColor,
                  border: Border.all(
                    color: widget.borderColor ?? Colors.black,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: const SizedBox(),
              ),
              AnimatedContainer(
                width: double.infinity,
                height: 44,
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
                    color: widget.isEnabled ? widget.borderColor ?? Colors.black : Colors.grey,
                  ),
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
                        widget.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: widget.isEnabled ? widget.textColor ?? Colors.white : Colors.grey,
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
