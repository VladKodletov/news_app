import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_event.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  MainLayout({super.key, required this.navigationShell});

  final List<String> _appBarTitles = ['', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigationShell.currentIndex == 0
          ? null
          : AppBar(
              title: Text(_appBarTitles[navigationShell.currentIndex]),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          if (index == 1) {
            context.read<FavoritesBloc>().add(const LoadFavorites());
          }
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
