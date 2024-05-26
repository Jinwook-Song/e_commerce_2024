import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/presentation/screens/home/bloc/menu_bloc/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalNavBar extends StatelessWidget {
  final List<Menu> menus;

  const GlobalNavBar(this.menus, {super.key});

  int get menuLength => menus.length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Stack(
          children: [
            TabBar(
              tabs: List.generate(
                menuLength,
                (index) => Tab(
                  text: menus[index].title,
                ),
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              labelStyle: theme.textTheme.titleSmall.semiBold,
              unselectedLabelStyle: theme.textTheme.titleSmall,
              unselectedLabelColor: theme.colorScheme.contentSecondary,
            ),
            if (state.status == Status.loading)
              Positioned.fill(
                child: ColoredBox(
                  color: AppColors.primary.withOpacity(0.2),
                  child: Center(
                    child: Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
