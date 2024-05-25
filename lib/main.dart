import 'package:e_commerce/core/theme/theme_data.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/domain/usecase/display/menu/get_menus.usecase.dart';
import 'package:e_commerce/presentation/routes/router.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:e_commerce/service_locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  setLocator();

  final menus = await locator<DisplayUsecase>().execute(
    usecase: GetMenusUsecase(MallType.market),
  );

  logging(menus);

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
