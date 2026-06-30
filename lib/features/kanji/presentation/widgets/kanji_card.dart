import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';

class KanjiCard extends StatelessWidget {
  final KanjiModel kanji;
  final VoidCallback onAddPressed;
  final VoidCallback onViewDetailsPressed;

  const KanjiCard({
    super.key,
    required this.kanji,
    required this.onAddPressed,
    required this.onViewDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Status colors
    final statusColor = kanji.isAdded ? Colors.green : Colors.grey;
    final statusText = kanji.isAdded ? 'Added' : 'Not Added';

    return Semantics(
      label: 'Kanji ${kanji.spec.character}, meaning: ${kanji.spec.meaning}. JLPT level N${kanji.spec.jlptLevel}. Stroke count ${kanji.spec.strokeCount}. Status: $statusText.',
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kanji.isAdded 
                ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3) 
                : Colors.black.withValues(alpha: 0.05),
            width: kanji.isAdded ? 1.5 : 1.0,
          ),
          boxShadow: PremiumDesignSystem.premiumShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large Kanji representation
                  Container(
                    width: 72,
                    height: 72,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: isDark 
                          ? LinearGradient(colors: [Colors.white.withValues(alpha: 0.05), Colors.white.withValues(alpha: 0.02)])
                          : LinearGradient(colors: [Colors.black.withValues(alpha: 0.03), Colors.black.withValues(alpha: 0.01)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      kanji.spec.character,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Meanings & Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kanji.spec.meaning,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            _buildBadge(context, 'N${kanji.spec.jlptLevel}', PremiumDesignSystem.primaryBlue),
                            _buildBadge(context, '${kanji.spec.strokeCount} strokes', Colors.teal),
                            _buildBadge(context, 'Grade ${kanji.spec.gradeLevel}', Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        kanji.isAdded ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: statusColor,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  if (kanji.isFavorite)
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                ],
              ),
              
              const Divider(height: 24),
              
              // Actions buttons (48dp height minimum touch targets)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          foregroundColor: isDark ? Colors.white70 : Colors.black54,
                        ),
                        onPressed: onViewDetailsPressed,
                        child: const Text('View Details', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kanji.isAdded 
                              ? Colors.green.withValues(alpha: 0.1) 
                              : PremiumDesignSystem.primaryBlue,
                          foregroundColor: kanji.isAdded 
                              ? Colors.green 
                              : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: kanji.isAdded 
                            ? () => context.push('/kanji/collection')
                            : onAddPressed,
                        child: Text(
                          kanji.isAdded ? 'Open Collection' : 'Add to Collection',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String label, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : color.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}
