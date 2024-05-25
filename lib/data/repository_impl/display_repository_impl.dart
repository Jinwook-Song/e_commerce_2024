import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/mapper/common.mapper.dart';
import 'package:e_commerce/data/mapper/display.mapper.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';

class DisplayRepositoryImpl implements DisplayRepository {
  DisplayRepositoryImpl(this._displayApi);

  final DisplayApi _displayApi;

  @override
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({
    required MallType mallType,
  }) async {
    final response = await _displayApi.getMenusByMallType(mallType.name);

    return response.toModel(
      response.data?.map((menuDto) => menuDto.toModel()).toList() ?? [],
    );
  }
}
