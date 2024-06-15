import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _btnHeight = 48;

class AddCartBtn extends StatelessWidget {
  const AddCartBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBlocState = context.watch<CartBloc>().state;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      child: GestureDetector(
        onTap: () => context.read<CartListBloc>()
          ..add(
            CartListAdded(
              quantity: cartBlocState.quantity,
              productInfo: cartBlocState.productInfo,
            ),
          ),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          width: MediaQuery.of(context).size.width,
          height: _btnHeight,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: cartBlocState.totalPrice.toWon(),
                  style: textTheme.titleSmall?.semiBold?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                TextSpan(
                  text: ' 장바구니 담기',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
