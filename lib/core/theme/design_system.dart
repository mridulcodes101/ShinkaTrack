import 'dart:ui';
import 'package:flutter/material.dart';

/// PremiumDesignSystem holds structural design tokens and high-end
/// glassmorphic/gradient widgets for a paid-app UI feel.
class PremiumDesignSystem {
  PremiumDesignSystem._();

  // Premium HSL-Tailored Color Palette
  static const Color primaryBlue = Color(0xFF4F46E5);    // Indigo
  static const Color secondaryPink = Color(0xFFEC4899);  // Sakura Pink
  static const Color forestEmerald = Color(0xFF10B981);  // Forest Green
  static const Color amberGold = Color(0xFFF59E0B);      // Gold Accent
  static const Color deepSlate = Color(0xFF0F172A);      // Dark slate background
  static const Color surfaceDark = Color(0xFF1E293B);    // Slate surface
  static const Color backgroundLight = Color(0xFFF8FAFC); // Crisp light background
  static const Color surfaceLight = Color(0xFFFFFFFF);   // Crisp light surface

  // Premium Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryBlue, Color(0xFF818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient sakuraGradient = LinearGradient(
    colors: [secondaryPink, Color(0xFFF472B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient forestGradient = LinearGradient(
    colors: [forestEmerald, Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient orbGradient = RadialGradient(
    colors: [Color(0xFF818CF8), Colors.transparent],
    radius: 0.8,
  );

  // Soft Layered Box Shadows (Paid-app card elevation)
  static List<BoxShadow> get premiumShadow {
    return [
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
  }

  static List<BoxShadow> get activeOrbShadow {
    return [
      BoxShadow(
        color: primaryBlue.withValues(alpha: 0.25),
        blurRadius: 30,
        spreadRadius: 4,
      ),
    ];
  }
}

/// A premium Glassmorphic container mimicking Notion/Duolingo clean surfaces.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 24.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isDark
        ? const Color(0xFF1E293B).withValues(alpha: 0.65)
        : Colors.white.withValues(alpha: 0.75);

    final Border defaultBorder = Border.all(
      color: isDark
          ? const Color(0xFF334155).withValues(alpha: 0.5)
          : const Color(0xFFE2E8F0).withValues(alpha: 0.5),
      width: 1,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ?? defaultBorder,
            boxShadow: PremiumDesignSystem.premiumShadow,
          ),
          child: child,
        ),
      ),
    );
  }
}
