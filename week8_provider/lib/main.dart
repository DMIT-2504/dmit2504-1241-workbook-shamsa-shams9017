import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_changenotifier_cart_app/pages/cart_page.dart';
import 'package:week8_changenotifier_cart_app/pages/home_page.dart';
import 'package:week8_changenotifier_cart_app/pages/items_page.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

// The Provider package simplifies the usage of InheritedWidget 
// by wrapping it with a more convenient API. 
// You no longer need to manually create an InheritedWidget and handle updateShouldNotify logic
void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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

  // wrap your MaterialApp with ChangeNotifierProvider
  // the create attribute is used to create a new instance of the class to be provided to child widgets.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartStateHandler(),
        child: MaterialApp(
          home: HomePage(),
          routes: {
            '/items': (context) => ItemsPage(),
            '/cart': (context) => CartPage(),
          },
        ));
  }
}
