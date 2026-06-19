import 'package:flutter/material.dart';
import '../../product/domain/entities/product.dart';
import '../widgets/product_card.dart';
import '../widgets/empty_state_view.dart';
import '../../../core/constants/app_colors.dart';

/// [SectionProductsScreen] displays a full-screen grid of products for a specific section.
/// This is used when a user clicks "See All" on sections like "Popular" or "Recommended".
class SectionProductsScreen extends StatelessWidget {
  final String title;
  final List<Product> products;

  const SectionProductsScreen({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          title, 
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: products.isEmpty 
          ? const EmptyStateView()
          : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
    );
  }
}
