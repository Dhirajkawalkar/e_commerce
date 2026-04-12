import 'package:equatable/equatable.dart';
import '../../product/domain/entities/product.dart';

class CartItemModel extends Equatable {
  final Product product;
  final int quantity;

  const CartItemModel({required this.product, this.quantity = 1});

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
