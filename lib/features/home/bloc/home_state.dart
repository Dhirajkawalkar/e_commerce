import '../../product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String selectedCategory;

  const HomeLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.selectedCategory = 'All',
  });

  @override
  List<Object?> get props => [allProducts, filteredProducts, selectedCategory];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
