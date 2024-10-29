import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/cubits/cart_cubit.dart';



class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      // By specifying <CartBloc, CartState>, 
      // you're telling BlocBuilder to listen to a CartBloc and 
      // rebuild the UI whenever a new CartState is emitted.
      body: BlocBuilder<CartBloc, CartState>( //subscribes to the CartBloc instance provided higher up in the widget tree
        builder: (context, cartState) {
          return cartState.cart.isEmpty
              ? const Center(child: Text('Cart is empty'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartState.cart.length,
                        itemBuilder: (context, index) {
                          final item = cartState.cart[index];
                          return ListTile(
                            leading: Image.network(item['image'], width: 50),
                            title: Text(item['title']),
                            subtitle: Text('Quantity: ${item['quantity']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // BlocProvider.of<T>(context) retrieves the nearest instance of Bloc of type T 
                                // that was provided higher up in the widget tree. 
                                // This allows the current widget to access the Bloc 
                                // to read its state or dispatch events.
                                BlocProvider.of<CartBloc>(context).add(
                                  RemoveItemFromCart(item['id']),
                                );

                                // BlocProvider.of<CartCubit>(context)
                                //     .removeItem(item['id']);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Total: \$${cartState.totalCartValue.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
