import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/kanji/application/kanji_notifier.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/kanji/domain/repositories/kanji_repository.dart';

final kanjiDetailsProvider = FutureProvider.autoDispose.family<KanjiModel?, String>((ref, id) async {
  final repo = ref.watch(kanjiRepositoryProvider);
  return repo.getKanjiDetails(id);
});

class KanjiDetailsScreen extends ConsumerStatefulWidget {
  final String kanjiId;
  const KanjiDetailsScreen({super.key, required this.kanjiId});

  @override
  ConsumerState<KanjiDetailsScreen> createState() => _KanjiDetailsScreenState();
}

class _KanjiDetailsScreenState extends ConsumerState<KanjiDetailsScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isEditingNotes = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _toggleAdded(KanjiModel model) async {
    final notifier = ref.read(libraryNotifierProvider.notifier);
    final newVal = !model.isAdded;
    await notifier.toggleAdded(model.spec.id, newVal);
    ref.invalidate(kanjiDetailsProvider(widget.kanjiId));
    ref.invalidate(userCollectionProvider);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newVal ? 'Added to collection' : 'Removed from collection'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _toggleFavorite(KanjiModel model) async {
    final notifier = ref.read(libraryNotifierProvider.notifier);
    final newVal = !model.isFavorite;
    await notifier.toggleFavorite(model.spec.id, newVal);
    ref.invalidate(kanjiDetailsProvider(widget.kanjiId));
    ref.invalidate(userCollectionProvider);
  }

  Future<void> _toggleMastered(KanjiModel model) async {
    final notifier = ref.read(libraryNotifierProvider.notifier);
    final newVal = !model.isLearned;
    await notifier.toggleMastered(model.spec.id, newVal);
    ref.invalidate(kanjiDetailsProvider(widget.kanjiId));
    ref.invalidate(userCollectionProvider);
  }

  Future<void> _saveNotes(KanjiModel model) async {
    final repo = ref.read(kanjiRepositoryProvider);
    await repo.updateNotes(model.spec.id, _notesController.text.trim());
    ref.invalidate(kanjiDetailsProvider(widget.kanjiId));
    ref.invalidate(userCollectionProvider);
    setState(() => _isEditingNotes = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notes updated successfully'), duration: Duration(seconds: 1)),
    );
  }

  void _playAudio(KanjiModel model) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Audio trigger: playing ${model.spec.audio ?? "kanji_${model.spec.id}.mp3"}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(kanjiDetailsProvider(widget.kanjiId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Kanji Details', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading details: $err')),
        data: (model) {
          if (model == null) {
            return const Center(child: Text('Kanji details not found'));
          }

          // Update notes text controller once loaded
          if (!_isEditingNotes && _notesController.text != model.customNotes) {
            _notesController.text = model.customNotes;
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Card
                      _buildHeaderCard(context, model),
                      const SizedBox(height: 20),

                      // Basic Info Section
                      _buildSectionTitle('Basic Information'),
                      _buildBasicInfoCard(context, model),
                      const SizedBox(height: 20),

                      // Readings Section
                      _buildSectionTitle('Readings'),
                      _buildReadingsCard(context, model),
                      const SizedBox(height: 20),

                      // Examples Section
                      _buildSectionTitle('Examples'),
                      _buildExamplesCard(context, model),
                      const SizedBox(height: 20),

                      // Related Content
                      _buildSectionTitle('Related Content'),
                      _buildRelatedCard(context, model),
                      const SizedBox(height: 20),

                      // Media Section
                      _buildSectionTitle('Media & Visuals'),
                      _buildMediaCard(context, model),
                      const SizedBox(height: 20),

                      // User Collection Settings (notes, favorites)
                      if (model.isAdded) ...[
                        _buildSectionTitle('Personal Collection & Notes'),
                        _buildPersonalNotesCard(context, model),
                        const SizedBox(height: 20),
                      ],

                      // Developer Notes (admin only)
                      if (isAdmin && model.spec.personalNotes != null && model.spec.personalNotes!.isNotEmpty) ...[
                        _buildSectionTitle('CMS Developer/Editorial Notes'),
                        _buildAdminNotesCard(context, model),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Action Bar
              _buildBottomActionBar(context, model),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Row(
        children: [
          Hero(
            tag: 'kanji-${model.spec.id}',
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                model.spec.character,
                style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.spec.meaning,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('JLPT N${model.spec.jlptLevel}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: model.isAdded ? Colors.green.withValues(alpha: 0.15) : Colors.grey.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        model.isAdded ? 'In Collection' : 'Not Added',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: model.isAdded ? Colors.green : Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (model.isAdded) ...[
            IconButton(
              icon: Icon(model.isFavorite ? Icons.star : Icons.star_border, color: Colors.amber),
              onPressed: () => _toggleFavorite(model),
            ),
            IconButton(
              icon: Icon(model.isLearned ? Icons.check_circle : Icons.check_circle_outline, color: Colors.green),
              onPressed: () => _toggleMastered(model),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget buildRow(String k, String v) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Text(k, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const Spacer(),
            Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        children: [
          buildRow('Unicode', model.spec.unicode),
          const Divider(),
          buildRow('Grade Level', 'Grade ${model.spec.gradeLevel}'),
          const Divider(),
          buildRow('Stroke Count', '${model.spec.strokeCount} strokes'),
          const Divider(),
          buildRow('Radicals', model.spec.radicals.isEmpty ? 'None' : model.spec.radicals),
          const Divider(),
          buildRow('Frequency Rank', model.spec.frequencyRank > 0 ? '#${model.spec.frequencyRank}' : 'Unranked'),
        ],
      ),
    );
  }

  Widget _buildReadingsCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Onyomi (Chinese readings)', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            model.spec.onyomi.isEmpty ? 'None' : model.spec.onyomi.join(', '),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PremiumDesignSystem.secondaryPink),
          ),
          const Divider(height: 24),
          const Text('Kunyomi (Japanese readings)', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            model.spec.kunyomi.isEmpty ? 'None' : model.spec.kunyomi.join(', '),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PremiumDesignSystem.forestEmerald),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Example Words', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          if (model.spec.exampleWords.isEmpty)
            const Text('No example words stored')
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: model.spec.exampleWords.map((w) {
                return Chip(
                  label: Text(w),
                  backgroundColor: isDark ? Colors.white10 : Colors.black12,
                );
              }).toList(),
            ),
          const Divider(height: 24),
          const Text('Example Sentences', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          if (model.spec.exampleSentences.isEmpty)
            const Text('No example sentences stored')
          else
            ...model.spec.exampleSentences.map((s) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.play_arrow, size: 14, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(s, style: const TextStyle(fontSize: 13, height: 1.4)),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildRelatedCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget buildChip(String id, Color color) {
      return Container(
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(id, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Linked Vocabulary References', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Wrap(
            children: [
              buildChip('試験', Colors.blue),
              buildChip('試みる', Colors.blue),
              buildChip('試す', Colors.blue),
            ],
          ),
          const Divider(height: 24),
          const Text('Linked Grammar/Readings', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Wrap(
            children: [
              buildChip('〜てみる', Colors.purple),
              buildChip('Reading N3 Passages', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediaCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Audio Pronunciation', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: PremiumDesignSystem.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.volume_up),
            label: const Text('Play Audio'),
            onPressed: () => _playAudio(model),
          ),
          const Divider(height: 24),
          const Text('Stroke Order Diagram', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.brush, color: Colors.grey),
                SizedBox(width: 8),
                Text('Stroke Order Visualizer active', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalNotesCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Personal Study Notes', style: TextStyle(fontSize: 12, color: Colors.grey)),
              IconButton(
                icon: Icon(_isEditingNotes ? Icons.check : Icons.edit, size: 18),
                onPressed: () {
                  if (_isEditingNotes) {
                    _saveNotes(model);
                  } else {
                    setState(() => _isEditingNotes = true);
                  }
                },
              ),
            ],
          ),
          if (_isEditingNotes)
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add personal mnemonics, tips, or notes...',
                border: OutlineInputBorder(),
              ),
            )
          else
            Text(
              model.customNotes.isEmpty ? 'No custom notes added. Tap edit to add your own.' : model.customNotes,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }

  Widget _buildAdminNotesCard(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Editorial / CMS Developer Notes', style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(model.spec.personalNotes ?? ''),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context, KanjiModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: model.isAdded ? Colors.redAccent.withValues(alpha: 0.1) : PremiumDesignSystem.primaryBlue,
                    foregroundColor: model.isAdded ? Colors.redAccent : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(model.isAdded ? Icons.remove_circle : Icons.bookmark_add),
                  label: Text(
                    model.isAdded ? 'Remove from Collection' : 'Add to Collection',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _toggleAdded(model),
                ),
              ),
            ),
            if (model.isAdded) ...[
              const SizedBox(width: 12),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: PremiumDesignSystem.primaryBlue),
                    foregroundColor: PremiumDesignSystem.primaryBlue,
                  ),
                  onPressed: () => context.push('/kanji/collection'),
                  child: const Text('Open Collection', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
