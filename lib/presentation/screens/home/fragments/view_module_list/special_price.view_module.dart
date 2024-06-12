import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:e_commerce/domain/model/display/view_module/viee_module.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/add_cart_button.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/timer_widget.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_padding.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_subtitle.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SpecialPriceViewModule extends StatelessWidget with ViewModuleWidget {
  final ViewModule info;
  const SpecialPriceViewModule(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ViewModulePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewModuleTitle(title: info.title),
            ViewModuleSubtitle(subtitle: info.subtitle),
            if (info.time > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Lottie.asset(
                      AppIcons.lottieClock,
                      width: 20,
                      delegates: LottieDelegates(
                        values: [
                          ValueDelegate.color(
                            const ['Oval', 'Oval', 'Fill 1'], // layer 이름, 모양,
                            value: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ],
                      ),
                    ),
                    const Gap(5),
                    TimerWidget(
                      endTime: DateTime.fromMillisecondsSinceEpoch(info.time),
                    ),
                  ],
                ),
              ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: info.products.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) =>
                  _SpecialPriceProduct(info.products[index]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecialPriceProduct extends StatelessWidget {
  final ProductInfo productInfo;

  const _SpecialPriceProduct(this.productInfo);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 343 / 174,
              child: Image.network(
                productInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            AddCartButton(productInfo),
          ],
        ),
        const Gap(9),
        Text(
          productInfo.subtitle,
          style: textTheme.labelLarge
              ?.copyWith(
                color: colorScheme.contentTertiary,
              )
              .regular,
        ),
        Text(
          productInfo.title,
          style: textTheme.titleMedium?.titleCopyWith(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const Gap(4),
        Row(
          children: [
            Text(
              '${productInfo.discountRate.toString()}%',
              style: textTheme.titleLarge?.discountRateCopyWith(),
            ),
            const Gap(4),
            Text(
              productInfo.price.toWon(),
              style: textTheme.titleLarge?.priceCopyWith(),
            ),
            const Gap(4),
            Text(
              productInfo.originalPrice.toWon(),
              style: textTheme.titleSmall?.originalPriceCopyWith(),
            ),
          ],
        ),
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
            Text(
              '후기 ${productInfo.reviewCount.toReview()}',
              style: textTheme.labelMedium?.reviewCountCopyWith(),
            ),
          ],
        ),
      ],
    );
  }
}
