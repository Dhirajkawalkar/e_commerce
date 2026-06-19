/// The entry point of the E-Commerce application.
/// 
/// This file initializes the application, sets up dependency injection,
/// configures the global Bloc providers, and defines the base app structure
/// including theme and initial routing based on authentication state.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_colors.dart';
import 'core/utils/injection_container.dart' as di;
import 'features/home/screens/home_screen.dart';
import 'features/cart/bloc/cart_bloc.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_event.dart';
import 'features/auth/bloc/auth_state.dart';
import 'features/auth/screens/login_screen.dart';

void main() async {
  // Ensure that widget binding is initialized before using platform channels.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection for the entire app.
  await di.init(); 
  
  runApp(const ECommerceApp());
}

/// The root widget of the application.
class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider provides CartBloc and AuthBloc globally.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CartBloc>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatus())),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          cardColor: AppColors.surface,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: AppColors.textPrimary),
            bodySmall: TextStyle(color: AppColors.textSecondary),
          ),
          useMaterial3: true,
        ),
        // Decides which screen to show based on AuthState.
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomeScreen();
            } else if (state is Unauthenticated) {
              return const LoginScreen();
            }
            // Show a loading indicator while checking auth status.
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
