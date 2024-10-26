import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // WidgetRef is an object provided by Riverpod that gives the widget access 
  // to Riverpod's state management functionalities. 
  // It serves as the bridge between the widget and the providers defined in app
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Cart Value: \$${cartState.totalCartValue.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/items');
              },
              child: const Text('Go to Items Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: const Text('Go to Cart Page'),
            ),
          ],
        ),
      ),
    );
  }
}
