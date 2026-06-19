/// Data model for an item in the shopping cart.
/// 
/// This class combines a [Product] entity with a quantity, representing
/// a specific product and how many of it the user wants to purchase.
import 'package:equatable/equatable.dart';
import '../../product/domain/entities/product.dart';

class CartItemModel extends Equatable {
  /// The product being added to the cart.
  final Product product;
  
  /// The quantity of this product in the cart.
  final int quantity;

  const CartItemModel({required this.product, this.quantity = 1});

  /// Creates a copy of this [CartItemModel] with updated fields.
  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
