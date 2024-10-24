import 'package:flutter/material.dart';
import 'package:week8_inherited_notifier/state/cart_inherited.dart';
import 'package:week8_inherited_notifier/state/cart_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartStateHandler cartStateHandler = CartNotifier.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Cart Value: \$${cartStateHandler.totalCartValue.toStringAsFixed(2)}'),
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
