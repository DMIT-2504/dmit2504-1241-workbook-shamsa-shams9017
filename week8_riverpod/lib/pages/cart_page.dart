import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.watch(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: cartState.cart.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
  children: [
    ListView.builder(
      shrinkWrap: true, // keeps ListView to its content's height
      itemCount: cartState.cart.length,
      itemBuilder: (context, index) {
        final item = cartState.cart[index];
        return ListTile(
          leading: Image.network(item['image'], width: 50),
          title: Text(item['title']),
          subtitle: Text('Quantity: ${item['quantity']}'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_shopping_cart),
            onPressed: () {
              cartNotifier.removeFromCart(item['id']);
            },
          ),
        );
      },
    ),
    Text('Total: ${cartState.totalCartValue}'
    , style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
  ],
)

          
    );
  }
}
