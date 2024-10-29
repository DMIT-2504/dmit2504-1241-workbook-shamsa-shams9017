import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/store_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) // sets the initial state of ProductBloc to a new instance of ProductState.
  {
    on<LoadProducts>((event, emit) async { // event is the instance of LoadProducts event that was dispatched.
      final products = await StoreService().fetchProducts();
      emit(ProductState(products: products)); // create and send a new state to the Bloc's stream, which notifies any listeners
    });
  }
}
