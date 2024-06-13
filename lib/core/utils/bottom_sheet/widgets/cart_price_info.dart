import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/screens/main/widgets/top_app_bar/svg_icon_button.dart';
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
              Container(
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.grey),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                width: 100,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgIconButton(
                      icon: AppIcons.subtract,
                      color: (state.quantity != 1)
                          ? Theme.of(context).colorScheme.contentPrimary
                          : Theme.of(context).colorScheme.contentFourth,
                      onPressed: () => context
                          .read<CartBloc>()
                          .add(const CartQuantityDecreased()),
                    ),
                    Text('${state.quantity}'),
                    SvgIconButton(
                      icon: AppIcons.add,
                      color: Theme.of(context).colorScheme.contentPrimary,
                      onPressed: () => context
                          .read<CartBloc>()
                          .add(const CartQuantityIncreased()),
                    ),
                  ],
                ),
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
