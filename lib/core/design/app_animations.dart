import 'package:flutter/animation.dart';

/// Centralized Animation properties, curves, and durations for micro-interactions.
class AppAnimations {
  AppAnimations._();

  // Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);

  // Curves
  static const Curve curveStandard = Curves.easeInOutCubic;
  static const Curve curveDecelerate = Curves.easeOutCubic;
  static const Curve curveBounce = Curves.elasticOut;

  // Scale constants
  static const double activeButtonScale = 0.96;
  static const double activeCardScale = 0.98;
}
