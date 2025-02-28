// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/theme/color_scheme.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final bool withScaffold;

  const LoadingIndicator({
    super.key,
    this.size = 50.0,
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
      child: SpinKitFoldingCube(
        size: size,
        duration: const Duration(milliseconds: 1500),
        itemBuilder: (context, index) {
          final colors = [
            Palette.secondary.withValues(alpha: .8),
            Palette.tertiary.withValues(alpha: .8),
            Palette.purple300.withValues(alpha: .8),
            Palette.primary.withValues(alpha: .8),
          ];

          return DecoratedBox(
            decoration: BoxDecoration(
              color: colors[index % colors.length],
            ),
          );
        },
      ),
    );
  }
}
