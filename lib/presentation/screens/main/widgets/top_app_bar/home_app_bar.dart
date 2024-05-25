import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: state.theme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leadingWidth: 86,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppIcons.mainLogo,
                  colorFilter: ColorFilter.mode(
                    state.theme.logoColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              centerTitle: true,
              title: DefaultTabController(
                length: MallType.values.length,
                initialIndex: state.index,
                child: TabBar(
                  onTap: (index) =>
                      context.read<MallTypeCubit>().changeIndex(index),
                  labelColor: AppColors.black,
                  unselectedLabelColor: AppColors.black,
                  tabs: List.generate(
                    MallType.values.length,
                    (index) => Tab(
                      child: Text(
                        MallType.values[index].label,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    AppIcons.location,
                    colorFilter: ColorFilter.mode(
                      state.theme.logoColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    AppIcons.cart,
                    colorFilter: ColorFilter.mode(
                      state.theme.logoColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
