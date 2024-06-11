import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:e_commerce/domain/model/display/view_module/viee_module.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_padding.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BrandProductViewModule extends StatelessWidget with ViewModuleWidget {
  final ViewModule info;

  const BrandProductViewModule(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ViewModulePadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewModuleTitle(
            title: info.title,
          ),
          const Gap(8),
          if (info.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: AspectRatio(
                aspectRatio: 343 / 173,
                child: Image.network(
                  info.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (info.subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: Text(
                info.subtitle,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(
                      color: colorScheme.contentSecondary,
                    )
                    .regular,
              ),
            ),
          Divider(
            thickness: 1,
            color: colorScheme.outline,
          ),
          const Gap(16),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: info.products.length,
            separatorBuilder: (context, index) => const Gap(8),
            itemBuilder: (_, index) {
              return _BrandProduct(info.products[index]);
            },
          ),
          const Gap(8),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '전체보기',
                    style: textTheme.titleSmall
                        ?.copyWith(
                          color: colorScheme.contentPrimary,
                        )
                        .regular,
                  ),
                  SvgPicture.asset(
                    AppIcons.chevronRight,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      colorScheme.contentPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}

class _BrandProduct extends StatelessWidget {
  final ProductInfo productInfo;

  const _BrandProduct(this.productInfo);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 343 / 61,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 49,
            height: 49,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              child: Image.network(
                productInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(11),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productInfo.title,
                    style: textStyle.labelLarge?.titleCopyWith(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${productInfo.discountRate}%',
                        style: textStyle.labelLarge?.discountRateCopyWith(),
                      ),
                      const Gap(4),
                      Text(
                        productInfo.price.toWon(),
                        style: textStyle.labelLarge?.priceCopyWith(),
                      ),
                      const Gap(4),
                      Text(
                        productInfo.originalPrice.toWon(),
                        style: textStyle.labelMedium?.originalPriceCopyWith(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)
                    .copyWith(left: 8),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.cart,
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      colorScheme.contentPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '담기',
                    style: textStyle.titleSmall
                        ?.copyWith(
                          color: colorScheme.contentPrimary,
                        )
                        .regular,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
