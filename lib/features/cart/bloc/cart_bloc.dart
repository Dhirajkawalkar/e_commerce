import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
    on<RestoreCartItem>(_onRestoreCartItem);
  }

  void _onRestoreCartItem(RestoreCartItem event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    // Enforces block to prevent double-click async spamming duplicates natively
    if (!currentItems.any((item) => item.product.id == event.cartItem.product.id)) {
      currentItems.add(event.cartItem);
    }
    emit(CartUpdated(items: currentItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartUpdated(items: []));
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    _handleQuantityIncrease(event.product, emit);
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    _handleQuantityIncrease(event.product, emit);
  }

  void _handleQuantityIncrease(product, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    final existingIndex = currentItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      currentItems.add(CartItemModel(product: product));
    }
    emit(CartUpdated(items: currentItems));
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    final existingIndex = currentItems.indexWhere((item) => item.product.id == event.product.id);

    if (existingIndex != -1) {
      final existingItem = currentItems[existingIndex];
      if (existingItem.quantity > 1) {
        currentItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity - 1);
      } else {
        currentItems.removeAt(existingIndex); // Item quantity is 0 - dynamically removed!
      }
    }
    emit(CartUpdated(items: currentItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    currentItems.removeWhere((item) => item.product.id == event.product.id);
    emit(CartUpdated(items: currentItems));
  }
}
