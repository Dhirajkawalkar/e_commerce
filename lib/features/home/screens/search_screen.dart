import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_result_content.dart';

/// [SearchScreen] provides a dedicated interface for searching products.
/// It consists of a top search bar and a results area that updates dynamically.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// The input field for the search query.
            SearchBarWidget(),
            /// The list of products that match the current search query.
            Expanded(
              child: SearchResultContent(),
            ),
          ],
        ),
      ),
    );
  }
}
