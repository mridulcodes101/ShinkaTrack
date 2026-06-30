import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';

/// Reusable premium Card container aligned with Design Tokens.
class AppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool isGlassmorphic;
  final Color? color;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.isGlassmorphic = false,
    this.color,
    this.border,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _scale = AppAnimations.activeCardScale);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _scale = 1.0);
    }
  }

  void _onTapCancel() {
    if (widget.onTap != null) {
      setState(() => _scale = 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultColor = widget.color ??
        (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

    final glassColor = isDark
        ? AppColors.surfaceDark.withValues(alpha: 0.65)
        : AppColors.surfaceLight.withValues(alpha: 0.75);

    final defaultBorder = widget.border ??
        Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1.0,
        );

    Widget cardContent = Container(
      padding: widget.padding ?? AppSpacing.paddingMD,
      decoration: BoxDecoration(
        color: widget.isGlassmorphic ? glassColor : defaultColor,
        borderRadius: AppRadius.radiusMD,
        border: defaultBorder,
        boxShadow: AppShadows.premium,
      ),
      child: widget.child,
    );

    if (widget.isGlassmorphic) {
      cardContent = ClipRRect(
        borderRadius: AppRadius.radiusMD,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: cardContent,
        ),
      );
    }

    if (widget.onTap != null) {
      cardContent = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: cardContent,
      );
    }

    return AnimatedScale(
      scale: _scale,
      duration: AppAnimations.durationFast,
      curve: AppAnimations.curveDecelerate,
      child: cardContent,
    );
  }
}
