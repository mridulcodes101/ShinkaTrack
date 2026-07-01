import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/listening/application/listening_notifier.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';

final listeningDetailsProvider = FutureProvider.autoDispose.family<ListeningModel?, String>((ref, id) async {
  final repo = ref.watch(listeningRepositoryProvider);
  return repo.getListeningDetails(id);
});

class LessonDetailsScreen extends ConsumerStatefulWidget {
  final String lessonId;
  const LessonDetailsScreen({super.key, required this.lessonId});

  @override
  ConsumerState<LessonDetailsScreen> createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends ConsumerState<LessonDetailsScreen> {

  Future<void> _toggleBookmark(ListeningModel model) async {
    final notifier = ref.read(listeningLibraryNotifierProvider.notifier);
    final newVal = !model.isFavorite;
    await notifier.toggleBookmark(model.spec.id, newVal);
    ref.invalidate(listeningDetailsProvider(widget.lessonId));
    ref.invalidate(userListeningCollectionProvider);
  }

  Future<void> _toggleAdded(ListeningModel model) async {
    final notifier = ref.read(listeningLibraryNotifierProvider.notifier);
    final newVal = !model.isAdded;
    await notifier.toggleAdded(model.spec.id, newVal);
    ref.invalidate(listeningDetailsProvider(widget.lessonId));
    ref.invalidate(userListeningCollectionProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newVal ? 'Added to collection' : 'Removed from collection'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String _formatDuration(double seconds) {
    final int mins = seconds ~/ 60;
    final int secs = (seconds % 60).toInt();
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(listeningDetailsProvider(widget.lessonId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Lesson Details', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading details: $err')),
        data: (model) {
          if (model == null) {
            return const Center(child: Text('Listening lesson not found'));
          }

          final transcriptPreview = model.spec.transcript.length > 120 
              ? '${model.spec.transcript.substring(0, 120)}...'
              : model.spec.transcript;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title block Hero
                      Hero(
                        tag: 'listening-title-${model.spec.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            model.spec.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Meta Specs Chips
                      Row(
                        children: [
                          _buildSpecBadge('JLPT N${model.spec.jlpt}', PremiumDesignSystem.primaryBlue),
                          const SizedBox(width: 8),
                          _buildSpecBadge('Difficulty: ${model.spec.difficulty}', PremiumDesignSystem.secondaryPink),
                          const SizedBox(width: 8),
                          _buildSpecBadge(_formatDuration(model.spec.duration), Colors.teal),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Summary metrics row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMetricColumn('Vocabulary', '${model.spec.vocabularyReferences.length}', Icons.translate),
                          _buildMetricColumn('Grammar', '${model.spec.grammarReferences.length}', Icons.rule),
                          _buildMetricColumn('Kanji', '${model.spec.kanjiReferences.length}', Icons.font_download),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Section: Topics / Tags
                      const Text(
                        'TOPICS',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: const Text('Auditory drills')),
                          Chip(label: const Text('Habit formation')),
                          Chip(label: const Text('Conversation')),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Section: Transcript Preview
                      const Text(
                        'TRANSCRIPT PREVIEW',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                          boxShadow: PremiumDesignSystem.premiumShadow,
                        ),
                        child: Text(
                          transcriptPreview.isEmpty ? 'No audio script available for this lesson.' : transcriptPreview,
                          style: const TextStyle(fontSize: 15, height: 1.6, fontStyle: FontStyle.italic),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom Actions
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                  border: Border(top: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          model.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: model.isFavorite ? PremiumDesignSystem.primaryBlue : Colors.grey,
                        ),
                        onPressed: () => _toggleBookmark(model),
                        tooltip: 'Bookmark Lesson',
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => _toggleAdded(model),
                            child: Text(
                              model.isAdded ? 'Remove from Collection' : 'Add to Collection',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PremiumDesignSystem.primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              context.push('/listening_player?id=${model.spec.id}');
                            },
                            child: const Text(
                              'Start Listening',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSpecBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: PremiumDesignSystem.primaryBlue, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}
