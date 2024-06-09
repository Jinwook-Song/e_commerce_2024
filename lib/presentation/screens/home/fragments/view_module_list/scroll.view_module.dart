import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:e_commerce/domain/model/display/view_module/viee_module.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/product_card.component.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_padding.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_subtitle.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_title.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ScrollViewModule extends StatelessWidget with ViewModuleWidget {
  final ViewModule info;

  const ScrollViewModule(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewModulePadding(
          child: Column(
            children: [
              ViewModuleTitle(title: info.title),
              if (info.subtitle.isNotEmpty)
                ViewModuleSubtitle(subtitle: info.subtitle),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 50),
          child: _ImageList(info.products),
        ),
      ],
    );
  }
}

class _ImageList extends StatelessWidget {
  final List<ProductInfo> products;
  const _ImageList(this.products);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 305,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: Constants.horizontalPadding,
        itemCount: products.length,
        separatorBuilder: (_, __) => const Gap(8),
        itemBuilder: (_, index) {
          final productInfo = products[index];

          return AspectRatio(
            aspectRatio: 150 / 305,
            child: LargeProductCard(context, productInfo: productInfo),
          );
        },
      ),
    );
  }
}
