import 'package:e_commerce/presentation/screens/category/category_screen.dart';
import 'package:e_commerce/presentation/screens/home/home_screen.dart';
import 'package:e_commerce/presentation/screens/main/cubit/bottom_nav_cubit.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:e_commerce/presentation/screens/main/widgets/top_app_bar/top_app_bar.dart';
import 'package:e_commerce/presentation/screens/search/search_screen.dart';
import 'package:e_commerce/presentation/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => MallTypeCubit()),
      ],
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: BlocBuilder<BottomNavCubit, BottonNav>(
        builder: (_, state) {
          switch (state) {
            case BottonNav.home:
              return const HomeScreen();
            case BottonNav.category:
              return const CategoryScreen();
            case BottonNav.search:
              return const SearchScreen();
            case BottonNav.user:
              return const UserScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottonNav>(
        builder: (_, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) => context.read<BottomNavCubit>().changeIndex(index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              for (final navItem in BottonNav.values)
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(navItem.icon),
                  activeIcon: SvgPicture.asset(navItem.activeIcon),
                  label: navItem.tabLabel,
                ),
            ],
          );
        },
      ),
    );
  }
}