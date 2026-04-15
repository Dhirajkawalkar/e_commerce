import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isNotEmpty = _controller.text.isNotEmpty;
      if (_showClear != isNotEmpty) {
        setState(() {
          _showClear = isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Search Bar Top Section matching specific glassmorphism styling
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
                    onPressed: () {
                      context.read<HomeBloc>().add(const SearchProducts('')); // Clear search when retreating
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset.zero,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.textSecondary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true, // Natively invokes keyboard smoothly when UI maps explicitly 
                              style: const TextStyle(color: AppColors.textPrimary),
                              decoration: const InputDecoration(
                                hintText: 'Search products...',
                                hintStyle: TextStyle(color: AppColors.textSecondary),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                context.read<HomeBloc>().add(SearchProducts(value));
                              },
                            ),
                          ),
                          if (_showClear)
                            IconButton(
                              icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                _controller.clear();
                                context.read<HomeBloc>().add(const SearchProducts(''));
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Results UI Layout Mapping cleanly Grid bounds!
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  } else if (state is HomeLoaded) {
                    // Empty query bounds interceptor
                    if (state.searchQuery.trim().isEmpty) {
                      return const Center(
                        child: Text(
                          'Type something to start searching...',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                        ),
                      );
                    }

                    // Zero hits interceptor bounds
                    if (state.filteredProducts.isEmpty) {
                      return const Center(
                        child: Text(
                          'No products found.',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    // Reused Component grid execution!
                    return GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
