import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';
import 'app_card.dart';

/// StatCard displays high-end analytics progress parameters.
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final double? progress; // Value between 0.0 and 1.0

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final brandColor = color ?? theme.colorScheme.primary;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.titleMedium.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
              if (icon != null)
                Icon(icon, size: 20, color: brandColor),
            ],
          ),
          AppSpacing.gapSM,
          Text(
            value,
            style: AppTypography.headlineLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          if (progress != null) ...[
            AppSpacing.gapSM,
            ClipRRect(
              borderRadius: AppRadius.radiusSM,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: isDark ? Colors.white10 : Colors.black12,
                valueColor: AlwaysStoppedAnimation<Color>(brandColor),
              ),
            ),
          ],
          if (subtitle != null) ...[
            AppSpacing.gapXS,
            Text(
              subtitle!,
              style: AppTypography.labelSmall.copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
