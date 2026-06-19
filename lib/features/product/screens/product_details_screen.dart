import 'package:flutter/material.dart';
import '../domain/entities/product.dart';
import '../widgets/product_actions.dart';
import '../widgets/product_image.dart';
import '../widgets/product_info.dart';

/// [ProductDetailsScreen] provides a comprehensive view of a specific product.
/// It shows the product image, detailed information (price, rating, description),
/// and actions like "Add to Cart".
class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Displays the product's primary image with a Hero transition.
            ProductImage(product: product),
            /// Shows textual information about the product.
            ProductInfo(
              product: product,
              description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
          ],
        ),
      ),
      /// Sticky bottom bar with primary actions for the product.
      bottomNavigationBar: ProductActions(product: product),
    );
  }
}
