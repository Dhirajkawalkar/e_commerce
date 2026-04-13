import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartItemModel? _lastRemovedItem;
  int? _lastRemovedIndex;

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
    on<UndoRemove>(_onUndoRemove);
  }

  void _onUndoRemove(UndoRemove event, Emitter<CartState> emit) {
    if (_lastRemovedItem == null || _lastRemovedIndex == null) return;
    
    final List<CartItemModel> currentItems = List.from(state.items);
    
    // Duplicate Restore Protect: Check ID against active cart
    if (!currentItems.any((item) => item.product.id == _lastRemovedItem!.product.id)) {
      // Smart Position Recovery: Securely inserts safely within correct index bounds
      final insertIndex = _lastRemovedIndex! <= currentItems.length ? _lastRemovedIndex! : currentItems.length;
      currentItems.insert(insertIndex, _lastRemovedItem!);
    }
    
    // Scour memory
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
    emit(CartUpdated(items: currentItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
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
        // Caching location coordinates and object state silently pre-deletion
        _lastRemovedItem = existingItem;
        _lastRemovedIndex = existingIndex;
        currentItems.removeAt(existingIndex);
      }
    }
    emit(CartUpdated(items: currentItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    final existingIndex = currentItems.indexWhere((item) => item.product.id == event.product.id);
    
    if (existingIndex != -1) {
      // Caching location coordinates and object state silently pre-deletion
      _lastRemovedItem = currentItems[existingIndex];
      _lastRemovedIndex = existingIndex;
      currentItems.removeAt(existingIndex);
    }
    emit(CartUpdated(items: currentItems));
  }
}
