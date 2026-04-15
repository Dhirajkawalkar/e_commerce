import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/injection_container.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/product_card.dart';
import 'search_screen.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_state.dart';
import '../../cart/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(LoadHomeData()),
      child: Builder(
        builder: (context) {
          return Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true, // Crucial for the bottom dock look
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                child: Text('E-commerce Shop', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: AppColors.background,
                    // Subtle shadow/line when content scrolls under
                    forceElevated: innerBoxIsScrolled,
                    leading: IconButton(
                      icon: const Icon(Icons.notes_rounded, color: AppColors.textPrimary),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    title: Image.asset('assets/images/flipkart_logo.png', height: 30),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
                        onPressed: () {},
                      ),
                    ],
                    // MODERN CHIPS SECTION
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: _buildModernChips(context, state),
                    ),
                  ),
                ];
              },
              body: _buildProductContent(context, state),
            );
          },
        ),
        bottomNavigationBar: _buildBottomDock(context),
          );
        },
      ),
    );
  }

  // Refined modern Chips with animation
  Widget _buildModernChips(BuildContext context, HomeState state) {
    final categories = ['All', 'Electronics', 'Fashion', 'Home'];

    return Container(
      height: 60,
      color: AppColors.background,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = (state is HomeLoaded) ? state.selectedCategory == category : index == 0;

          return GestureDetector(
            onTap: () {
              if (state is HomeLoaded) {
                context.read<HomeBloc>().add(ChangeCategory(category));
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.black12,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]
                    : [],
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductContent(BuildContext context, HomeState state) {
    if (state is HomeLoading || state is HomeInitial) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    } else if (state is HomeError) {
      return Center(child: Text(state.message, style: const TextStyle(color: AppColors.error)));
    } else if (state is HomeLoaded) {
      return RefreshIndicator(
        onRefresh: () async => context.read<HomeBloc>().add(LoadHomeData()),
        child: state.filteredProducts.isEmpty
            ? const Center(child: Text('No products found.'))
            : GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // Extra bottom padding for the Dock
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: state.filteredProducts.length,
          itemBuilder: (context, index) => ProductCard(product: state.filteredProducts[index]),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  // Your Glassmorphism Nav Dock (Kept as is but integrated into build)
  Widget _buildBottomDock(BuildContext context) {
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
                color: AppColors.surface.withOpacity(0.8),
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
                            value: context.read<HomeBloc>(), // Shared Context propagation!
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
                              right: 0, top: 4,
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
                  const Icon(Icons.person_outline, color: AppColors.textSecondary, size: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}