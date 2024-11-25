// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';

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
            body: _buildLoadingIndicator(),
          )
        : _buildLoadingIndicator();
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: SpinKitFoldingCube(
        size: size.dp,
        duration: const Duration(milliseconds: 2000),
        itemBuilder: (context, index) {
          final colors = [
            Palette.primary,
            Palette.primary.withOpacity(.9),
            Palette.primary.withOpacity(.8),
            Palette.primary.withOpacity(.7),
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
