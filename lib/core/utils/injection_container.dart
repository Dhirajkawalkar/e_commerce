/// Dependency Injection (DI) container for the application.
/// 
/// This file uses the GetIt package to manage service location. It initializes
/// and registers all external services, blocs, repositories, and data services
/// needed for the application.
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

/// The Service Locator instance.
final sl = GetIt.instance;

/// Initializes all dependencies.
/// 
/// This function is called in [main.dart] before the app starts.
Future<void> init() async {
  // Initialize Firebase with platform-specific options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // External Services: Register instances of third-party libraries.
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Blocs: Register factories for Blocs so a new instance is created each time.
  sl.registerFactory(() => HomeBloc(productRepository: sl()));
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => AuthBloc(repository: sl()));

  // Repositories: Register singletons for data repositories.
  sl.registerLazySingleton(() => ProductRepository(service: sl()));
  sl.registerLazySingleton(() => AuthRepository(firebaseAuth: sl()));

  // Services: Register singletons for data services.
  sl.registerLazySingleton(() => ProductService());
}
