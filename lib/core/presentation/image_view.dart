import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_images.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    required this.imagePath,
    required this.heroTag,
    super.key,
  });
  final String heroTag;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image View'),
      ),
      body: Hero(
        tag: heroTag,
        child: Center(
          child: PhotoView.customChild(
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 3,
            // backgroundDecoration: BoxDecoration(color: Colors.grey[200]),
            child: Visibility(
              visible: imagePath.isNotEmpty,
              replacement: Image.asset(
                AppImages.pleaseHolder,
              ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
