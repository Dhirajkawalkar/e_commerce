/// Business Logic Component (Bloc) for the Home screen.
/// 
/// This class manages the state of the Home screen, including fetching products
/// from the [ProductRepository], filtering them by category, and handling
/// search queries.
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product/data/repositories/product_repository.dart';
import '../../product/domain/entities/product.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;

  HomeBloc({required this.productRepository}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<ChangeCategory>(_onChangeCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  /// Helper method to filter the product list based on category and search query.
  List<Product> _applyFilters(List<Product> source, String category, String query) {
    return source.where((product) {
      final matchesCategory = category == 'All' || product.category == category;
      final matchesSearch = query.isEmpty || 
          product.name.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  /// Handles loading all initial data for the Home screen.
  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await productRepository.getProducts();

      // Filter products for specific sections (Popular, Recommended).
      final popularProducts = products.where((p) => p.rating >= 4.5).toList();
      final recommendedProducts = products.take(6).toList();

      emit(HomeLoaded(
        allProducts: products,
        filteredProducts: products, 
        popularProducts: popularProducts, 
        recommendedProducts: recommendedProducts,
        selectedCategory: 'All',
        searchQuery: '',
      ));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  /// Handles category selection changes and updates the filtered product list.
  void _onChangeCategory(
    ChangeCategory event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final targetCategory = event.category;

      final newFilterMap = _applyFilters(
        currentState.allProducts, 
        targetCategory, 
        currentState.searchQuery
      );

      emit(HomeLoaded(
        allProducts: currentState.allProducts,
        filteredProducts: newFilterMap,
        popularProducts: currentState.popularProducts,
        recommendedProducts: currentState.recommendedProducts,
        selectedCategory: targetCategory,
        searchQuery: currentState.searchQuery, 
      ));
    }
  }

  /// Handles search query changes and updates the filtered product list.
  void _onSearchProducts(
    SearchProducts event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final targetQuery = event.query;

      final newFilterMap = _applyFilters(
        currentState.allProducts, 
        currentState.selectedCategory, 
        targetQuery
      );

      emit(HomeLoaded(
        allProducts: currentState.allProducts,
        filteredProducts: newFilterMap,
        popularProducts: currentState.popularProducts,
        recommendedProducts: currentState.recommendedProducts,
        selectedCategory: currentState.selectedCategory, 
        searchQuery: targetQuery,
      ));
    }
  }
}
