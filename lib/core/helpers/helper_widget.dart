// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
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
        height: 28,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
              color: Palette.scaffoldBackground,
              size: 16,
            ),
            Gap(6),
            Text(
              isConnected
                  ? AppLocalizations.of(context)!.networkConnected
                  : AppLocalizations.of(context)!.networkDisconnected,
              style: textTheme.bodySmall?.scaffoldBackground,
            ),
          ],
        ),
      ),
    );
  }
}
