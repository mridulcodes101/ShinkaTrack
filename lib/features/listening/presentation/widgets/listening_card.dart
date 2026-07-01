import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';

class ListeningCard extends StatelessWidget {
  final ListeningModel listening;
  final VoidCallback onBookmarkPressed;
  final VoidCallback onPlayPressed;

  const ListeningCard({
    super.key,
    required this.listening,
    required this.onBookmarkPressed,
    required this.onPlayPressed,
  });

  String _formatDuration(double seconds) {
    final int mins = seconds ~/ 60;
    final int secs = (seconds % 60).toInt();
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Status settings
    Color statusColor = Colors.grey;
    String statusLabel = 'Unread';
    if (listening.status == 'completed') {
      statusColor = Colors.green;
      statusLabel = 'Completed';
    } else if (listening.status == 'reading' || listening.status == 'progress' || listening.status == 'learning') {
      statusColor = Colors.orange;
      statusLabel = 'In Progress';
    }

    final hasTranscript = listening.spec.transcript.trim().isNotEmpty;

    return Semantics(
      label: 'Listening lesson ${listening.spec.title}. JLPT level N${listening.spec.jlpt}. Difficulty: ${listening.spec.difficulty}. Duration: ${_formatDuration(listening.spec.duration)}. Status: $statusLabel.',
      button: true,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: listening.isAdded 
                ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3) 
                : Colors.black.withValues(alpha: 0.05),
            width: listening.isAdded ? 1.5 : 1.0,
          ),
        ),
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPlayPressed,
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
                        tag: 'listening-title-${listening.spec.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            listening.spec.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildBadge(context, 'N${listening.spec.jlpt}', PremiumDesignSystem.primaryBlue),
                  ],
                ),
                const SizedBox(height: 10),

                // Specs list (Duration, transcript availability, difficulty)
                Row(
                  children: [
                    Icon(Icons.headset_rounded, size: 14, color: isDark ? Colors.white60 : Colors.black54),
                    const SizedBox(width: 4),
                    Text(_formatDuration(listening.spec.duration), style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.black54)),
                    const SizedBox(width: 12),
                    Icon(Icons.description_rounded, size: 14, color: hasTranscript ? Colors.green : Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      hasTranscript ? 'Transcript Available' : 'No Transcript',
                      style: TextStyle(fontSize: 12, color: hasTranscript ? Colors.green : Colors.grey),
                    ),
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
                          listening.status == 'completed' ? Icons.check_circle : Icons.radio_button_unchecked,
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
                        listening.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: listening.isFavorite ? PremiumDesignSystem.primaryBlue : Colors.grey,
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
                          onPressed: () => context.push('/listening_details?id=${listening.spec.id}'),
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
                          onPressed: onPlayPressed,
                          child: Text(
                            (listening.status == 'reading' || listening.status == 'progress' || listening.status == 'learning') ? 'Continue' : 'Play Lesson',
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
