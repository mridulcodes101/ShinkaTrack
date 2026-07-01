import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';

class GrammarCard extends StatelessWidget {
  final GrammarModel grammar;
  final VoidCallback onAddPressed;
  final VoidCallback onViewLessonPressed;

  const GrammarCard({
    super.key,
    required this.grammar,
    required this.onAddPressed,
    required this.onViewLessonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = grammar.isAdded ? Colors.green : Colors.grey;
    final statusText = grammar.isAdded ? 'Added' : 'Not Added';

    // Difficulty presentation parameters
    Color diffColor = Colors.teal;
    String diffLabel = 'Easy';
    if (grammar.spec.difficulty >= 7.0) {
      diffColor = Colors.redAccent;
      diffLabel = 'Hard';
    } else if (grammar.spec.difficulty >= 4.0) {
      diffColor = Colors.orange;
      diffLabel = 'Medium';
    }

    return Semantics(
      label: 'Grammar pattern ${grammar.spec.grammarPattern}, meaning: ${grammar.spec.meaning}. JLPT level N${grammar.spec.jlpt}. Difficulty: $diffLabel. Status: $statusText.',
      button: true,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: grammar.isAdded 
                ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3) 
                : Colors.black.withValues(alpha: 0.05),
            width: grammar.isAdded ? 1.5 : 1.0,
          ),
        ),
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onViewLessonPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'grammar-pattern-${grammar.spec.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            grammar.spec.grammarPattern,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildBadge(context, 'N${grammar.spec.jlpt}', PremiumDesignSystem.primaryBlue),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Meaning
                Text(
                  grammar.spec.meaning,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Details row (Difficulty, Collection status)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildBadge(context, diffLabel, diffColor),
                        const SizedBox(width: 10),
                        Icon(
                          grammar.isAdded ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: statusColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    if (grammar.isFavorite)
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
                
                const Divider(height: 24),
                
                // Action buttons
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
                          onPressed: onViewLessonPressed,
                          child: const Text('View Lesson', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: grammar.isAdded 
                                ? Colors.green.withValues(alpha: 0.1) 
                                : PremiumDesignSystem.primaryBlue,
                            foregroundColor: grammar.isAdded 
                                ? Colors.green 
                                : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: grammar.isAdded 
                              ? () => context.push('/grammar/collection')
                              : onAddPressed,
                          child: Text(
                            grammar.isAdded ? 'Open Collection' : 'Add to Collection',
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
