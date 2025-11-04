// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icon,
    required this.activeIcon,
    required this.index,
    required this.height,
  });

  final int currentIndex;
  final Function(int p1) onTap;
  final String icon;
  final String activeIcon;
  final int index;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;
    final iconPath = isActive ? activeIcon : icon;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                height: height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
