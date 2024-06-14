part of 'cart_list_bloc.dart';

abstract class CartListEvent {
  const CartListEvent();
}

class CartListInitialized extends CartListEvent {
  const CartListInitialized();
}

class CartListGetList extends CartListEvent {
  const CartListGetList();
}

class CartListAdded extends CartListEvent {
  final int quantity;
  final ProductInfo productInfo;

  const CartListAdded({required this.quantity, required this.productInfo});
}

class CartListSelectedAll extends CartListEvent {
  const CartListSelectedAll();
}

class CartListSelected extends CartListEvent {
  final Cart cart;

  const CartListSelected({required this.cart});
}

class CartListDeleted extends CartListEvent {
  final List<String> productIds;

  const CartListDeleted({required this.productIds});
}

class CartListCleared extends CartListEvent {
  const CartListCleared();
}

class CartListQtyDecreased extends CartListEvent {
  final Cart cart;

  const CartListQtyDecreased({required this.cart});
}

class CartListQtyIncreased extends CartListEvent {
  final Cart cart;

  const CartListQtyIncreased({required this.cart});
}
