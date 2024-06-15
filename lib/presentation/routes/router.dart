import 'package:e_commerce/presentation/routes/routes.dart';
import 'package:e_commerce/presentation/screens/cart_list/cart_list_page.dart';
import 'package:e_commerce/presentation/screens/main/main_screen.dart';
import 'package:e_commerce/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash.path,
  routes: [
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.main.path,
      name: Routes.main.name,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const MainScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: Routes.cartList.path,
      name: Routes.cartList.name,
      builder: (context, state) => const CartListPage(),
    ),
  ],
);
