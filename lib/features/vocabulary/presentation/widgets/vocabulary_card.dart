import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';

class VocabularyCard extends StatelessWidget {
  final VocabularyModel vocab;
  final VoidCallback onAddPressed;
  final VoidCallback onViewDetailsPressed;
  final VoidCallback? onLongPress;
  final bool isSelected;

  const VocabularyCard({
    super.key,
    required this.vocab,
    required this.onAddPressed,
    required this.onViewDetailsPressed,
    this.onLongPress,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = vocab.isAdded ? Colors.green : Colors.grey;
    final statusText = vocab.isAdded ? 'Added' : 'Not Added';

    return Semantics(
      label: 'Vocabulary ${vocab.spec.word}, reading: ${vocab.spec.kana}, meaning: ${vocab.spec.meaning}. JLPT N${vocab.spec.jlpt}. Part of speech: ${vocab.spec.partOfSpeech}. Collection status: $statusText.',
      button: true,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        elevation: isSelected ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isSelected
              ? const BorderSide(color: PremiumDesignSystem.primaryBlue, width: 2)
              : BorderSide(
                  color: vocab.isAdded 
                      ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3) 
                      : Colors.black.withValues(alpha: 0.05),
                  width: vocab.isAdded ? 1.5 : 1.0,
                ),
        ),
        color: isSelected 
            ? (isDark ? Colors.blue.withValues(alpha: 0.15) : Colors.blue.withValues(alpha: 0.05))
            : (isDark ? PremiumDesignSystem.surfaceDark : Colors.white),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onViewDetailsPressed,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Word & Kana details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'vocab-word-${vocab.spec.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                vocab.spec.word,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vocab.spec.kana,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // JLPT & POS Badges
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBadge(context, 'N${vocab.spec.jlpt}', PremiumDesignSystem.primaryBlue),
                        const SizedBox(height: 6),
                        if (vocab.spec.partOfSpeech.isNotEmpty)
                          _buildBadge(context, vocab.spec.partOfSpeech, PremiumDesignSystem.secondaryPink),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Meaning Section
                Text(
                  vocab.spec.meaning,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Collection Status & Favourites Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          vocab.isAdded ? Icons.check_circle : Icons.radio_button_unchecked,
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
                        if (vocab.isAdded && vocab.status != 'unlearned') ...[
                          const SizedBox(width: 8),
                          _buildBadge(
                            context,
                            vocab.status.toUpperCase(),
                            vocab.status == 'mastered' ? Colors.green : Colors.orange,
                          ),
                        ],
                      ],
                    ),
                    if (vocab.isFavorite)
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                  ],
                ),
                
                const Divider(height: 24),
                
                // Card Actions (Touch targets: 48dp height minimum)
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
                            backgroundColor: vocab.isAdded 
                                ? Colors.green.withValues(alpha: 0.1) 
                                : PremiumDesignSystem.primaryBlue,
                            foregroundColor: vocab.isAdded 
                                ? Colors.green 
                                : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: vocab.isAdded 
                              ? () => context.push('/vocabulary/collection')
                              : onAddPressed,
                          child: Text(
                            vocab.isAdded ? 'Open Collection' : 'Add to Collection',
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
