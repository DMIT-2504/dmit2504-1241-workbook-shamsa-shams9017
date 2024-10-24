import 'package:flutter/material.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

class CartPage extends StatefulWidget {
  final CartStateHandler cartStateHandler; 

  const CartPage({super.key, required this.cartStateHandler});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: ListenableBuilder(
        listenable: widget.cartStateHandler,
        builder: (context, _) {
          return widget.cartStateHandler.cart.isEmpty
              ? const Center(child: Text('Cart is empty'))
              : ListView.builder(
                  itemCount: widget.cartStateHandler.cart.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartStateHandler.cart[index];
                    return ListTile(
                      leading: Image.network(item['image'], width: 50),
                      title: Text(item['title']),
                      subtitle: Text('Quantity: ${item['quantity']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          widget.cartStateHandler.removeFromCart(item['id']);
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
