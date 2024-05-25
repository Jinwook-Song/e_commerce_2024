import 'dart:async';

import 'package:e_commerce/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// TODO: Login Bloc
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
      () => context.goNamed(Routes.home.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 하드코딩된 값 변경
      backgroundColor: const Color(0xFF5F0080),
      body: Center(
        child: SvgPicture.asset(
          'assets/svg/main_logo.svg',
        ),
      ),
    );
  }
}
