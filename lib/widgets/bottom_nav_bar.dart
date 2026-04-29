import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppTexts.dashboard,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: AppTexts.statistics,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: AppTexts.shop,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: AppTexts.history,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppTexts.profile,
        ),
      ],
    );
  }
}
