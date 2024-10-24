import 'package:flutter/material.dart';
import 'package:week8_lifting_state/services/store_service.dart';

class ItemsPage extends StatefulWidget {
  final Function(Map<String, dynamic>) addToCart;
  final List<Map<String, dynamic>> cart; // Cart passed as prop

  const ItemsPage({super.key, required this.addToCart, required this.cart});

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
    return widget.cart.any((item) => item['id'] == product['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            // When you use Navigator.pushNamed(context, '/cart') 
            // to navigate to the Cart Page, even though you are not passing the cart through the constructor, 
            // the Cart Page still has access to the cart 
            // because the cart is managed and tracked in the MainAppState, 
            // and MainApp is providing that state to both pages.
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
                    final inCart = isInCart(product);

                    return Card(
                      child: ListTile(
                        leading: Image.network(product['image'], width: 50),
                        title: Text(product['title']),
                        subtitle: Text('\$${product['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (inCart) const Icon(Icons.check, color: Colors.green), // Tick mark if in cart
                            IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                widget.addToCart(product); // Add item to cart
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
