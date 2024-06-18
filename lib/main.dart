import 'package:e_commerce/core/theme/theme_data.dart';
import 'package:e_commerce/data/entity/cart/cart.entity.dart';
import 'package:e_commerce/data/entity/product_info/product_info.entity.dart';
import 'package:e_commerce/dependency_injection.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/presentation/routes/router.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/screens/main/bloc/user_bloc/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<void> main() async {
  configureDependencies();

  // Hive 초기화
  await Hive.initFlutter();
  Hive.registerAdapter(ProductInfoEntityAdapter());
  Hive.registerAdapter(CartEntityAdapter());

  KakaoSdk.init(
    nativeAppKey: '4bd4550f42babcb559c62f68a12f7647',
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return getIt<CartBloc>()..add(const CartInitialized());
          },
        ),
        BlocProvider(
          lazy: false, // 사용되기 전에 생성이 되도록
          create: (context) {
            return getIt<CartListBloc>()..add(const CartListInitialized());
          },
        ),
        BlocProvider(
          create: (context) {
            return getIt<UserBloc>()..add(const UserLoginWithToken());
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: CustomThemeData.themeData,
      ),
    );
  }
}
