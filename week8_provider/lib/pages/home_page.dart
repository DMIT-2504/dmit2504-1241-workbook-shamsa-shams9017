import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // access the state using the following
    // notice the similarity with InheritedNotifier
    // but this is done inside the build method
    final cartStateHandler = Provider.of<CartStateHandler>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use ListenableBuilder to listen to changes in the CartNotifier
            ListenableBuilder(
              listenable: cartStateHandler,
              builder: (context, _) {
                return Text('Total Cart Value: \$${cartStateHandler.totalCartValue.toStringAsFixed(2)}');
              },
            ),
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
