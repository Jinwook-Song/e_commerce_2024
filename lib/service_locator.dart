import 'package:e_commerce/data/data_source/mock/display/display.mock_api.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/repository_impl/display.repository_impl.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/presentation/screens/home/bloc/menu_bloc/menu_bloc.dart';
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart';
import 'package:get_it/get_it.dart';

// ! Injectable Package로 대체됨
// final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
  _presentation();
}

void _data() {
  // locator.registerSingleton<DisplayApi>(DisplayMockApi());
}

void _domain() {
  // repository
  // locator.registerSingleton<DisplayRepository>(
  //   DisplayRepositoryImpl(locator<DisplayApi>()),
  // );

  // usecase
  // locator.registerSingleton<DisplayUsecase>(
  //   DisplayUsecase(locator<DisplayRepository>()),
  // );
}

void _presentation() {
  // locator.registerFactory(() => MenuBloc(locator<DisplayUsecase>()));

  // locator.registerFactory(() => ViewModuleBloc(locator<DisplayUsecase>()));
}
