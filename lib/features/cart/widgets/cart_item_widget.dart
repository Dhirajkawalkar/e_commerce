import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  void _showUndoSnackbar(BuildContext context, CartItemModel itemToRestore) {
    // CRITICAL FIX: Capture the Bloc reference safely BEFORE the Widget is destroyed
    // so the SnackBar action isn't referencing a dead unmounted context!
    final cartBloc = context.read<CartBloc>();

    // Quickly override previous active snackbars to prevent queue stacking latency
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating, // Sleeker UI padding
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // Utilize the captured bloc reference directly avoiding lookup errors on dismissed widgets
            cartBloc.add(RestoreCartItem(cartItem: itemToRestore));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    
    // Wrapped internally inside Dismissible natively allowing fluid UX swipe-delete motions
    return Dismissible(
      key: Key(product.id.toString()),
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
        context.read<CartBloc>().add(RemoveFromCart(product: product));
        _showUndoSnackbar(context, cartItem);
      },
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
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
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      // Trip UNDO logic instantly if manual decrement causes threshold removal 
                      if (cartItem.quantity == 1) {
                        _showUndoSnackbar(context, cartItem);
                      }
                      context.read<CartBloc>().add(DecreaseQuantity(product: product));
                    },
                  ),
                  Text(
                    '${cartItem.quantity}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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
