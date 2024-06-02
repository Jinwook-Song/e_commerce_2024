import 'package:e_commerce/core/theme/theme_data.dart';
import 'package:e_commerce/presentation/routes/router.dart';
import 'package:e_commerce/service_locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  setLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
