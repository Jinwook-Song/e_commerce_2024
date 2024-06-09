import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/product_card.dart';
import 'package:flutter/material.dart';

// 전체 구조는 동일하지만 속성을 다르게 설정하고 싶은 경우

class LargeProductCard extends ProductCard {
  final BuildContext context;

  LargeProductCard(
    this.context, {
    super.key,
    required super.productInfo,
  }) : super(
          imageAspectRatio: 150 / 190,
          needShowReviewCount: true,
          titleStyle: Theme.of(context).textTheme.titleSmall,
          priceStyle: Theme.of(context).textTheme.titleSmall,
          originalPriceStyle: Theme.of(context).textTheme.labelMedium,
          reviewStyle: Theme.of(context).textTheme.labelSmall,
        );
}

class SmallProductCard extends ProductCard {
  final BuildContext context;

  SmallProductCard(
    this.context, {
    super.key,
    required super.productInfo,
  }) : super(
          imageAspectRatio: 114 / 152,
          needShowReviewCount: false,
          titleStyle: Theme.of(context).textTheme.labelMedium,
          priceStyle: Theme.of(context).textTheme.labelMedium,
          originalPriceStyle: Theme.of(context).textTheme.labelMedium,
          reviewStyle: Theme.of(context).textTheme.labelSmall,
        );
}
