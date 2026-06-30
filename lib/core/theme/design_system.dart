import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';

/// PremiumDesignSystem holds structural design tokens and high-end
/// glassmorphic/gradient widgets for a paid-app UI feel.
class PremiumDesignSystem {
  PremiumDesignSystem._();

  // Premium HSL-Tailored Color Palette
  static const Color primaryBlue = AppColors.samuraiIndigo;    // Indigo
  static const Color secondaryPink = AppColors.sakuraPink;  // Sakura Pink
  static const Color forestEmerald = AppColors.forestGreen;  // Forest Green
  static const Color amberGold = AppColors.kinpakuGold;      // Gold Accent
  static const Color deepSlate = AppColors.backgroundDark;      // Dark slate background
  static const Color surfaceDark = AppColors.surfaceDark;    // Slate surface
  static const Color backgroundLight = AppColors.backgroundLight; // Crisp light background
  static const Color surfaceLight = AppColors.surfaceLight;   // Crisp light surface

  // Premium Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryBlue, AppColors.samuraiIndigoLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient sakuraGradient = LinearGradient(
    colors: [secondaryPink, AppColors.sakuraPinkLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient forestGradient = LinearGradient(
    colors: [forestEmerald, AppColors.forestGreenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient orbGradient = RadialGradient(
    colors: [AppColors.samuraiIndigoLight, Colors.transparent],
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
