/// Business Logic Component (Bloc) for Cart management.
/// 
/// This class handles all operations related to the shopping cart, including
/// adding products, removing items, changing quantities, and undoing deletions.
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product/domain/entities/product.dart';
import '../models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // Variables to cache the last removed item for the 'Undo' functionality.
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

  /// Restores the last removed item to its previous position in the cart.
  void _onUndoRemove(UndoRemove event, Emitter<CartState> emit) {
    if (_lastRemovedItem == null || _lastRemovedIndex == null) return;
    
    final List<CartItemModel> currentItems = List.from(state.items);
    
    // Ensure the item isn't already back in the cart (prevent duplicates).
    if (!currentItems.any((item) => item.product.id == _lastRemovedItem!.product.id)) {
      final insertIndex = _lastRemovedIndex! <= currentItems.length ? _lastRemovedIndex! : currentItems.length;
      currentItems.insert(insertIndex, _lastRemovedItem!);
    }
    
    // Clear the cache after restoration.
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
    emit(CartUpdated(items: currentItems));
  }

  /// Removes all items from the cart.
  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
    emit(const CartUpdated(items: []));
  }

  /// Adds a product to the cart or increases its quantity if already present.
  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    _handleQuantityIncrease(event.product, emit);
  }

  /// Increases the quantity of a specific product in the cart.
  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    _handleQuantityIncrease(event.product, emit);
  }

  /// Internal helper to increment product quantity or add a new item.
  void _handleQuantityIncrease(Product product, Emitter<CartState> emit) {
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

  /// Decreases the quantity of a product. If it reaches zero, the item is removed.
  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    final existingIndex = currentItems.indexWhere((item) => item.product.id == event.product.id);

    if (existingIndex != -1) {
      final existingItem = currentItems[existingIndex];
      if (existingItem.quantity > 1) {
        currentItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity - 1);
      } else {
        // Cache before removal for undo functionality.
        _lastRemovedItem = existingItem;
        _lastRemovedIndex = existingIndex;
        currentItems.removeAt(existingIndex);
      }
    }
    emit(CartUpdated(items: currentItems));
  }

  /// Completely removes an item from the cart regardless of its quantity.
  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final List<CartItemModel> currentItems = List.from(state.items);
    final existingIndex = currentItems.indexWhere((item) => item.product.id == event.product.id);
    
    if (existingIndex != -1) {
      // Cache before removal for undo functionality.
      _lastRemovedItem = currentItems[existingIndex];
      _lastRemovedIndex = existingIndex;
      currentItems.removeAt(existingIndex);
    }
    emit(CartUpdated(items: currentItems));
  }
}
