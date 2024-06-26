import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/rest_client/rest_client.dart';
import 'package:e_commerce/data/data_source/local/display.dao.dart';
import 'package:e_commerce/data/data_source/mock/display/display.mock_api.dart';
import 'package:e_commerce/data/data_source/remote/display/display.api.dart';
import 'package:e_commerce/data/data_source/remote/user/user.api.dart';
import 'package:e_commerce/main.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSourceModule {
  final Dio _dio = RestClient().getDio;

  @singleton
  DisplayApi get displayApi {
    String baseUrl =
        Platform.isAndroid ? 'http://10.0.2.2:8080 ' : 'http://localhost:8080';
    _dio.options.baseUrl = baseUrl;

    return TargetApiValue().isRemoteApi ? DisplayApi(_dio) : DisplayMockApi();
  }

  @singleton
  UserApi get userApi => UserApi(_dio);
  @singleton
  DisplayDao get displayDao => DisplayDao();
}
