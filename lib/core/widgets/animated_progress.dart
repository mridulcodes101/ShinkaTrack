import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';

/// Reusable progress indicator with smooth implicit interpolation.
class AnimatedProgress extends StatelessWidget {
  final double progress; // Between 0.0 and 1.0
  final bool isCircular;
  final double strokeWidth;
  final double size; // Only used when isCircular is true
  final Color? color;

  const AnimatedProgress({
    super.key,
    required this.progress,
    this.isCircular = false,
    this.strokeWidth = 6.0,
    this.size = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = color ?? theme.colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = isDark ? Colors.white10 : Colors.black12;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: AppAnimations.durationSlow,
      curve: AppAnimations.curveDecelerate,
      builder: (context, value, child) {
        if (isCircular) {
          return SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: strokeWidth,
              backgroundColor: trackColor,
              valueColor: AlwaysStoppedAnimation<Color>(activeColor),
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: AppRadius.radiusSM,
            child: LinearProgressIndicator(
              value: value,
              minHeight: strokeWidth,
              backgroundColor: trackColor,
              valueColor: AlwaysStoppedAnimation<Color>(activeColor),
            ),
          );
        }
      },
    );
  }
}
