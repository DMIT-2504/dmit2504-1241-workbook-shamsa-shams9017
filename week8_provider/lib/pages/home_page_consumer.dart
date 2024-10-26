import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    // Since we are using the Consumer class, cartStateHandler here is no longer needed. you do not need to explicitly add 
    // this line below to provide the state
    // TODO: remove this line
    final cartStateHandler = Provider.of<CartStateHandler>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // wrap the widgets that you want to rebuild
            // only this part will be rebuilt now
            // with the Listenable builder, Flutter rebuilds the whole widget tree
             Consumer<CartStateHandler>(
              builder: (context, cartStateHandler, child) {
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
