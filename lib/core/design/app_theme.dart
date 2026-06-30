import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AppTheme builds Material 3 theme modes (Light & Dark) for all 5 traditional accents.
class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(String colorKey) {
    final Color seedColor = AppColors.getPrimarySeed(colorKey);
    final Color secondaryColor = AppColors.getSecondarySeed(colorKey);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
        primary: seedColor,
        onPrimary: Colors.white,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        background: AppColors.backgroundLight,
        surface: AppColors.surfaceLight,
        surfaceVariant: const Color(0xFFE2E8F0),
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderLight, width: 1),
        ),
        color: AppColors.surfaceLight,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: seedColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: seedColor),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: const Color(0xFFE2E8F0),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
        elevation: 8,
      ),
    );
  }

  static ThemeData darkTheme(String colorKey) {
    final Color seedColor = AppColors.getPrimarySeed(colorKey);
    final Color secondaryColor = AppColors.getSecondarySeed(colorKey);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
        primary: seedColor == AppColors.samuraiIndigo ? AppColors.samuraiIndigoLight : seedColor,
        onPrimary: AppColors.backgroundDark,
        secondary: secondaryColor,
        onSecondary: AppColors.backgroundDark,
        background: AppColors.backgroundDark,
        surface: AppColors.surfaceDark,
        surfaceVariant: const Color(0xFF334155),
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        color: AppColors.surfaceDark,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: const Color(0xFF334155),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
        elevation: 8,
      ),
    );
  }
}
