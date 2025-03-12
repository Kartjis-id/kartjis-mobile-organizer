// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/shared/providers/manual_providers/search_provider.dart';

/// A collection of helper functions that are reusable for this app
class FunctionHelper {
  static Map<String, String> formattedDurationMap([int seconds = 0]) {
    final day = '${seconds ~/ 86400}'.padLeft(2, '0');
    final hour = '${(seconds % 86400) ~/ 3600}'.padLeft(2, '0');
    final min = '${(seconds % 3600) ~/ 60}'.padLeft(2, '0');
    final sec = '${seconds % 60}'.padLeft(2, '0');

    return {
      'day': day,
      'hour': hour,
      'min': min,
      'sec': sec,
    };
  }

  static bool handleFabVisibilityOnScroll(
    AnimationController controller,
    UserScrollNotification notification,
  ) {
    if (notification.depth != 0) return false;

    switch (notification.direction) {
      case ScrollDirection.forward:
        if (notification.metrics.maxScrollExtent != notification.metrics.minScrollExtent) {
          if (notification.metrics.pixels != 0) {
            controller.forward();
          }
        }

        break;
      case ScrollDirection.reverse:
        if (notification.metrics.maxScrollExtent != notification.metrics.minScrollExtent) {
          controller.reverse();
        }

        break;
      case ScrollDirection.idle:
        break;
    }

    return false;
  }

  static void handleSearchingOnPop(
    WidgetRef ref,
    bool didPop,
    bool isSearching, {
    ProviderOrFamily? provider,
    VoidCallback? postHandleCallback,
  }) {
    if (didPop) return;

    if (isSearching) {
      ref.read(searchProvider.notifier).reset();

      if (provider != null) ref.invalidate(provider);
    } else {
      postHandleCallback?.call();
    }
  }
}
