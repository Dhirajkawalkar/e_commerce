import '../../product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

/// [HomeState] defines the various UI states for the Home screen.
/// It uses [Equatable] for efficient state comparison and UI rebuilding.
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the Home screen is first created.
class HomeInitial extends HomeState {}

/// State representing that data is being fetched (e.g., loading products).
class HomeLoading extends HomeState {}

/// State that contains the successfully loaded data for the Home screen.
/// Includes various lists of products for different sections and current filters.
class HomeLoaded extends HomeState {
  /// All products available in the system.
  final List<Product> allProducts;

  /// Products filtered by search or category.
  final List<Product> filteredProducts;

  /// Products highlighted as "Popular".
  final List<Product> popularProducts;

  /// Products suggested based on user interests.
  final List<Product> recommendedProducts;

  /// Currently selected category filter (defaults to 'All').
  final String selectedCategory;

  /// Current search text applied to the product list.
  final String searchQuery;

  const HomeLoaded({
    required this.allProducts,
    required this.filteredProducts,
    required this.popularProducts,
    required this.recommendedProducts,
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
        allProducts,
        filteredProducts,
        popularProducts,
        recommendedProducts,
        selectedCategory,
        searchQuery
      ];
}

/// State representing a failure in loading home data.
class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
