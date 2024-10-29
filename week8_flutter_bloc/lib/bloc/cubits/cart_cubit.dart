import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cart: []));

  void addItem(Map<String, dynamic> item) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cart); // create a new list by copying from state.cart
    final itemWithQuantity = {...item, 'quantity': 1};
    updatedCart.add(itemWithQuantity);
    emit(state.copyWith(cart: updatedCart));// creates a new state based on the current state but with the cart property updated to updatedCart
  }

  void removeItem(int itemId) {
    final updatedCart = state.cart.where((item) => item['id'] != itemId).toList();
    emit(state.copyWith(cart: updatedCart));
  }

  void updateItemQuantity(int itemId) {
    final updatedCart = state.cart.map((item) {
      if (item['id'] == itemId) {
        final currentQuantity = item['quantity'] ?? 1;
        return {...item, 'quantity': currentQuantity + 1};
      }
      return item;
    }).toList();
    emit(state.copyWith(cart: updatedCart));
  }
}
