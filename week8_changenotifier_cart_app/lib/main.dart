import 'package:flutter/material.dart';
import 'package:week8_changenotifier_cart_app/pages/cart_page.dart';
import 'package:week8_changenotifier_cart_app/pages/home_page.dart';
import 'package:week8_changenotifier_cart_app/pages/items_page.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late CartStateHandler cartStateHandler;

  @override
  void initState() {
    super.initState();
    cartStateHandler = CartStateHandler();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(cartStateHandler: cartStateHandler),
      routes: {
        '/items': (context) => ItemsPage(cartStateHandler: cartStateHandler),
        '/cart': (context) => CartPage(cartStateHandler: cartStateHandler),
      },
    );
  }
}
