import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../auth/screens/profile_screen.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_state.dart';
import '../../cart/screens/cart_screen.dart';
import '../bloc/home_bloc.dart';
import '../screens/search_screen.dart';


class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.surface.withAlpha(204),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.home_filled, color: AppColors.primary, size: 28),
                  IconButton(
                    icon: const Icon(Icons.search, color: AppColors.textSecondary, size: 28),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<HomeBloc>(),
                            child: const SearchScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textSecondary, size: 28),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                          ),
                          if (state.totalItems > 0)
                            Positioned(
                              right: 0,
                              top: 4,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: AppColors.primary,
                                child: Text('${state.totalItems}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: AppColors.textSecondary, size: 28),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

