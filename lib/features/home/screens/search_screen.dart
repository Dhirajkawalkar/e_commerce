import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_result_content.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SearchBarWidget(),
            Expanded(
              child: SearchResultContent(),
            ),
          ],
        ),
      ),
    );
  }
}
