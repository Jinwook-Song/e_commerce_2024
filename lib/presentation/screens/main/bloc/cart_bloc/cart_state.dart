part of 'cart_bloc.dart';

enum CartStatus { open, close, error }

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(CartStatus.close) CartStatus status,
    @Default(ErrorResponse()) ErrorResponse error,
    @Default(
      ProductInfo(
        productId: '',
        title: '',
        subtitle: '',
        imageUrl: '',
        price: -1,
        originalPrice: -1,
        discountRate: -1,
        reviewCount: -1,
      ),
    )
    ProductInfo productInfo,
    @Default(1) int quantity,
    @Default(0) int totalPrice,
  }) = _CartState;
}

extension CartStatusX on CartStatus {
  bool get isClose => this == CartStatus.close;
  bool get isOpen => this == CartStatus.open;
  bool get isError => this == CartStatus.error;
}
