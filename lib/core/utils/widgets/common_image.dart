import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  final String imageurl;
  final double? width;
  final double? height;
  final BoxFit fit;
  const CommonImage(
    this.imageurl, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageurl,
      cacheKey: imageurl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 600),
      fadeOutDuration: const Duration(milliseconds: 600),
      placeholder: (context, url) =>
          const ColoredBox(color: AppColors.contentFourth),
      errorWidget: (context, url, error) => const Center(
        child: ColoredBox(
          color: AppColors.contentFourth,
          child: Column(
            children: [
              Icon(Icons.error),
              Text('no Image'),
            ],
          ),
        ),
      ),
      errorListener: logging,
    );
  }
}
