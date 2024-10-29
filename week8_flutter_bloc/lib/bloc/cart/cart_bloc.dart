import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cart: [])) {
    on<AddItemToCart>((event, emit) {
      final updatedCart = List<Map<String, dynamic>>.from(state.cart);
      final itemWithQuantity = {...event.item, 'quantity': 1};
      updatedCart.add(itemWithQuantity);
      emit(state.copyWith(cart: updatedCart));
    });

    on<RemoveItemFromCart>((event, emit) {
      final updatedCart =
          state.cart.where((item) => item['id'] != event.itemId).toList();
      emit(state.copyWith(cart: updatedCart));
    });

    on<UpdateItemQuantity>((event, emit) {
      final updatedCart = state.cart.map((item) {
        if (item['id'] == event.itemId) {
          final currentQuantity = item['quantity'] ?? 1;
          return {...item, 'quantity': currentQuantity + 1};
        }
        return item;
      }).toList();
      emit(state.copyWith(cart: updatedCart));
    });
  }
}
