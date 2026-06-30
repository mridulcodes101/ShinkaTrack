import 'package:flutter/material.dart';

/// Centralized color tokens for ShinkaTrack's design system.
/// Contains the premium HSL-tailored palettes for all 5 selectable theme options.
class AppColors {
  AppColors._();

  // Functional Colors (Light Mode)
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Functional Colors (Dark Mode)
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF334155);

  // Alert & Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Premium Theme Accent Colors
  static const Color samuraiIndigo = Color(0xFF4F46E5);
  static const Color samuraiIndigoLight = Color(0xFF818CF8);

  static const Color sakuraPink = Color(0xFFEC4899);
  static const Color sakuraPinkLight = Color(0xFFF472B6);

  static const Color kinpakuGold = Color(0xFFD97706);
  static const Color kinpakuGoldLight = Color(0xFFF59E0B);

  static const Color forestGreen = Color(0xFF059669);
  static const Color forestGreenLight = Color(0xFF34D399);

  static const Color royalViolet = Color(0xFF7C3AED);
  static const Color royalVioletLight = Color(0xFFA78BFA);

  /// Resolves the primary seed color key to a concrete flutter Color
  static Color getPrimarySeed(String colorKey) {
    switch (colorKey) {
      case 'pink':
        return sakuraPink;
      case 'gold':
        return kinpakuGold;
      case 'green':
        return forestGreen;
      case 'violet':
        return royalViolet;
      case 'indigo':
      default:
        return samuraiIndigo;
    }
  }

  /// Resolves the secondary/lighter accent color based on the selected theme key
  static Color getSecondarySeed(String colorKey) {
    switch (colorKey) {
      case 'pink':
        return sakuraPinkLight;
      case 'gold':
        return kinpakuGoldLight;
      case 'green':
        return forestGreenLight;
      case 'violet':
        return royalVioletLight;
      case 'indigo':
      default:
        return samuraiIndigoLight;
    }
  }
}
