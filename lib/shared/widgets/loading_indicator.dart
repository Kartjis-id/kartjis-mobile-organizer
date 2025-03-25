// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final bool withScaffold;

  const LoadingIndicator({
    super.key,
    this.size = 30.0,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: buildLoadingIndicator(),
          )
        : buildLoadingIndicator();
  }

  Center buildLoadingIndicator() {
    return Center(
      child: Container(
        width: (size * 2) + 16,
        height: (size * 2) + 12,
        decoration: BoxDecoration(
          color: Palette.scaffoldBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SpinKitThreeBounce(
          size: size,
          color: Palette.primary,
          duration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
