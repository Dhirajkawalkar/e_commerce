import 'package:equatable/equatable.dart';

/// [Product] is a core domain entity representing a product in the system.
/// This class is part of the Domain layer and is independent of any data source.
class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });

  /// Business Logic: Returns true if the product is considered high-end.
  bool get isExpensive => price > 100.0;
  
  /// Business Logic: Returns true if the product has high user satisfaction.
  bool get isHighlyRated => rating > 4.5;

  @override
  List<Object?> get props => [id, name, price, imageUrl, category, rating];
}
