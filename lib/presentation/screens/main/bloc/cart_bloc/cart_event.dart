part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartInitialized extends CartEvent {
  const CartInitialized();
}

class CartClosed extends CartEvent {
  const CartClosed();
}

class CartOpened extends CartEvent {
  final ProductInfo productInfo;
  final int quantity;

  const CartOpened(this.productInfo, {required this.quantity});
}
