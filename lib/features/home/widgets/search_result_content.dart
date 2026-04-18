import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_colors.dart';
import '../../product/domain/entities/product.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/product_card.dart';

class SearchResultContent extends StatelessWidget {
  const SearchResultContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildSearchContent(state),
        );
      },
    );
  }

  Widget _buildSearchContent(HomeState state) {
    if (state is HomeLoading) {
      final dummyProducts = List.generate(
        4,
        (index) => Product(
          id: 'dummy_$index',
          name: 'Loading Product Name Lengthy',
          price: 99.99,
          imageUrl: 'https://dummyimage.com/400x400/fff/aaa',
          category: 'All',
          rating: 4.5,
        ),
      );

      return Skeletonizer(
        enabled: true,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ProductCard(product: dummyProducts[index]);
          },
        ),
      );
    } else if (state is HomeLoaded) {
      if (state.searchQuery.trim().isEmpty) {
        return const Center(
          child: Text(
            'Type something to start searching...',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        );
      }

      if (state.filteredProducts.isEmpty) {
        return const EmptyStateView();
      }

      return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: state.filteredProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: state.filteredProducts[index]);
        },
      );
    }
    return const SizedBox.shrink();
  }
}

