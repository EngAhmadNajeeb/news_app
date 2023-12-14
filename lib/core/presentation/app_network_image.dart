import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_images.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    required this.url,
    this.borderRadius = BorderRadius.zero,
  });
  final String url;
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        placeholderFadeInDuration: Duration.zero,
        fit: fit,
        height: height,
        width: width,
        imageUrl: url,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.pleaseHolder,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
