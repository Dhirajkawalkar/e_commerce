import 'package:equatable/equatable.dart';
import '../../product/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  const AddToCart({required this.product});
  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;
  const RemoveFromCart({required this.product});
  @override
  List<Object?> get props => [product];
}

class IncreaseQuantity extends CartEvent {
  final Product product;
  const IncreaseQuantity({required this.product});
  @override
  List<Object?> get props => [product];
}

class DecreaseQuantity extends CartEvent {
  final Product product;
  const DecreaseQuantity({required this.product});
  @override
  List<Object?> get props => [product];
}

class ClearCart extends CartEvent {
  const ClearCart();
  @override
  List<Object?> get props => [];
}
