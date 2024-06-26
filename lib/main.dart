import 'dart:ui';

import 'package:e_commerce/core/theme/theme_data.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/data/entity/cart/cart.entity.dart';
import 'package:e_commerce/data/entity/product_info/product_info.entity.dart';
import 'package:e_commerce/data/entity/target_api.dart';
import 'package:e_commerce/data/entity/view_module/view_module.entity.dart';
import 'package:e_commerce/data/entity/view_module_list/view_module_list.entity.dart';
import 'package:e_commerce/dependency_injection.dart';
import 'package:e_commerce/presentation/routes/router.dart';
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/screens/main/bloc/user_bloc/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<void> main(name, options) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive 초기화
  await Hive.initFlutter();
  Hive.registerAdapter(ProductInfoEntityAdapter());
  Hive.registerAdapter(CartEntityAdapter());
  Hive.registerAdapter(ViewModuleEntityAdapter());
  Hive.registerAdapter(ViewModuleListEntityAdapter());
  Hive.registerAdapter(TargetApiAdapter());

  await TargetApiValue().setTargetApi();
  // Api를 set한 이후에 실행되도록
  configureDependencies();

  KakaoSdk.init(
    nativeAppKey: '4bd4550f42babcb559c62f68a12f7647',
  );

  await Firebase.initializeApp(
    name: name,
    options: options,
  );

  if (dotenv.env['FLAVOR'] == 'prod') {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

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
        debugShowCheckedModeBanner: dotenv.env['FLAVOR'] == 'dev',
        routerConfig: router,
        theme: CustomThemeData.themeData,
      ),
    );
  }
}

class TargetApiValue {
  TargetApi? targetApi = TargetApi.REMOTE;
  bool get isRemoteApi => targetApi == TargetApi.REMOTE;

  static final TargetApiValue _instance = TargetApiValue._internal();

  TargetApiValue._internal();

  factory TargetApiValue() => _instance;

  Future<void> setTargetApi() async {
    final localStorage = await Hive.openBox<TargetApi>(Constants.targetApiKey);

    targetApi = localStorage.get(
      Constants.targetApiKey,
      defaultValue: TargetApi.REMOTE,
    );
  }
}
