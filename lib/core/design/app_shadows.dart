import 'package:flutter/material.dart';

/// Centralized Elevation and shadows properties for visual depth.
class AppShadows {
  AppShadows._();

  /// Minimal premium card shadow
  static List<BoxShadow> get premium => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.04),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.02),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  /// Glowing orb active shadow
  static List<BoxShadow> activeOrb(Color primaryColor) => [
        BoxShadow(
          color: primaryColor.withValues(alpha: 0.25),
          blurRadius: 30,
          spreadRadius: 4,
        ),
      ];
}
