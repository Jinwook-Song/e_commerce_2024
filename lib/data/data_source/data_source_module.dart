import 'package:e_commerce/data/data_source/mock/display/display.mock_api.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSourceModule {
  @singleton
  DisplayApi get displayApi => DisplayMockApi();
}
