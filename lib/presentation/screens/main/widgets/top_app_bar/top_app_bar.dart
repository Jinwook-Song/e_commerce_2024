import 'package:e_commerce/presentation/screens/main/cubit/bottom_nav_cubit.dart';
import 'package:e_commerce/presentation/screens/main/widgets/top_app_bar/defualt_app_bar.dart';
import 'package:e_commerce/presentation/screens/main/widgets/top_app_bar/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottonNav>(
      builder: (context, state) {
        switch (state) {
          case BottonNav.home:
            return const HomeAppbar();
          case _:
            return DefaultAppBar(state);
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
