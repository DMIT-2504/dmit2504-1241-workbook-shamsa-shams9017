
class CartState {
  final List<Map<String, dynamic>> cart;

  CartState({this.cart = const []});

  double get totalCartValue {
    return cart.fold(0.0, (double sum, item) {
      final price = (item['price'] ?? 0) as num;       
      final quantity = (item['quantity'] ?? 1) as num; 
      return sum + (price.toDouble() * quantity.toDouble());
    });
  }

  CartState copyWith({List<Map<String, dynamic>>? cart}) {
    return CartState(cart: cart ?? this.cart);
  }
}
