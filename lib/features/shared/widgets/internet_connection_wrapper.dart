// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/utils/keys.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/pages/login_page.dart';

class InternetConnectionWrapper extends ConsumerStatefulWidget {
  const InternetConnectionWrapper({super.key});

  @override
  ConsumerState<InternetConnectionWrapper> createState() => _InternetConnectionWrapperState();
}

class _InternetConnectionWrapperState extends ConsumerState<InternetConnectionWrapper> {
  late final StreamSubscription<InternetStatus> streamSubscription;
  late final AppLifecycleListener lifecycleListener;

  bool hasConnection = false;

  @override
  void initState() {
    super.initState();

    streamSubscription = InternetConnection().onStatusChange.listen(_toggleMaterialBanner);

    lifecycleListener = AppLifecycleListener(
      onResume: streamSubscription.resume,
      onHide: streamSubscription.pause,
      onPause: streamSubscription.pause,
    );
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    lifecycleListener.dispose();

    super.dispose();
  }

  void _toggleMaterialBanner(InternetStatus status) {
    if (hasConnection && status == InternetStatus.disconnected) {
      scaffoldMessengerKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('No internet connection!'),
            duration: Duration(hours: 24),
          ),
        );
    } else {
      scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    }

    hasConnection = true;
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
