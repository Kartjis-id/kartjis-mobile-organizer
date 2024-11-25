// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/helper_widget.dart';
import 'package:kartjis_mobile_organizer/core/utils/keys.dart';

extension SnackBarExtension on BuildContext {
  void showInternetConnectionSnackBar(InternetStatus status) {
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        WidgetHelper.createInternetConnectionSnackBar(
          context: this,
          status: status,
        ),
      );
  }
}

extension DialogExtension on BuildContext {}

extension TimePickerExtension on BuildContext {}

extension DatePickerExtension on BuildContext {}

extension LocalizationExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
