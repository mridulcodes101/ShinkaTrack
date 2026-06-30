import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';

class KanjiEmptyState extends StatelessWidget {
  final bool isUserCollection;
  final VoidCallback? onActionButtonPressed;

  const KanjiEmptyState({
    super.key,
    required this.isUserCollection,
    this.onActionButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final String title = isUserCollection
        ? "Your collection is empty"
        : "No Kanji Available";
        
    final String subtitle = isUserCollection
        ? "You haven't added any Kanji yet. Browse the library to build your collection."
        : "The Kanji database is currently empty. Developer Mode can add content.";

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Premium Illustration/Icon Container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark 
                    ? PremiumDesignSystem.surfaceDark 
                    : PremiumDesignSystem.primaryBlue.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isUserCollection ? Icons.bookmark_border_rounded : Icons.translate_rounded,
                size: 72,
                color: PremiumDesignSystem.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            // Subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Action Button (Only for User Collection empty state)
            if (isUserCollection && onActionButtonPressed != null)
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PremiumDesignSystem.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text(
                    'Browse Kanji Library',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: onActionButtonPressed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
