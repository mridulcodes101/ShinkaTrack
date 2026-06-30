import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';

/// Reusable M3 Secondary Outlined Button with premium tap-scaling interactions.
class SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _scale = AppAnimations.activeButtonScale);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _scale = 1.0);
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _scale = 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final outlineColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final accentColor = theme.colorScheme.primary;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: (widget.onPressed == null || widget.isLoading) ? null : widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: AppAnimations.durationFast,
        curve: AppAnimations.curveDecelerate,
        child: Container(
          height: AppDimensions.minButtonHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            border: Border.all(color: outlineColor, width: 1.5),
            borderRadius: AppRadius.radiusMD,
            color: Colors.transparent,
          ),
          child: widget.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 18, color: accentColor),
                      AppSpacing.gapXS,
                    ],
                    Text(
                      widget.label,
                      style: AppTypography.titleMedium.copyWith(
                        color: widget.onPressed == null
                            ? (isDark ? Colors.white30 : Colors.black38)
                            : accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
