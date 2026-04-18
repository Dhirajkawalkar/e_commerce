import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/injection_container.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/home_category_chips.dart';
import '../widgets/home_product_content.dart';

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
            extendBody: true,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.primary),
                    child: Text('Cartify', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: AppColors.background,
                    forceElevated: innerBoxIsScrolled,
                    leading: IconButton(
                      icon: const Icon(Icons.notes_rounded, color: AppColors.textPrimary),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    title: const Text('Cartify', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
                        onPressed: () {},
                      ),
                    ],
                    bottom: const PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: HomeCategoryChips(),
                    ),
                  ),
                ];
              },
              body: const AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: HomeProductContent(),
              ),
            ),
            bottomNavigationBar: const HomeBottomNavBar(),
          );
        },
      ),
    );
  }
}