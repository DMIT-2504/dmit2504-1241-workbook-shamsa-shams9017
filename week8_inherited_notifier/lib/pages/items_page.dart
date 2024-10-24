import 'package:flutter/material.dart';
import 'package:week8_inherited_notifier/services/store_service.dart';
import 'package:week8_inherited_notifier/state/cart_inherited.dart';
import 'package:week8_inherited_notifier/state/cart_state.dart';


class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List products = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final fetchedProducts = await StoreService().fetchProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CartStateHandler cartStateHandler = CartNotifier.of(context);

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text('Error: $errorMessage'))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final inCart = cartStateHandler.cart.any((item) => item['id'] == product['id']);

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
    );
  }
}
