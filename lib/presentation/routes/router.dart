import 'package:e_commerce/presentation/routes/routes.dart';
import 'package:e_commerce/presentation/screens/home/home_screen.dart';
import 'package:e_commerce/presentation/screens/splash/splash_screen.dart';
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
      path: Routes.home.path,
      name: Routes.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
