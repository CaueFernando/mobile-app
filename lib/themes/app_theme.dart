import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return _baseTheme(Brightness.light).copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      cardTheme: _cardTheme(AppColors.panel),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg,
        elevation: 0,
        foregroundColor: AppColors.text,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.panel,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }

  static ThemeData darkTheme() {
    return _baseTheme(Brightness.dark).copyWith(
      scaffoldBackgroundColor: AppColors.bgDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      cardTheme: _cardTheme(AppColors.panelDark),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgDark,
        elevation: 0,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.panelDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }

  static ThemeData _baseTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD)),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),
    );
  }

  static CardThemeData _cardTheme(Color color) {
    return CardThemeData(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLG)),
    );
  }
}
