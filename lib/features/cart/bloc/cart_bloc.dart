import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    final existingIndex = currentItems.indexWhere((item) => item.product.id == event.product.id);

    if (existingIndex != -1) {
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      currentItems.add(CartItemModel(product: event.product));
    }

    emit(CartUpdated(items: currentItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    currentItems.removeWhere((item) => item.product.id == event.product.id);
    emit(CartUpdated(items: currentItems));
  }
}
