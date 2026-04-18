import 'package:Cartify/features/home/widgets/product_card.dart';
import 'package:Cartify/features/home/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../product/domain/entities/product.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../screens/section_products_screen.dart';
import 'empty_state_view.dart';
import 'horizontal_product_card.dart';

class HomeProductContent extends StatelessWidget {
  const HomeProductContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return _buildLoadingState();
        } else if (state is HomeError) {
          return Center(child: Text(state.message, style: const TextStyle(color: AppColors.error)));
        } else if (state is HomeLoaded) {
          return _buildLoadedState(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState() {
    final dummyProducts = List.generate(
      4,
      (index) => Product(
        id: 'dummy_$index',
        name: 'Loading Product Name Skeleton',
        price: 99.99,
        imageUrl: 'https://dummyimage.com/400x400/fff/aaa',
        category: 'All',
        rating: 4.5,
      ),
    );

    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'For You'),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4,
              itemBuilder: (context, index) => ProductCard(product: dummyProducts[index]),
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Popular'),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 3,
                itemBuilder: (context, index) => HorizontalProductCard(product: dummyProducts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, HomeLoaded state) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomeBloc>().add(LoadHomeData()),
      child: state.searchQuery.isNotEmpty
          ? (state.filteredProducts.isEmpty
              ? const EmptyStateView()
              : GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.filteredProducts.length,
                  itemBuilder: (context, index) => ProductCard(product: state.filteredProducts[index]),
                ))
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'For You'),
                  if (state.filteredProducts.isEmpty)
                    const Padding(padding: EdgeInsets.only(top: 40), child: EmptyStateView())
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) => ProductCard(product: state.filteredProducts[index]),
                    ),
                  if (state.popularProducts.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    SectionHeader(
                        title: 'Popular',
                        onSeeAll: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SectionProductsScreen(
                                      title: 'Popular Products', products: state.popularProducts)));
                        }),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: state.popularProducts.length,
                        itemBuilder: (context, index) => HorizontalProductCard(product: state.popularProducts[index]),
                      ),
                    ),
                  ],
                  if (state.recommendedProducts.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    SectionHeader(
                        title: 'Recommended',
                        onSeeAll: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SectionProductsScreen(
                                      title: 'Recommended Products', products: state.recommendedProducts)));
                        }),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: state.recommendedProducts.length,
                        itemBuilder: (context, index) =>
                            HorizontalProductCard(product: state.recommendedProducts[index]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

