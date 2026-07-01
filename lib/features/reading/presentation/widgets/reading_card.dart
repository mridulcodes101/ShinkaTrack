import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';

class ReadingCard extends StatelessWidget {
  final ReadingModel reading;
  final VoidCallback onBookmarkPressed;
  final VoidCallback onReadPressed;

  const ReadingCard({
    super.key,
    required this.reading,
    required this.onBookmarkPressed,
    required this.onReadPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Status settings
    Color statusColor = Colors.grey;
    String statusLabel = 'Unread';
    if (reading.status == 'completed') {
      statusColor = Colors.green;
      statusLabel = 'Completed';
    } else if (reading.status == 'reading') {
      statusColor = Colors.orange;
      statusLabel = 'Reading';
    }

    final int wordCount = reading.spec.passage.split(RegExp(r'\s+')).length;

    return Semantics(
      label: 'Reading passage ${reading.spec.title}. JLPT level N${reading.spec.jlpt}. Difficulty: ${reading.spec.difficulty}. Reading time: ${reading.spec.estimatedReadingTime} minutes. Status: $statusLabel.',
      button: true,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: reading.isAdded 
                ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3) 
                : Colors.black.withValues(alpha: 0.05),
            width: reading.isAdded ? 1.5 : 1.0,
          ),
        ),
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onReadPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'reading-title-${reading.spec.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            reading.spec.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildBadge(context, 'N${reading.spec.jlpt}', PremiumDesignSystem.primaryBlue),
                  ],
                ),
                const SizedBox(height: 10),

                // Specs list (Reading time, word count, difficulty)
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 14, color: isDark ? Colors.white60 : Colors.black54),
                    const SizedBox(width: 4),
                    Text('${reading.spec.estimatedReadingTime} min', style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.black54)),
                    const SizedBox(width: 12),
                    Icon(Icons.short_text_rounded, size: 14, color: isDark ? Colors.white60 : Colors.black54),
                    const SizedBox(width: 4),
                    Text('$wordCount words', style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.black54)),
                  ],
                ),
                const SizedBox(height: 12),

                // Status & Bookmark Flags
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          reading.status == 'completed' ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: statusColor,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        reading.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: reading.isFavorite ? PremiumDesignSystem.primaryBlue : Colors.grey,
                      ),
                      onPressed: onBookmarkPressed,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),

                const Divider(height: 24),

                // Actions (Touch targets: 48dp height minimum)
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
                          onPressed: () => context.push('/reading_details?id=${reading.spec.id}'),
                          child: const Text('View details', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PremiumDesignSystem.primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: onReadPressed,
                          child: Text(
                            reading.status == 'reading' ? 'Continue Reading' : 'Read Now',
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
