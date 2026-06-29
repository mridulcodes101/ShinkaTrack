import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTheme defines the premium visual design tokens for ShinkaTrack N3.
/// It uses Material Design 3 and is inspired by traditional Japanese aesthetics:
/// - Samurai Indigo (深藍 - Fukai Ai): Representing dedication and focus.
/// - Cherry Blossom Pink (桜色 - Sakura Iro): Representing growth and progress.
/// - Sakura Gold (金箔 - Kinpaku): Representing achievement and mastery.
class AppTheme {
  AppTheme._();

  // Custom Colors
  static const Color samuraiIndigo = Color(0xFF1E293B); // Dark slate indigo
  static const Color sakuraPink = Color(0xFFEC4899);    // Vibrant pink
  static const Color kinpakuGold = Color(0xFFD97706);   // Deep gold

  static const Color darkBg = Color(0xFF0F172A);        // Very dark blue-grey slate
  static const Color darkSurface = Color(0xFF1E293B);   // Slate blue-grey surface
  static const Color lightBg = Color(0xFFF8FAFC);       // Soft white-blue grey
  static const Color lightSurface = Color(0xFFFFFFFF);  // Pure white surface

  static Color _getSeedColor(String colorKey) {
    switch (colorKey) {
      case 'pink':
        return const Color(0xFFEC4899);
      case 'gold':
        return const Color(0xFFD97706);
      case 'green':
        return const Color(0xFF10B981);
      case 'violet':
        return const Color(0xFF8B5CF6);
      case 'indigo':
      default:
        return const Color(0xFF4F46E5);
    }
  }

  /// Light theme configuration
  static ThemeData lightTheme(String colorKey) {
    final seedColor = _getSeedColor(colorKey);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
        primary: seedColor,
        onPrimary: Colors.white,
        secondary: const Color(0xFFEC4899),
        onSecondary: Colors.white,
        tertiary: const Color(0xFFD97706),
        onTertiary: Colors.white,
        background: lightBg,
        surface: lightSurface,
        surfaceVariant: const Color(0xFFE2E8F0),
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        color: lightSurface,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: seedColor,
        centerTitle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightSurface,
        indicatorColor: const Color(0xFFE2E8F0),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
        elevation: 8,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData darkTheme(String colorKey) {
    final seedColor = _getSeedColor(colorKey);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
        primary: seedColor == const Color(0xFF4F46E5) ? const Color(0xFF818CF8) : seedColor,
        onPrimary: const Color(0xFF0F172A),
        secondary: const Color(0xFFF472B6),
        onSecondary: const Color(0xFF0F172A),
        tertiary: const Color(0xFFF59E0B),
        onTertiary: const Color(0xFF0F172A),
        background: darkBg,
        surface: darkSurface,
        surfaceVariant: const Color(0xFF334155),
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
        color: darkSurface,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkSurface,
        indicatorColor: const Color(0xFF334155),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
        elevation: 8,
      ),
    );
  }
}
