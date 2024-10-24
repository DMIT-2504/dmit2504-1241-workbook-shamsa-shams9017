import 'package:flutter/material.dart';
import 'package:week8_inherited_notifier/state/cart_inherited.dart';
import 'package:week8_inherited_notifier/state/cart_state.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartStateHandler cartStateHandler = CartNotifier.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: cartStateHandler.cart.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: cartStateHandler.cart.length,
              itemBuilder: (context, index) {
                final item = cartStateHandler.cart[index];
                return ListTile(
                  leading: Image.network(item['image'], width: 50),
                  title: Text(item['title']),
                  subtitle: Text('Quantity: ${item['quantity']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cartStateHandler.removeFromCart(item['id']);
                    },
                  ),
                );
              },
            ),
    );
  }
}
