import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bar_chart),
          label: AppTexts.statistics,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: AppTexts.shop,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.history),
          label: AppTexts.history,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppTexts.profile,
        ),
      ],
    );
  }
}
