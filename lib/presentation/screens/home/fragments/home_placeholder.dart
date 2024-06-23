import 'package:e_commerce/presentation/screens/main/fragments/placeholder/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ShimmerFromColors(
          child: CarouselPlaceholder(),
        ),
        Gap(20),
        ShimmerFromColors(
          child: ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
        ),
        Gap(20),
        ShimmerFromColors(
          child: BannerPlaceholder(),
        ),
        Gap(20),
        ShimmerFromColors(
          child: ContentPlaceholder(
            lineType: ContentLineType.threeLines,
          ),
        ),
        Gap(20),
        ShimmerFromColors(
          child: ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
        ),
        Gap(20),
        ShimmerFromColors(
          child: ContentPlaceholder(
            lineType: ContentLineType.threeLines,
          ),
        ),
        Gap(20),
        ShimmerFromColors(
          child: ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
        ),
        Gap(20),
        ShimmerFromColors(
          child: ContentPlaceholder(
            lineType: ContentLineType.threeLines,
          ),
        ),
        Gap(20),
      ],
    );
  }
}
