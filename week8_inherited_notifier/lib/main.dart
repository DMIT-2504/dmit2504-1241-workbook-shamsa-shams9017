import 'package:flutter/material.dart';
import 'package:week8_inherited_notifier/pages/cart_page.dart';
import 'package:week8_inherited_notifier/pages/home_page.dart';
import 'package:week8_inherited_notifier/pages/items_page.dart';
import 'package:week8_inherited_notifier/state/cart_inherited.dart';
import 'package:week8_inherited_notifier/state/cart_state.dart';

// you no longer need to pass the state explicitly through constructors 
// because InheritedNotifier makes the state available globally to all widgets that are its children.

// ChangeNotifier is used to manage and modify the state within the class- CartStatehandler
// InheritedNotifier doesn't directly manage state but instead acts as a wrapper around ChangeNotifier. 
// It helps propagate state changes down the widget tree and 
// ensures that any widget that depends on the state
//  is rebuilt when the state changes.

// If you removed ChangeNotifier, InheritedNotifier wouldn't know when the state changes, 
// because InheritedNotifier relies on ChangeNotifier to trigger those updates using notifyListeners().
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
    return CartNotifier(
      notifier: cartStateHandler,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),  
          '/items': (context) => ItemsPage(),  
          '/cart': (context) => CartPage(),    
        },
      ),
    );
  }
}
