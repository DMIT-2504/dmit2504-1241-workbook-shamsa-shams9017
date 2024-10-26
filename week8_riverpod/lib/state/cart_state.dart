import 'package:flutter_riverpod/flutter_riverpod.dart';
// This is a design pattern where we seperate the state from the business logic (the CRUD operations)
// the state is now in its own class
// any properties and computed values (like totalCartValue) can be defined in this state class. 
// This way, we can extend the state in the future without changing the structure of CartNotifier.
class CartState {
  final List<Map<String, dynamic>> cart;

  CartState(this.cart);

  double get totalCartValue {
    return cart.fold(0.0, (double sum, Map<String, dynamic> item) {
      return sum + (item['price'] * item['quantity']);
    });
  }
}
// CartNotifier becomes the subclass of the StateNotifier 
// this contains all the logic needed to manage CartState
// we define the initial  state in the constructor using super(CartState([]))
// to update state, we replace it with new state, instead of mutating CartState itself.
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState([]));

  void addToCart(Map<String, dynamic> product) {
    int existingIndex = state.cart.indexWhere((item) => item['id'] == product['id']);
    if (existingIndex >= 0) {
      state.cart[existingIndex]['quantity'] += 1;
    } else {
      state.cart.add({
        'id': product['id'],
        'title': product['title'],
        'price': product['price'],
        'image': product['image'],
        'quantity': 1
      });
    }
    // reassigning the state variable to a new instance of CartState, 
    // where the constructor is given a new list created from the existing items in state.cart.
    state = CartState([...state.cart]); // spread operator (...) creates a new list by copying all elements of state.cart
  }

  void removeFromCart(int productId) {
    state.cart.removeWhere((item) => item['id'] == productId);
    state = CartState([...state.cart]);
  }
}
// this exposes both the CartNotifier and the current CartState to the widget tree.
// check CartPage to see how its accessed
final cartProvider = StateNotifierProvider<CartNotifier, CartState>(
  (Ref ref) {
    return CartNotifier();
  },
);

// short hand
//final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier());

// if you decided to have a product state then you would need seperate notifers and providers
// example-
// final productProvider = StateNotifierProvider<ProductNotifier, ProductState>(
//   (ref) => ProductNotifier(),
// );


