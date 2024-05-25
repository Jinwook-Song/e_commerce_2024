import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/presentation/screens/main/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(this.nav, {super.key});

  final BottonNav nav;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            nav.tabLabel,
            style: const TextStyle(color: AppColors.white, fontSize: 20).bold,
          ),
        ),
      ),
    );
  }
}
