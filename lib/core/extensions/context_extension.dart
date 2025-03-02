// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/snack_bar_type.dart';
import 'package:kartjis_mobile_organizer/core/helpers/helper_widget.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/loading_indicator.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 3),
    bool showCloseIcon = false,
  }) {
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        WidgetHelper.createSnackBar(
          message,
          type: type,
          duration: duration,
          showCloseIcon: showCloseIcon,
        ),
      );
  }

  void showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        WidgetHelper.createSnackBar(
          message,
          type: SnackBarType.error,
          duration: const Duration(seconds: 3),
          showCloseIcon: false,
        ),
      );
  }

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

extension DialogExtension on BuildContext {
  Future<Object?> showLoadingDialog() {
    return showDialog(
      context: this,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (_) => const LoadingIndicator(),
    );
  }
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}

extension MediaQueryExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;
}
