import 'package:e_commerce/data/data_source/mock/display/display.mock_api.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/repository_impl/display_repository_impl.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
}

void _data() {
  locator.registerSingleton<DisplayApi>(DisplayMockApi());
}

void _domain() {
  // repository
  locator.registerSingleton<DisplayRepository>(
    DisplayRepositoryImpl(locator<DisplayApi>()),
  );

  // usecase
  locator.registerSingleton<DisplayUsecase>(
    DisplayUsecase(locator<DisplayRepository>()),
  );
}
