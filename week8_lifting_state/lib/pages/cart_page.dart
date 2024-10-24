import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Function(int) removeFromCart;

  const CartPage({super.key, required this.cart, required this.removeFromCart});

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
      body: widget.cart.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return ListTile(
                  leading: Image.network(item['image'], width: 50),
                  title: Text(item['title']),
                  subtitle: Text('Quantity: ${item['quantity']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        widget.removeFromCart(item['id']); 
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}