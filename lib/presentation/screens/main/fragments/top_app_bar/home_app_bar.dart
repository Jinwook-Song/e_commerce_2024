import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_app_bar.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/presentation/routes/routes.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:e_commerce/presentation/screens/main/fragments/top_app_bar/svg_icon_button.dart';
import 'package:e_commerce/presentation/screens/main/utils/server_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: state.theme.backgroundColor,
          child: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: state.theme.systemUiOverlayStyle,
            leadingWidth: 86,
            leading: AbsorbPointer(
              absorbing: dotenv.env['FLAVOR'] == 'prod',
              child: SvgIconButton(
                icon: AppIcons.mainLogo,
                color: state.theme.logoColor,
                padding: 8,
                onPressed: () async {
                  // throw Exception();
                  await showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return const ServerSelector();
                    },
                  );
                },
              ),
            ),
            centerTitle: true,
            title: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: state.theme.containerColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(CustomAppBarTheme.tabBarRadius),
                ),
              ),
              child: SizedBox(
                height: 28,
                child: DefaultTabController(
                  length: MallType.values.length,
                  initialIndex: state.index,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    tabs: List.generate(
                      MallType.values.length,
                      (index) => Tab(
                        text: MallType.values[index].label,
                      ),
                    ),
                    indicatorWeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: state.theme.indicatorColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(CustomAppBarTheme.tabBarRadius),
                      ),
                    ),
                    dividerColor: Colors.transparent,
                    labelColor: state.theme.labelColor,
                    labelStyle: Theme.of(context).textTheme.labelLarge.bold,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    unselectedLabelColor: state.theme.unselectedLabelColor,
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.labelLarge,
                    onTap: (index) =>
                        context.read<MallTypeCubit>().changeIndex(index),
                    splashBorderRadius: const BorderRadius.all(
                      Radius.circular(CustomAppBarTheme.tabBarRadius),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              SvgIconButton(
                icon: AppIcons.location,
                color: state.theme.iconColor,
                onPressed: () {},
              ),
              Badge.count(
                count: context.watch<CartListBloc>().state.cartList.length,
                offset: const Offset(-2, 2),
                backgroundColor: state.theme.badgeBgColor,
                textColor: state.theme.badgeNumColor,
                largeSize: 13,
                textStyle: const TextStyle(fontSize: 9).bold,
                child: SvgIconButton(
                  icon: AppIcons.cart,
                  color: state.theme.iconColor,
                  onPressed: () => context.pushNamed(Routes.cartList.name),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
