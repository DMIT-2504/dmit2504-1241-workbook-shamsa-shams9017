import 'package:flutter/material.dart';
import 'package:week8_changenotifier_cart_app/services/store_service.dart';
import 'package:week8_changenotifier_cart_app/state/cart_state.dart';


class ItemsPage extends StatefulWidget {
  final CartStateHandler cartStateHandler; 

  const ItemsPage({super.key, required this.cartStateHandler});

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

  bool isInCart(Map<String, dynamic> product) {
    return widget.cartStateHandler.cart.any((item) => item['id'] == product['id']);
  }

  @override
  Widget build(BuildContext context) {
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
              : ListenableBuilder(
                  listenable: widget.cartStateHandler, 
                  builder: (context, _) {
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final inCart = isInCart(product);

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
                                    widget.cartStateHandler.addToCart(product); 
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
