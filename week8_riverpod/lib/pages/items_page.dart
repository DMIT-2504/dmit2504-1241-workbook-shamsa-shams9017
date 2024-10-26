import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8_changenotifier_cart_app/services/store_service.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';

// FutureProvider in Riverpod is designed specifically to handle this type of scenario by asynchronously 
// providing a future result and notifying widgets when the data is ready.
// Riverpod in this case is handling a different state than cart state
final productProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return await StoreService().fetchProducts();
});

class ItemsPage extends ConsumerWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(provider) tells Riverpod to access the state and listen for its changes to rebuild UI
    // ref.watch(notifier) tells Riverpod to access the state and but won't rebuild. Its to use different methods on the state.
    final cartStateHandler = ref.watch(cartProvider.notifier);
    final productsList = ref.watch(productProvider); 
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: productsList.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final cartState = ref.watch(cartProvider);
            final inCart = cartState.cart.any((item) => item['id'] == product['id']);

            return Card(
              child: ListTile(
                leading: Image.network(product['image'], width: 50),
                title: Text(product['title']),
                subtitle: Text('\$${product['price']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (inCart) const Icon(Icons.check, color: Colors.green),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        cartStateHandler.addToCart(product);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
