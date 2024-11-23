// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/pages/login_page.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/providers/auth_status_provider.dart';
import 'package:kartjis_mobile_organizer/features/home/presentation/pages/home_page.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({super.key});

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  late final StreamSubscription<InternetStatus> streamSubscription;
  late final AppLifecycleListener lifecycleListener;

  bool hasConnection = false;

  @override
  void initState() {
    super.initState();

    streamSubscription = ref.read(networkInfoProvider).onConnectionChange.listen(showInternetConnectionSnackBar);

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

  void showInternetConnectionSnackBar(InternetStatus status) {
    if (hasConnection) context.showInternetConnectionSnackBar(status);

    hasConnection = true;
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = ref.watch(authStatusProvider);

    return authStatus.when(
      loading: () => const Scaffold(),
      error: (_, __) => const Scaffold(),
      data: (isAlreadyLogin) {
        if (isAlreadyLogin != null && isAlreadyLogin) {
          return HomePage();
        }

        return LoginPage();
      },
    );
  }
}
