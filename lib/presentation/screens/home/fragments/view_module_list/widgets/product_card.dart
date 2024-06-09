import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/add_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  final ProductInfo productInfo;
  final double imageAspectRatio;
  const ProductCard({
    super.key,
    required this.productInfo,
    required this.imageAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: imageAspectRatio,
              child: Image.network(
                productInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const AddCartButton(),
          ],
        ),
        const Gap(9),
        Text(
          productInfo.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const Gap(9),
        Row(
          children: [
            Text('${productInfo.discountRate}%'),
            const Gap(4),
            Text(productInfo.price.toWon()),
          ],
        ),
        const Gap(2),
        Text(productInfo.originalPrice.toWon()),
        const Gap(8),
        Row(
          children: [
            SvgPicture.asset(
              AppIcons.chat,
              width: 13,
              height: 13,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.contentTertiary,
                BlendMode.srcIn,
              ),
            ),
            const Gap(4),
            Text('후기: ${productInfo.reviewCount.toReview()}'),
          ],
        ),
      ],
    );
  }
}
