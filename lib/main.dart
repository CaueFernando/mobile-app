import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/pet_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/statistics_screen.dart';
import 'themes/app_theme.dart';
import 'utils/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const StepToStopApp(),
    ),
  );
}

class StepToStopApp extends StatelessWidget {
  const StepToStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: AppTexts.appName,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const MainNavigationScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    StatisticsScreen(),
    ShopScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) => setState(() => _currentPageIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Estat\u00edsticas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Pet Shop'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Hist\u00f3rico'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
