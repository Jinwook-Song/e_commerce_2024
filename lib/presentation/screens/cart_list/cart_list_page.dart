import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:e_commerce/presentation/screens/cart_list/fragments/cart_product_card/cart_product_card.dart';
import 'package:e_commerce/presentation/screens/cart_list/fragments/cart_total_price/cart_total_price.dart';
import 'package:e_commerce/presentation/screens/main/widgets/top_app_bar/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CartListBloc>(context)
        ..add(const CartListInitialized()),
      child: const CartListView(),
    );
  }
}

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        leading: Center(
          child: SvgIconButton(
            icon: AppIcons.close,
            color: colorScheme.contentPrimary,
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
        ),
        title: const Text('장바구니'),
        centerTitle: true,
        titleTextStyle: textTheme.titleMedium
            ?.copyWith(color: colorScheme.contentPrimary)
            .semiBold,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<CartListBloc, CartListState>(
                  builder: (context, state) {
                    final bool isSelectedAll =
                        state.selectedProduct.length == state.cartList.length &&
                            state.cartList.isNotEmpty;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgIconButton(
                              padding: 0,
                              icon: isSelectedAll
                                  ? AppIcons.checkMarkCircleFill
                                  : AppIcons.checkMarkCircle,
                              color: isSelectedAll
                                  ? colorScheme.primary
                                  : colorScheme.contentFourth,
                              onPressed: () => context.read<CartListBloc>()
                                ..add(const CartListSelectedAll()),
                            ),
                            const Gap(8),
                            Text(
                              '전체 선택 (${state.selectedProduct.length}/${state.cartList.length})',
                              style: textTheme.titleSmall
                                  ?.copyWith(color: colorScheme.contentPrimary),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => context.read<CartListBloc>()
                            ..add(
                              CartListDeleted(
                                productIds: state.selectedProduct,
                              ),
                            ),
                          child: Text(
                            '선택 삭제',
                            style: textTheme.titleSmall.semiBold
                                ?.copyWith(color: colorScheme.contentSecondary),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Gap(8),
              Divider(
                height: 8,
                thickness: 8,
                color: colorScheme.surface,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<CartListBloc, CartListState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.initial:
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text('init'),
                      ),
                    );
                  case Status.success:
                    return Column(
                      children: [
                        ...state.cartList
                            .map((cart) => CartProductCard(cart: cart)),
                        const CartTotalPrice(),
                      ],
                    );
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.error:
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text('error'),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
      //TODO 결제 버튼
    );
  }
}
