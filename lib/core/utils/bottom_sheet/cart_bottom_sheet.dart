import 'package:e_commerce/core/utils/bottom_sheet/widgets/add_cart_btn.dart';
import 'package:e_commerce/core/utils/bottom_sheet/widgets/cart_price_info.dart';
import 'package:e_commerce/core/utils/bottom_sheet/widgets/cart_product_info.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      return SafeArea(
        child: BlocListener<CartListBloc, CartListState>(
          listener: (context, state) {
            if (context.canPop()) context.pop();
          },
          listenWhen: (previous, current) => previous.status != current.status,
          child: const SingleChildScrollView(
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
        ),
      );
    },
  );
}
