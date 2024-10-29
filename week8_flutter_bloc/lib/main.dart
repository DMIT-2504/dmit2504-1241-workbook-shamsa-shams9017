import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart/cart_bloc.dart';
import 'bloc/cubits/cart_cubit.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/product/product_event.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/items_page.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // use multi provider if you need to epose more than one provider
      providers: [
        BlocProvider(create: (context) => CartBloc()), // provide instance of the bloc class for cart
        BlocProvider(create: (context) => ProductBloc()..add(LoadProducts())),  // provide instance and dispatches event
        BlocProvider(create: (context) => CartCubit())
      ],
      child: MaterialApp(
        home: const HomePage(),
        routes: {
          '/items': (context) => const ItemsPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
