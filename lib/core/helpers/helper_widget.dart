// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sizer/sizer.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/snack_bar_type.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

/// A collection of helper widgets that are reusable for this app
class WidgetHelper {
  static SnackBar createInternetConnectionSnackBar({
    required BuildContext context,
    required InternetStatus status,
  }) {
    final isConnected = status == InternetStatus.connected;

    return SnackBar(
      padding: EdgeInsets.zero,
      duration: isConnected ? Duration(milliseconds: 1500) : Duration(days: 1),
      backgroundColor: isConnected ? Palette.success : Palette.error,
      content: SizedBox(
        height: 28.dp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
              color: Palette.scaffoldBackground,
              size: 16.dp,
            ),
            Gap(6.dp),
            Text(
              isConnected ? context.localization.networkConnected : context.localization.networkDisconnected,
              style: textTheme.bodySmall!.scaffoldBackground,
            ),
          ],
        ),
      ),
    );
  }

  static SnackBar createCustomSnackBar(
    String message, {
    required SnackBarType type,
    required Duration duration,
  }) {
    return SnackBar(
      duration: duration,
      backgroundColor: type.backgroundColor,
      showCloseIcon: true,
      closeIconColor: Palette.scaffoldBackground,
      content: Row(
        children: [
          Icon(
            type.leadingIcon,
            color: Palette.scaffoldBackground,
            size: 20.dp,
          ),
          Gap(8.dp),
          Text(
            message,
            style: textTheme.bodyMedium!.scaffoldBackground,
          ),
        ],
      ),
    );
  }
}
