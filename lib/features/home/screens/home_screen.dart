import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/injection_container.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/product_card.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_state.dart';
import '../../cart/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(LoadHomeData()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: const Text(
            'E-Commerce Shop',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          centerTitle: true,
          elevation: 0, // Flattened header prioritizing the Dock depth bounds
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: AppColors.error, fontSize: 16),
                ),
              );
            } else if (state is HomeLoaded) {
              final categories = ['All', 'Electronics', 'Fashion', 'Home'];
              
              return Column(
                children: [
                  SizedBox(
                    height: 56, // 8pt Grid Height limit natively 
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = state.selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0), // 8pt padding constraints
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            showCheckmark: false,
                            onSelected: (selected) {
                              if (selected && !isSelected) {
                                context.read<HomeBloc>().add(ChangeCategory(category));
                              }
                            },
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.surface,
                            side: isSelected ? BorderSide.none : const BorderSide(color: Colors.black12),
                            labelStyle: TextStyle(
                              color: isSelected ? AppColors.surface : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () async {
                        context.read<HomeBloc>().add(LoadHomeData());
                      },
                      child: state.filteredProducts.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: const [
                                SizedBox(height: 150),
                                Center(
                                  child: Text(
                                    'No products found in this category.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16.0), // 8pt Grid spacing limit parameters exactly
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                              ),
                              itemCount: state.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = state.filteredProducts[index];
                                return ProductCard(product: product);
                              },
                            ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        
        // Floating Cloud-Glassmorphism Navigation Dock Layered Interface
        extendBody: true, // Required ensuring underlying grids flow fluidly smoothly beneath the docking element
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(24.0), // Constraint applied matching edges margin specifically 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Glassmorphism Alpha 10 strict filter
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.8), // Cloud White Filter Surface
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: AppColors.surface.withValues(alpha: 0.5)),
                    boxShadow: [
                      // Enforced Ambient bounds cleanly shadowing natively!
                      BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 40)
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.home_filled, color: AppColors.primary, size: 28),
                      const Icon(Icons.search, color: AppColors.textSecondary, size: 28),
                      // Embedded interactive Cart Action Area wrapped organically 
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textSecondary, size: 28),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                                },
                              ),
                              if (state.totalItems > 0)
                                Positioned(
                                  right: -4,
                                  top: -8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${state.totalItems}',
                                      style: const TextStyle(color: AppColors.surface, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const Icon(Icons.person_outline, color: AppColors.textSecondary, size: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
