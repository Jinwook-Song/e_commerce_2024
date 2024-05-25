import 'package:e_commerce/core/theme/theme_data.dart';
import 'package:e_commerce/data/data_source/mock/display/display.mock_api.dart';
import 'package:e_commerce/presentation/routes/router.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  final data = await DisplayMockApi().getMenusByMallType(MallType.market);
  print(data);
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
