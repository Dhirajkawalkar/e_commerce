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

  // Dual-Axis Filter Core Engine decoupled purely functionally out of UI execution paths natively
  List<Product> _applyFilters(List<Product> source, String category, String query) {
    return source.where((product) {
      final matchesCategory = category == 'All' || product.category == category;
      final matchesSearch = query.isEmpty || 
          product.name.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await productRepository.getProducts();
      emit(HomeLoaded(
        allProducts: products,
        filteredProducts: products, // Initial payload maps cleanly
        selectedCategory: 'All',
        searchQuery: '',
      ));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

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
        selectedCategory: targetCategory,
        searchQuery: currentState.searchQuery, // Maintains Query during category swapping
      ));
    }
  }

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
        selectedCategory: currentState.selectedCategory, // Maintains category during typing constraints 
        searchQuery: targetQuery,
      ));
    }
  }
}
