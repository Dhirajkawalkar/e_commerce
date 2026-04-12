import 'package:equatable/equatable.dart';
import '../models/cart_item_model.dart';

abstract class CartState extends Equatable {
  final List<CartItemModel> items;

  const CartState({this.items = const []});

  int get totalItems => items.fold(0, (total, item) => total + item.quantity);
  
  // Exclusively handled by BLoC Domain Logic, NOT UI!
  double get totalPrice => items.fold(0.0, (total, item) => total + (item.product.price * item.quantity));

  @override
  List<Object?> get props => [items];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  const CartUpdated({required super.items});
}
