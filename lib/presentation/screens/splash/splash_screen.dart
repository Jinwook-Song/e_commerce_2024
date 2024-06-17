import 'dart:async';

import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/presentation/routes/routes.dart';
import 'package:e_commerce/presentation/screens/main/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => context.goNamed(Routes.main.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 앱이 실행될 때, login 자동 실행되도록
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: SvgPicture.asset(AppIcons.mainLogo),
        ),
      ),
    );
  }
}
