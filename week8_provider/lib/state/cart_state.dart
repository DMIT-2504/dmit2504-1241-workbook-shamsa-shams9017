import 'package:flutter/material.dart';

//  when a class extends ChangeNotifier, 
//  it means that the state is managed by that class. 
//  The class is responsible for holding and modifying its own state and notifying any listeners 
class CartStateHandler extends ChangeNotifier {
  //the state now lives in this class
  final List<Map<String, dynamic>> _cart = [];

  List<Map<String, dynamic>> get cart {
    return _cart;
  }

  void addToCart(Map<String, dynamic> product) {
    // indexWhere checks each element (which is a Map<String, dynamic>) 
    // in the list to see if the condition inside the callback returns true.
    // The condition is checking whether the 'id' of the current element matches the 'id' of the product.
    // If a match is found, indexWhere will return the index of that element.
    int existingIndex = _cart.indexWhere((Map<String, dynamic> element) {
      return element['id'] == product['id'];
    });
    // existingIndex is used to determine whether a product is already present in the cart.
    // if its in the cart, then it increments quantity 
    if (existingIndex >= 0) {
      _cart[existingIndex]['quantity'] = _cart[existingIndex]['quantity'] + 1;
    } else {
      Map<String, dynamic> newProduct = {
        'id': product['id'],
        'title': product['title'],
        'price': product['price'],
        'image': product['image'],
        'quantity': 1
      };
      _cart.add(newProduct);
    }
    notifyListeners(); 
  }

  void removeFromCart(int productId) {
    _cart.removeWhere((Map<String, dynamic> item) {
      return item['id'] == productId;
    });
    notifyListeners(); 
  }

  double get totalCartValue {
    return _cart.fold(0.0, (double sum, Map<String, dynamic> item) {
      return sum + (item['price'] * item['quantity']);
    });
  }
}
