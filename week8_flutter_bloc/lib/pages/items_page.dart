import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_state.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productState) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (productState.products.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: productState.products.length,
                itemBuilder: (context, index) {
                  final product = productState.products[index];
                  final inCart =
                      cartState.cart.any((item) => item['id'] == product['id']);

                  return Card(
                    child: ListTile(
                      leading: Image.network(product['image'], width: 50),
                      title: Text(product['title']),
                      subtitle: Text('\$${product['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (inCart)
                            const Icon(Icons.check, color: Colors.green),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              final itemId = product['id'];
                              final inCart = cartState.cart
                                  .any((item) => item['id'] == itemId);

                              if (inCart) {
                                final currentQuantity = cartState.cart
                                    .firstWhere((item) =>
                                        item['id'] == itemId)['quantity'];
                                BlocProvider.of<CartBloc>(context).add(
                                    UpdateItemQuantity(
                                        itemId, currentQuantity + 1));
                              } else {
                                BlocProvider.of<CartBloc>(context)
                                    .add(AddItemToCart(product));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
