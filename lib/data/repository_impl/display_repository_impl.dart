import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/dto/display/display.dto.dart';
import 'package:e_commerce/data/mapper/common.mapper.dart';
import 'package:e_commerce/data/mapper/display.mapper.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/model/display/view_module/viee_module.model.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';

class DisplayRepositoryImpl implements DisplayRepository {
  DisplayRepositoryImpl(this._displayApi);

  final DisplayApi _displayApi;

  Future<ResponseWrapper<List<Model>>> _getData<Model, Dto>({
    required Future<ResponseWrapper<List<Dto>>> Function() apiCall,
    required Model Function(Dto) fromDto,
  }) async {
    final response = await apiCall();
    return response.toModel(
      response.data?.map(fromDto).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({
    required MallType mallType,
  }) async {
    return _getData<Menu, MenuDto>(
      apiCall: () => _displayApi.getMenusByMallType(mallType.name),
      fromDto: (dto) => dto.toModel(),
    );
  }

  @override
  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
  }) async {
    return _getData<ViewModule, ViewModuleDto>(
      apiCall: () => _displayApi.getViewModulesByTabId(tabId),
      fromDto: (dto) => dto.toModel(),
    );
  }
}
