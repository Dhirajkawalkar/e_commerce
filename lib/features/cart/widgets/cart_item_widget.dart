/// A widget representing a single item in the shopping cart.
/// 
/// This widget displays product details (image, name, price) and provides 
/// controls to increase, decrease, or remove the item from the cart. 
/// It also supports swipe-to-dismiss and an 'Undo' action upon removal.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  /// The cart item data to display.
  final CartItemModel cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  /// Displays a SnackBar with an 'UNDO' action when an item is removed.
  void _showUndoSnackbar(BuildContext context) {
    final cartBloc = context.read<CartBloc>();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // Triggers the UndoRemove event in the CartBloc.
            cartBloc.add(const UndoRemove());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    
    return Dismissible(
      // Unique key for the Dismissible widget to track its identity.
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        // Remove item from cart when swiped.
        context.read<CartBloc>().add(RemoveFromCart(product: product));
        _showUndoSnackbar(context);
      },
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Product Details (Name and Price)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Quantity Controls
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (cartItem.quantity == 1) {
                        _showUndoSnackbar(context);
                      }
                      context.read<CartBloc>().add(DecreaseQuantity(product: product));
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      context.read<CartBloc>().add(IncreaseQuantity(product: product));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
