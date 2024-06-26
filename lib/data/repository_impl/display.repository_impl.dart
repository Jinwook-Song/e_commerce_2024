import 'package:e_commerce/data/data_source/local/display.dao.dart';
import 'package:e_commerce/data/data_source/remote/display/display.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/dto/display/display.dto.dart';
import 'package:e_commerce/data/entity/cart/cart.entity.dart';
import 'package:e_commerce/data/entity/view_module_list/view_module_list.entity.dart';
import 'package:e_commerce/data/mapper/common.mapper.dart';
import 'package:e_commerce/data/mapper/display.mapper.dart';
import 'package:e_commerce/domain/model/display/cart/cart.model.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/model/display/view_module/viee_module.model.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:injectable/injectable.dart';

// 추상화 클래스와 구현 클래스 바인딩
@Singleton(as: DisplayRepository)
class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;
  final DisplayDao _displayDao;

  DisplayRepositoryImpl(this._displayApi, this._displayDao);

  Future<ResponseWrapper<List<Model>>> _getData<Model, Data>({
    required Future<ResponseWrapper<List<Data>>> Function() apiCall,
    required Model Function(Data) fromData,
  }) async {
    final response = await apiCall();
    return response.toModel(
      response.data?.map(fromData).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({
    required MallType mallType,
  }) async {
    return _getData<Menu, MenuDto>(
      apiCall: () => _displayApi.getMenusByMallType(mallType.name),
      fromData: (dto) => dto.toModel(),
    );
  }

  @override
  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
    required int page,
    required bool isRefresh,
  }) async {
    final cacheKey = '$tabId';

    if (isRefresh) {
      await _displayDao.clearViewModules(cacheKey);
    }

    final cachedData = await _displayDao.getViewModules(cacheKey, page);

    if (cachedData.isNotEmpty) {
      return ResponseWrapper(status: 'SUCCESS', data: cachedData);
    }

    final response = await _displayApi.getViewModulesByTabId(tabId, page);
    final viewModules =
        response.data?.map((dto) => dto.toModel()).toList() ?? [];
    await _displayDao.insertViewModules(
      cacheKey,
      page,
      ViewModuleListEntity(
        viewModules: viewModules.map((model) => model.toEntity()).toList(),
      ),
    );

    return response.toModel<List<ViewModule>>(viewModules);
  }

  @override
  Future<ResponseWrapper<List<Cart>>> getCartList() async {
    return _getData<Cart, CartEntity>(
      apiCall: () => _displayDao.getCartList(),
      fromData: (entity) => entity.toModel(),
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> addCart({required Cart cart}) {
    return _getData<Cart, CartEntity>(
      apiCall: () => _displayDao.insertCart(cart.toEntity()),
      fromData: (entity) => entity.toModel(),
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> deleteCartByProductId({
    required List<String> productIds,
  }) {
    return _getData<Cart, CartEntity>(
      apiCall: () => _displayDao.deleteCart(productIds),
      fromData: (entity) => entity.toModel(),
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> clearCartList() {
    return _getData<Cart, CartEntity>(
      apiCall: () => _displayDao.clearCarts(),
      fromData: (entity) => entity.toModel(),
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> changeCartQuantityByProductId({
    required String productId,
    required int quantity,
  }) {
    return _getData<Cart, CartEntity>(
      apiCall: () => _displayDao.changeQtyCart(
        productId: productId,
        quantity: quantity,
      ),
      fromData: (entity) => entity.toModel(),
    );
  }
}
