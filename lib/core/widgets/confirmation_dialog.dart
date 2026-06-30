import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

/// Reusable premium ConfirmationDialog component.
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final bool isDangerous;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    required this.onConfirm,
    this.isDangerous = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: AppRadius.shapeLG,
      title: Text(
        title,
        style: AppTypography.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: isDangerous ? AppColors.error : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
        ),
      ),
      content: Text(
        message,
        style: AppTypography.bodyMedium.copyWith(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          height: 1.4,
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actions: [
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: cancelLabel,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            AppSpacing.gapSM,
            Expanded(
              child: PrimaryButton(
                label: confirmLabel,
                backgroundColor: isDangerous ? AppColors.error : null,
                foregroundColor: isDangerous ? Colors.white : null,
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
