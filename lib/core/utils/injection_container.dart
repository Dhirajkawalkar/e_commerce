import 'package:get_it/get_it.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/cart/bloc/cart_bloc.dart';
import '../../features/product/data/repositories/product_repository.dart';
import '../../features/product/data/services/product_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs (Factory so that each requesting screen gets a brand new instance)
  sl.registerFactory(() => HomeBloc(productRepository: sl()));
  sl.registerFactory(() => CartBloc());

  // Repositories (Lazy Singleton so they are generated once only on request)
  sl.registerLazySingleton(() => ProductRepository(service: sl()));

  // Services
  sl.registerLazySingleton(() => ProductService());
}
