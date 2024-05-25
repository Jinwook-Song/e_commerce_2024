import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/presentation/screens/main/cubit/bottom_nav_cubit.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(this.nav, {super.key});

  final BottonNav nav;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (context, state) {
        return Container(
          color: state.theme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                nav.tabLabel,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    .semiBold
                    ?.copyWith(color: state.theme.iconColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
