// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalisms/brutalism_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets childPadding;
  final bool showPrimaryButton;
  final String? primaryButtonText;
  final VoidCallback? onPressedPrimaryButton;

  const CustomDialog({
    super.key,
    required this.title,
    required this.child,
    this.childPadding = const EdgeInsets.fromLTRB(20, 12, 20, 16),
    this.showPrimaryButton = true,
    this.primaryButtonText,
    this.onPressedPrimaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                title,
                style: textTheme.titleLarge!.copyWith(
                  height: 1.25,
                ),
              ),
            ),
            Padding(
              padding: childPadding,
              child: child,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: BrutalismButton(
                      color: Palette.scaffoldBackground,
                      layerColor: Palette.primary,
                      layerSpace: 3.5,
                      borderColor: Palette.primary,
                      textColor: Palette.primary,
                      text: 'Back',
                      onTap: () => navigatorKey.currentState?.pop(),
                    ),
                  ),
                  if (showPrimaryButton) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: BrutalismButton(
                        color: Palette.primary,
                        layerColor: Palette.scaffoldBackground,
                        layerSpace: 3.5,
                        borderColor: Palette.primary,
                        text: primaryButtonText ?? 'Select',
                        onTap: onPressedPrimaryButton,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
