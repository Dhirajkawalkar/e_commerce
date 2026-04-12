import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product/data/repositories/product_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;

  HomeBloc({required this.productRepository}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await productRepository.getProducts();
      emit(HomeLoaded(products: products));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
