import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/model/display/cart/cart.model.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:e_commerce/domain/usecase/display/cart/cart.usecase.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cart_list_bloc.freezed.dart';
part 'cart_list_event.dart';
part 'cart_list_state.dart';

@injectable
class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final DisplayUsecase _displayUsecase;

  CartListBloc(this._displayUsecase) : super(CartListState()) {
    on<CartListInitialized>(_onCartListInitialized);
    on<CartListAdded>(_onCartListAdded);
    on<CartListDeleted>(_onCartDeleted);
    on<CartListSelected>(_onCartSelected);
    on<CartListSelectedAll>(_onCartSelectedAll);
    on<CartListQtyIncreased>(_onCartQtyIncreased);
    on<CartListQtyDecreased>(_onCartQtyDecreased);
  }

  Future<void> _onCartListInitialized(_, Emitter<CartListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await _displayUsecase.execute<Result<List<Cart>?>>(
        usecase: GetCartListUsecase(),
      );
      response.when(
        success: (cartList) {
          final selectedProducts =
              cartList!.map((e) => e.product.productId).toList();

          final totalPrice = _calTotalPrice(selectedProducts, cartList);
          emit(
            state.copyWith(
              status: Status.success,
              cartList: cartList,
              totalPrice: totalPrice,
              selectedProduct: selectedProducts,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onCartListAdded(
    CartListAdded event,
    Emitter<CartListState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final cart = Cart(quantity: event.quantity, product: event.productInfo);
    try {
      final response = await _displayUsecase.execute<Result<List<Cart>?>>(
        usecase: AddCartListUsecase(cart),
      );

      response.when(
        success: (cartList) {
          final selectedProducts = [...state.selectedProduct];
          final productId = event.productInfo.productId;
          if (selectedProducts.indexWhere((e) => e == productId) == -1) {
            selectedProducts.add(productId);
          }
          final totalPrice = _calTotalPrice(selectedProducts, cartList!);
          emit(
            state.copyWith(
              status: Status.success,
              cartList: cartList,
              selectedProduct: selectedProducts,
              totalPrice: totalPrice,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      logging(error, logType: LogType.error);

      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onCartDeleted(
    CartListDeleted event,
    Emitter<CartListState> emit,
  ) async {
    try {
      final response = await _displayUsecase.execute<Result<List<Cart>?>>(
        usecase: DeleteCartListUsecase(event.productIds),
      );

      response.when(
        success: (data) {
          final List<Cart> cartList = [...data!];
          final selectedProducts =
              cartList.map((e) => e.product.productId).toList();
          final totalPrice = _calTotalPrice(selectedProducts, cartList);
          emit(
            state.copyWith(
              status: Status.success,
              cartList: cartList,
              selectedProduct: selectedProducts,
              totalPrice: totalPrice,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  void _onCartSelected(
    CartListSelected event,
    Emitter<CartListState> emit,
  ) {
    try {
      final String productId = event.cart.product.productId;
      final selectedProducts = [...state.selectedProduct];
      final int selectedIdx =
          state.selectedProduct.indexWhere((element) => element == productId);
      if (selectedIdx == -1) {
        selectedProducts.add(productId);
      } else {
        selectedProducts.removeAt(selectedIdx);
      }

      final totalPrice = _calTotalPrice(selectedProducts, state.cartList);

      emit(
        state.copyWith(
          selectedProduct: selectedProducts,
          totalPrice: totalPrice,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  void _onCartSelectedAll(
    CartListSelectedAll event,
    Emitter<CartListState> emit,
  ) {
    try {
      // 이미 전체 선택이 되어있는 경우 -> 모두 지움

      if (state.selectedProduct.length == state.cartList.length) {
        final totalPrice = _calTotalPrice([], state.cartList);
        emit(state.copyWith(selectedProduct: [], totalPrice: totalPrice));

        return;
      }

      final selectedProducts =
          state.cartList.map((e) => e.product.productId).toList();
      final totalPrice = _calTotalPrice(selectedProducts, state.cartList);

      emit(
        state.copyWith(
          selectedProduct: selectedProducts,
          totalPrice: totalPrice,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onCartQtyIncreased(
    CartListQtyIncreased event,
    Emitter<CartListState> emit,
  ) async {
    try {
      final productId = event.cart.product.productId;
      final qty = event.cart.quantity + 1;
      final response = await _displayUsecase.execute<Result<List<Cart>?>>(
        usecase: ChangeCartQtyUsecase(productId, qty),
      );

      response.when(
        success: (data) {
          final List<Cart> cartList = [...data!];

          final totalPrice = _calTotalPrice(state.selectedProduct, cartList);
          emit(
            state.copyWith(
              status: Status.success,
              cartList: cartList,
              totalPrice: totalPrice,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onCartQtyDecreased(
    CartListQtyDecreased event,
    Emitter<CartListState> emit,
  ) async {
    try {
      final productId = event.cart.product.productId;
      final qty = event.cart.quantity - 1;
      if (qty < 1) return;
      final response = await _displayUsecase.execute<Result<List<Cart>?>>(
        usecase: ChangeCartQtyUsecase(productId, qty),
      );
      response.when(
        success: (data) {
          final List<Cart> cartList = [...data!];

          final totalPrice = _calTotalPrice(state.selectedProduct, cartList);
          emit(
            state.copyWith(
              status: Status.success,
              cartList: cartList,
              totalPrice: totalPrice,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      logging(error, logType: LogType.error);

      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  int _calTotalPrice(List<String> ids, List<Cart> carts) {
    int price = 0;
    for (final id in ids) {
      for (final cart in carts) {
        if (cart.product.productId == id) {
          price += cart.quantity * cart.product.price;
        }
      }
    }

    return price;
  }
}
