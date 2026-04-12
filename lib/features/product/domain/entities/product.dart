import 'package:equatable/equatable.dart';

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

  // Business Logic representation in Domain Level
  bool get isExpensive => price > 100.0;
  bool get isHighlyRated => rating > 4.5;

  @override
  List<Object?> get props => [id, name, price, imageUrl, category, rating];
}
