import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

class CartPage extends StatefulWidget {

  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartStateHandler = Provider.of<CartStateHandler>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: ListenableBuilder(
        listenable: cartStateHandler,
        builder: (context, _) {
          return cartStateHandler.cart.isEmpty
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
                );
        },
      ),
    );
  }
}
