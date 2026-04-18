import 'package:flutter/material.dart';
import '../domain/entities/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Hero(
        tag: 'product_image_${product.id}',
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => Container(
            height: 250,
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

