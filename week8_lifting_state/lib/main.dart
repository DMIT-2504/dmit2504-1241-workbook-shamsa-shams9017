import 'package:flutter/material.dart';
import 'package:week8_lifting_state/pages/cart_page.dart';
import 'package:week8_lifting_state/pages/home_page.dart';
import 'package:week8_lifting_state/pages/items_page.dart';

// If the state is managed locally (in a lower-level widget) 
// and you want other widgets to access or modify that state, 
// you will have to pass it down through constructors. 
// Each widget that needs to access or modify the state will need the state
// But we don't have to do that for this app because we are lifting state
void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // the state lives here in main
  List<Map<String, dynamic>> cart = [];

  double get totalCartValue {
    //fold function allows us to combine given variables
    return cart.fold(0, (double sum, Map<String, dynamic> item) {
      double itemPrice = item['price'];
      int itemQuantity = item['quantity'];
      double totalItemValue = itemPrice * itemQuantity;

      return sum + totalItemValue;
  });
}


  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingIndex = cart.indexWhere((element) => element['id'] == product['id']);

      if (existingIndex >= 0) {
        cart[existingIndex]['quantity'] += 1;
      } else {
        cart.add({...product, 'quantity': 1});
      }
    });
  }

  void removeFromCart(int productId) {
    setState(() {
      cart.removeWhere((item) => item['id'] == productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(totalCartValue: totalCartValue),
      routes: {
        '/items': (context) => ItemsPage(cart: cart,addToCart: addToCart),
        '/cart': (context) => CartPage(cart: cart, removeFromCart: removeFromCart),
      },
    );
  }
}
