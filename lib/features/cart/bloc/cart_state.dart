/// States for the Cart Bloc.
/// 
/// These classes represent the current status of the shopping cart,
/// including the list of items currently added by the user.
import 'package:equatable/equatable.dart';
import '../models/cart_item_model.dart';

abstract class CartState extends Equatable {
  /// The list of items in the cart.
  final List<CartItemModel> items;

  const CartState({this.items = const []});

  /// Returns the total number of items in the cart (sum of quantities).
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);
  
  /// Calculates the total price of all items in the cart.
  double get totalPrice => items.fold(0.0, (total, item) => total + (item.product.price * item.quantity));

  @override
  List<Object?> get props => [items];
}

/// Initial state when the cart is empty or hasn't been modified.
class CartInitial extends CartState {}

/// State indicating that the cart content has been updated.
class CartUpdated extends CartState {
  const CartUpdated({required super.items});
}
