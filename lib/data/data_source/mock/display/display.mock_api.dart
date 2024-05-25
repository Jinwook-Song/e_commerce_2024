import 'dart:convert';

import 'package:e_commerce/data/data_source/mock/display/display_mock_data.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';

class DisplayMockApi implements DisplayApi {
  @override
  Future<List<MenuDto>> getMenusByMallType(String mallType) {
    return Future(
      () => _menuParser(
        mallType == MallType.market.name
            ? DisplayMockData.menusByMarket
            : DisplayMockData.menusByMarket,
      ),
    );
  }

  List<MenuDto> _menuParser(String source) {
    List<dynamic> json = jsonDecode(source);
    return json.map((menuJson) => MenuDto.fromJson(menuJson)).toList();
  }
}
