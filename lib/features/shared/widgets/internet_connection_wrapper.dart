// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/pages/login_page.dart';

// import 'package:kartjis_mobile_organizer/core/utils/keys.dart';

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

    streamSubscription = ref.read(networkInfoProvider).onConnectionChange.listen(toggleInternetConnectionBanner);

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

  void toggleInternetConnectionBanner(InternetStatus status) {
    if (hasConnection && status == InternetStatus.disconnected) {
      // scaffoldMessengerKey.currentState
      //   ?..hideCurrentMaterialBanner()
      //   ..showMaterialBanner(
      //     // MaterialBanner(content: content, actions: actions),
      //   );
    } else {
      // scaffoldMessengerKey.currentState
      //   ?..hideCurrentMaterialBanner()
      //   ..showMaterialBanner(
      //     // MaterialBanner(content: content, actions: actions),
      //   );
    }

    hasConnection = true;
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
