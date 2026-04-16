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
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize Dependency Injection
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomeScreen();
            } else if (state is Unauthenticated) {
              return const LoginScreen();
            }
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
