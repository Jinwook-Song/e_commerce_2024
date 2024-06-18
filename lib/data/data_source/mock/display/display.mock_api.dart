import 'dart:convert';

import 'package:e_commerce/data/data_source/mock/display/display_mock_data.dart';
import 'package:e_commerce/data/data_source/remote/display/display.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce/data/dto/display/view_module/view_module.dto.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';

class DisplayMockApi implements DisplayApi {
  List<T> _parser<T>(String source, T Function(Map<String, dynamic>) fromJson) {
    List json = jsonDecode(source);
    return json.map((itemJson) => fromJson(itemJson)).toList();
  }

  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(String mallType) {
    return Future(
      () {
        return ResponseWrapper(
          status: 'SUCCESS',
          code: '0000',
          data: _parser(
            mallType == MallType.market.name
                ? DisplayMockData.menusByMarket
                : DisplayMockData.menusByBeauty,
            (json) => MenuDto.fromJson(json),
          ),
        );
      },
    );
  }

  @override
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModulesByTabId(
    int tabId,
    int page,
  ) {
    if (page == 4) {
      return Future.delayed(
        const Duration(seconds: 2),
        () {
          return const ResponseWrapper(
            status: 'SUCCESS',
            code: '0000',
            data: [],
          );
        },
      );
    }

    final source = DisplayMockData.getViewModules();

    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return ResponseWrapper(
          status: 'SUCCESS',
          code: '0000',
          data: _parser(
            source,
            (json) => ViewModuleDto.fromJson(json),
          ),
        );
      },
    );
  }
}
