// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Widget? child;

  const AnimatedFloatingActionButton({
    super.key,
    required this.animationController,
    this.onPressed,
    this.tooltip,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animationController,
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton(
        heroTag: 'animated_fab',
        elevation: 4,
        highlightElevation: 8,
        foregroundColor: Palette.primaryText,
        backgroundColor: Palette.purpleLight,
        shape: const CircleBorder(
          side: BorderSide(
            color: Palette.primaryText,
            width: 2,
          ),
        ),
        onPressed: onPressed,
        tooltip: tooltip,
        child: child,
      ),
    );
  }
}
