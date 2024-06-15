import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/core/utils/widgets/counter_button.dart';
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/screens/main/fragments/top_app_bar/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartPriceInfo extends StatelessWidget {
  const CartPriceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartBloc>().state;
    final cartBloc = context.read<CartBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.productInfo.title,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    state.productInfo.price.toWon(),
                    style:
                        Theme.of(context).textTheme.titleSmall?.priceCopyWith(),
                  ),
                ],
              ),
              CounterButton(
                quantity: state.quantity,
                decrease: () =>
                    context.read<CartBloc>().add(const CartQuantityDecreased()),
                increase: () =>
                    context.read<CartBloc>().add(const CartQuantityIncreased()),
              ),
            ],
          ),
          const Gap(12),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
