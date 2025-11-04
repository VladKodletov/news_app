import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_asets.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/widgets/bottom_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 20),
      decoration: AppConstants.boxDecorationElements,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomBarItem(
              height: 27,
              currentIndex: currentIndex,
              onTap: onTap,
              icon: AppAssets.newsIcon,
              activeIcon: AppAssets.newsIconActive,
              index: 0),
          BottomBarItem(
              height: 33,
              currentIndex: currentIndex,
              onTap: onTap,
              icon: AppAssets.favoritesIcon,
              activeIcon: AppAssets.favoritesIconActive,
              index: 1),
        ],
      ),
    );
  }
}
