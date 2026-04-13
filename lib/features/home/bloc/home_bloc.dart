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
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await productRepository.getProducts();
      // On fresh loads, the filter remains completely unified with primary memory arrays matching default category parameters safely
      emit(HomeLoaded(
        allProducts: products,
        filteredProducts: products,
        selectedCategory: 'All',
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

      List<Product> newFilterMap;
      if (targetCategory == 'All') {
        newFilterMap = currentState.allProducts;
      } else {
        newFilterMap = currentState.allProducts
            .where((p) => p.category == targetCategory)
            .toList();
      }

      // Emitting localized mapped state avoiding costly deep network calls 
      emit(HomeLoaded(
        allProducts: currentState.allProducts,
        filteredProducts: newFilterMap,
        selectedCategory: targetCategory,
      ));
    }
  }
}
