import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/core/utils/widgets/counter_button.dart';
import 'package:e_commerce/domain/model/display/cart/cart.model.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({required this.cart, super.key});
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedList = context.watch<CartListBloc>().state.selectedProduct;
    final bool isSelected = selectedList.contains(cart.product.productId);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .add(const EdgeInsets.only(top: 20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 체크 박스
          GestureDetector(
            onTap: () =>
                context.read<CartListBloc>().add(CartListSelected(cart: cart)),
            child: SvgPicture.asset(
              (isSelected)
                  ? AppIcons.checkMarkCircleFill
                  : AppIcons.checkMarkCircle,
              colorFilter: ColorFilter.mode(
                (isSelected) ? colorScheme.primary : colorScheme.contentFourth,
                BlendMode.srcIn,
              ),
            ),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상품 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 상품 명
                          SizedBox(
                            height: 28,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                cart.product.title,
                                style: textTheme.titleSmall
                                    ?.titleCopyWith()
                                    .regular,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const Gap(11),
                          // 상품 정보
                          SizedBox(
                            height: 75,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // 상품 이미지
                                Image.network(
                                  cart.product.imageUrl,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                const Gap(20),

                                // 상품 정보
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 가격
                                    Text(
                                      cart.product.price.toWon(),
                                      style: textTheme.titleMedium
                                          ?.priceCopyWith(),
                                    ),

                                    const Spacer(),
                                    // 수량 설정
                                    CounterButton(
                                      quantity: cart.quantity,
                                      decrease: () =>
                                          context.read<CartListBloc>().add(
                                                CartListQtyDecreased(
                                                  cart: cart,
                                                ),
                                              ),
                                      increase: () =>
                                          context.read<CartListBloc>().add(
                                                CartListQtyIncreased(
                                                  cart: cart,
                                                ),
                                              ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 28,
                      child: GestureDetector(
                        onTap: () => context.read<CartListBloc>().add(
                              CartListDeleted(
                                productIds: [cart.product.productId],
                              ),
                            ),
                        child: SvgPicture.asset(
                          AppIcons.close,
                          width: 28,
                          height: 28,
                          colorFilter: ColorFilter.mode(
                            colorScheme.contentTertiary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                  ),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
