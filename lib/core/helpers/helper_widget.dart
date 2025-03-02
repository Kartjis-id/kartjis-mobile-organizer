// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/snack_bar_type.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

/// A collection of helper widgets that are reusable for this app
class WidgetHelper {
  static SnackBar createSnackBar(
    String message, {
    required SnackBarType type,
    required Duration duration,
    required bool showCloseIcon,
  }) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: duration,
      backgroundColor: type.backgroundColor,
      showCloseIcon: showCloseIcon,
      closeIconColor: showCloseIcon ? Palette.scaffoldBackground : null,
      content: Row(
        children: [
          Icon(
            type.leadingIcon,
            color: Palette.scaffoldBackground,
            size: 20,
          ),
          const Gap(8),
          Flexible(
            child: Text(
              message,
              style: textTheme.bodyMedium!.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  static SnackBar createInternetConnectionSnackBar({
    required BuildContext context,
    required InternetStatus status,
  }) {
    final isConnected = status == InternetStatus.connected;

    return SnackBar(
      duration: isConnected ? const Duration(milliseconds: 1500) : const Duration(days: 1),
      backgroundColor: isConnected ? Palette.success : Palette.error,
      padding: EdgeInsets.zero,
      content: SizedBox(
        height: 28,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
              color: Palette.scaffoldBackground,
              size: 16,
            ),
            const Gap(6),
            Flexible(
              child: Text(
                isConnected ? context.localization.networkConnected : context.localization.networkDisconnected,
                style: textTheme.bodySmall!.scaffoldBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
