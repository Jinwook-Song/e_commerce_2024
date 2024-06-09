import 'package:e_commerce/domain/model/display/view_module/viee_module.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ScrollViewModule extends StatelessWidget with ViewModuleWidget {
  final ViewModule info;
  const ScrollViewModule(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      productInfo: info.products.first,
      imageAspectRatio: 150 / 195,
    );
  }
}
