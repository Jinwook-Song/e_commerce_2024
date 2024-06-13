import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartInitialized>(_onCartInitialized);
    on<CartOpened>(_onCartOpened);
    on<CartClosed>(_onCartClosed);
    on<CartQuantityIncreased>(_onCartQuantityIncreased);
    on<CartQuantityDecreased>(_onCartQuantityDecreased);
  }

  void _onCartInitialized(CartInitialized event, Emitter<CartState> emit) {}
  void _onCartOpened(CartOpened event, Emitter<CartState> emit) {
    if (state.status.isOpen) return;
    final productInfo = event.productInfo;
    final quantity = event.quantity;
    final totalPrice = productInfo.price * quantity;

    try {
      emit(
        state.copyWith(
          status: CartStatus.open,
          productInfo: productInfo,
          quantity: quantity,
          totalPrice: totalPrice,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  void _onCartClosed(CartClosed event, Emitter<CartState> emit) {
    if (state.status.isClose) return;
    try {
      emit(
        state.copyWith(
          status: CartStatus.close,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  void _onCartQuantityIncreased(
    CartQuantityIncreased event,
    Emitter<CartState> emit,
  ) {
    try {
      final quantity = state.quantity + 1;
      if (quantity > 999) return;
      final totalPrice = state.productInfo.price * quantity;
      emit(state.copyWith(quantity: quantity, totalPrice: totalPrice));
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onCartQuantityDecreased(
    CartQuantityDecreased event,
    Emitter<CartState> emit,
  ) async {
    try {
      final quantity = state.quantity - 1;
      if (quantity <= 0) return;
      final totalPrice = state.productInfo.price * quantity;
      emit(state.copyWith(quantity: quantity, totalPrice: totalPrice));
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: CartStatus.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  @override
  void onChange(Change<CartState> change) {
    super.onChange(change);
    logging([change.currentState.status, change.nextState.status]);
  }
}
