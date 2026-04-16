import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../firebase_options.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/cart/bloc/cart_bloc.dart';
import '../../features/product/data/repositories/product_repository.dart';
import '../../features/product/data/services/product_service.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Firebase mapping your local flutterfire configurations explicitly
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // External Services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Blocs
  sl.registerFactory(() => HomeBloc(productRepository: sl()));
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => AuthBloc(repository: sl()));

  // Repositories
  sl.registerLazySingleton(() => ProductRepository(service: sl()));
  sl.registerLazySingleton(() => AuthRepository(firebaseAuth: sl()));

  // Services
  sl.registerLazySingleton(() => ProductService());
}
