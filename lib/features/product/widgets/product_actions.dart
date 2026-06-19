import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/snackbar_type.dart';
import '../../../core/utils/snackbar_util.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_event.dart';
import '../domain/entities/product.dart';

/// [ProductActions] is a sticky bar at the bottom of the Product Details screen.
/// It provides "Add to Cart" and "Buy Now" buttons.
class ProductActions extends StatelessWidget {
  final Product product;

  const ProductActions({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              offset: const Offset(0, -4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Adds the product to the cart without leaving the page.
                  context.read<CartBloc>().add(AddToCart(product: product));
                  showCustomSnackBar(context, '${product.name} added to cart', type: SnackBarType.success);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // In a real app, "Buy Now" might skip the cart and go to checkout.
                  // Here, we add it to the cart as a shortcut.
                  context.read<CartBloc>().add(AddToCart(product: product));
                  showCustomSnackBar(context, '${product.name} prepared for checkout', type: SnackBarType.success);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Buy Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

