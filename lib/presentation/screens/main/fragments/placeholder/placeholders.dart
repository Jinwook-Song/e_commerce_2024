import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CarouselPlaceholder extends StatelessWidget {
  const CarouselPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 390 / 354,
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 390 / 82,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    super.key,
    required this.lineType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            width: 96.0,
            height: 72.0,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 10.0,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 10.0,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(color: Colors.white, width: 100.0, height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerFromColors extends StatelessWidget {
  final Widget child;

  const ShimmerFromColors({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}
