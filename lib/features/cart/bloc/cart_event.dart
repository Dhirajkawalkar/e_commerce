/// Events for the Cart Bloc.
/// 
/// These classes represent user actions that modify the contents or 
/// quantities of items in the shopping cart.
import 'package:equatable/equatable.dart';
import '../../product/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when a user adds a product to their cart.
class AddToCart extends CartEvent {
  final Product product;
  const AddToCart({required this.product});
  @override
  List<Object?> get props => [product];
}

/// Event triggered when a user completely removes a product from their cart.
class RemoveFromCart extends CartEvent {
  final Product product;
  const RemoveFromCart({required this.product});
  @override
  List<Object?> get props => [product];
}

/// Event triggered when a user increases the quantity of a product already in the cart.
class IncreaseQuantity extends CartEvent {
  final Product product;
  const IncreaseQuantity({required this.product});
  @override
  List<Object?> get props => [product];
}

/// Event triggered when a user decreases the quantity of a product in the cart.
class DecreaseQuantity extends CartEvent {
  final Product product;
  const DecreaseQuantity({required this.product});
  @override
  List<Object?> get props => [product];
}

/// Event triggered to remove all items from the cart.
class ClearCart extends CartEvent {
  const ClearCart();
  @override
  List<Object?> get props => [];
}

/// Event triggered to restore the last removed item back to the cart.
class UndoRemove extends CartEvent {
  const UndoRemove();
  @override
  List<Object?> get props => [];
}
