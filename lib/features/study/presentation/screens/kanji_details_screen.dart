import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class KanjiDetailsScreen extends ConsumerStatefulWidget {
  final String kanjiId;
  const KanjiDetailsScreen({super.key, required this.kanjiId});

  @override
  ConsumerState<KanjiDetailsScreen> createState() => _KanjiDetailsScreenState();
}

class _KanjiDetailsScreenState extends ConsumerState<KanjiDetailsScreen> {
  // Helpers to map SRS learning stages based on review count
  String _getSrsStage(int reviews) {
    if (reviews == 0) return 'Unstarted';
    if (reviews <= 2) return 'Apprentice';
    if (reviews <= 4) return 'Guru';
    if (reviews <= 6) return 'Master';
    if (reviews <= 8) return 'Enlightened';
    return 'Burned';
  }

  Color _getSrsStageColor(String stage) {
    switch (stage) {
      case 'Unstarted':
        return Colors.grey;
      case 'Apprentice':
        return Colors.purple;
      case 'Guru':
        return Colors.indigo;
      case 'Master':
        return Colors.blue;
      case 'Enlightened':
        return Colors.teal;
      case 'Burned':
        return const Color(0xFFD32F2F);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(StudyStatus status) {
    switch (status) {
      case StudyStatus.mastered:
        return PremiumDesignSystem.forestEmerald;
      case StudyStatus.learning:
        return Colors.orange;
      case StudyStatus.unlearned:
        return Colors.grey;
    }
  }

  void _confirmDeleteKanji(BuildContext context, KanjiEntity k) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Delete Kanji?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete "${k.kanji}"? This will clear all scheduling, progress history, and custom notes.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(kanjiListProvider.notifier).deleteKanji(k.id);
                // Pop the dialog
                Navigator.pop(context);
                // Pop the details screen back to study list
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${k.kanji}" has been deleted.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final kanjis = ref.watch(kanjiListProvider).value ?? [];
    // Handle the case where the kanji was deleted and we need to pop safely
    final matchedIndex = kanjis.indexWhere((k) => k.id == widget.kanjiId);
    if (matchedIndex == -1) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final k = kanjis[matchedIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = _getStatusColor(k.status);
    final srsStage = _getSrsStage(k.reviewCount);
    final srsColor = _getSrsStageColor(srsStage);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Collapsible Pinned Header
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            stretch: true,
            backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : PremiumDesignSystem.primaryBlue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(k.isFavorite ? Icons.star : Icons.star_border, color: k.isFavorite ? PremiumDesignSystem.amberGold : Colors.white),
                tooltip: 'Favorite',
                onPressed: () {
                  ref.read(kanjiListProvider.notifier).toggleFavorite(k.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                tooltip: 'Edit',
                onPressed: () => context.push('/add_kanji?id=${k.id}'),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white),
                tooltip: 'Delete',
                onPressed: () => _confirmDeleteKanji(context, k),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1E1E3F), PremiumDesignSystem.surfaceDark]
                        : [PremiumDesignSystem.primaryBlue, PremiumDesignSystem.primaryBlue.withValues(alpha: 0.85)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'kanji_char_${k.id}',
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        k.kanji,
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Details List
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meaning & Learning Status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            k.meaning,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: statusColor.withValues(alpha: 0.4), width: 1.5),
                          ),
                          child: Text(
                            k.isLearned ? 'Learned' : 'Study List',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Grid of key metadata parameters
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.25,
                      children: [
                        _buildQuickInfoCard('JLPT', 'N${k.jlptLevel}', Icons.stars, PremiumDesignSystem.primaryBlue, isDark),
                        _buildQuickInfoCard('Grade', k.gradeLevel == null ? 'N/A' : (k.gradeLevel == 7 ? 'J. High' : 'G${k.gradeLevel}'), Icons.school, Colors.orange, isDark),
                        _buildQuickInfoCard('Stroke Count', '${k.strokeCount}', Icons.edit_road, Colors.teal, isDark),
                        _buildQuickInfoCard('Radical', k.radicals == '-' ? 'None' : k.radicals, Icons.category, Colors.indigo, isDark),
                        _buildQuickInfoCard('Unicode', k.unicode == '-' ? 'N/A' : k.unicode, Icons.code, Colors.pink, isDark),
                        _buildQuickInfoCard('SRS Stage', srsStage, Icons.rocket_launch, srsColor, isDark),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Onyomi & Kunyomi Card
                    _buildSectionHeader('Readings', Icons.translate),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 0,
                      color: isDark ? const Color(0xFF1E1E2F) : Colors.black.withValues(alpha: 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isDark ? Colors.white10 : Colors.black12,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildReadingItem('Onyomi (Chinese)', k.onYomi.join(', ').isEmpty ? 'None' : k.onYomi.join(', '), isDark),
                            const Divider(height: 24),
                            _buildReadingItem('Kunyomi (Japanese)', k.kunYomi.join(', ').isEmpty ? 'None' : k.kunYomi.join(', '), isDark),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // SRS Statistics details
                    _buildSectionHeader('Study Statistics', Icons.analytics_outlined),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 0,
                      color: isDark ? const Color(0xFF1E1E2F) : Colors.black.withValues(alpha: 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildStatRow('Total Reviews Done', '${k.reviewCount}', isDark),
                            const Divider(),
                            _buildStatRow('Ease Factor (Multiplier)', '${k.easeFactor.toStringAsFixed(2)}x', isDark),
                            const Divider(),
                            _buildStatRow('Next Scheduled Review', k.nextReview == null ? 'Not Scheduled' : _formatDate(k.nextReview!), isDark),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Notes Section
                    if (k.notes.isNotEmpty) ...[
                      _buildSectionHeader('Personal Notes', Icons.description_outlined),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E2F) : Colors.black.withValues(alpha: 0.02),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
                        ),
                        child: Text(
                          k.notes,
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Examples Section
                    if (k.examples.isNotEmpty) ...[
                      _buildSectionHeader('Example Words', Icons.import_contacts_outlined),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: k.examples.map((ex) {
                          return Chip(
                            label: Text(ex, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: isDark ? Colors.white10 : Colors.black12.withValues(alpha: 0.05),
                            side: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Diagram Section
                    if (k.strokeOrderDiagramPath != null) ...[
                      _buildSectionHeader('Stroke Order Diagram', Icons.gesture),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(k.strokeOrderDiagramPath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              color: isDark ? Colors.white10 : Colors.black12,
                              alignment: Alignment.center,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.broken_image_outlined, color: Colors.grey, size: 36),
                                  SizedBox(height: 8),
                                  Text('Diagram file could not be loaded', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: PremiumDesignSystem.primaryBlue),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: -0.3),
        ),
      ],
    );
  }

  Widget _buildQuickInfoCard(String label, String value, IconData icon, Color color, bool isDark) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: isDark ? const Color(0xFF1E1E2F) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingItem(String title, String readings, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          readings,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final difference = dt.difference(now);
    if (difference.isNegative) return 'Due now';
    if (difference.inMinutes < 60) return 'In ${difference.inMinutes} minutes';
    if (difference.inHours < 24) return 'In ${difference.inHours} hours';
    return 'In ${difference.inDays} days';
  }
}
