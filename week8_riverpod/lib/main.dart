import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8_changenotifier_cart_app/pages/cart_page.dart';
import 'package:week8_changenotifier_cart_app/pages/home_page.dart';
import 'package:week8_changenotifier_cart_app/pages/items_page.dart';

// wrap your app with root container called ProviderScope to use RiverPod
void main() {
  runApp(const ProviderScope(child: MainApp())); // wrap your app with root container called ProviderScope to use RiverPod
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        '/items': (context) => const ItemsPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
