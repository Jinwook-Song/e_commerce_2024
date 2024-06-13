import 'package:e_commerce/core/utils/bottom_sheet/widgets/add_cart_btn.dart';
import 'package:e_commerce/core/utils/bottom_sheet/widgets/cart_price_info.dart';
import 'package:e_commerce/core/utils/bottom_sheet/widgets/cart_product_info.dart';
import 'package:flutter/material.dart';

Future<bool?> cartBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.0),
      ),
    ),
    builder: (_) {
      return const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartProductInfo(),
              Divider(height: 1, thickness: 1),
              CartPriceInfo(),
              AddCartBtn(),
            ],
          ),
        ),
      );
    },
  );
}
