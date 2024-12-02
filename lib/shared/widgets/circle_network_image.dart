// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class CircleNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double? loadingIndicatorSize;
  final double? borderWidth;
  final Color? borderColor;
  final BoxFit fit;

  const CircleNetworkImage({
    super.key,
    required this.imageUrl,
    required this.size,
    this.loadingIndicatorSize,
    this.borderWidth,
    this.borderColor,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
        imageBuilder: (context, imageProvider) => buildImage(
          imageProvider: imageProvider,
        ),
        placeholder: (context, url) => buildCircleContainer(
          child: SizedBox(
            width: loadingIndicatorSize ?? size / 2.5,
            height: loadingIndicatorSize ?? size / 2.5,
            child: const SpinKitRing(
              color: Palette.disabled,
              lineWidth: 2,
            ),
          ),
        ),
        errorWidget: (context, url, error) => buildCircleContainer(
          child: SvgAsset(
            AssetPath.getIcon('no_image_outlined.svg'),
            width: loadingIndicatorSize ?? size / 2.5,
            height: loadingIndicatorSize ?? size / 2.5,
            color: Palette.disabled,
          ),
        ),
      );
    }

    return buildImage(
      imageProvider: AssetImage(
        AssetPath.getImage('no-profile.png'),
      ),
    );
  }

  CircleAvatar buildCircleContainer({required Widget child}) {
    return CircleAvatar(
      backgroundColor: Palette.background,
      radius: size / 2,
      child: Center(
        child: child,
      ),
    );
  }

  Container buildImage({required ImageProvider<Object> imageProvider}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
        border: borderWidth != null
            ? Border.all(
                width: borderWidth!,
                color: borderColor ?? Palette.primary,
              )
            : null,
      ),
    );
  }
}
