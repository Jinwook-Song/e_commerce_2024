import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/domain/model/display/cart/cart.model.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/domain/repository/repository.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({
    required MallType mallType,
  });

  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
    required int page,
    required bool isRefresh,
  });

  /// 장바구니 리스트 불러오기
  Future<ResponseWrapper<List<Cart>>> getCartList();

  /// 장바구니 상품 추가하기
  Future<ResponseWrapper<List<Cart>>> addCart({
    required Cart cart,
  });

  /// ProductId로 장바구니 삭제하기
  Future<ResponseWrapper<List<Cart>>> deleteCartByProductId({
    required List<String> productIds,
  });

  /// 장바구니 비우기
  Future<ResponseWrapper<List<Cart>>> clearCartList();

  /// 장바구니 수량 변경하기
  Future<ResponseWrapper<List<Cart>>> changeCartQuantityByProductId({
    required String productId,
    required int quantity,
  });
}
