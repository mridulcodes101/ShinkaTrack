import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/vocabulary/application/vocabulary_notifier.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';

final vocabDetailsProvider = FutureProvider.autoDispose.family<VocabularyModel?, String>((ref, id) async {
  final repo = ref.watch(vocabRepositoryProvider);
  return repo.getVocabularyDetails(id);
});

class VocabularyDetailsScreen extends ConsumerStatefulWidget {
  final String vocabId;
  const VocabularyDetailsScreen({super.key, required this.vocabId});

  @override
  ConsumerState<VocabularyDetailsScreen> createState() => _VocabularyDetailsScreenState();
}

class _VocabularyDetailsScreenState extends ConsumerState<VocabularyDetailsScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isEditingNotes = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _toggleAdded(VocabularyModel model) async {
    final notifier = ref.read(vocabLibraryNotifierProvider.notifier);
    final newVal = !model.isAdded;
    await notifier.toggleAdded(model.spec.id, newVal);
    ref.invalidate(vocabDetailsProvider(widget.vocabId));
    ref.invalidate(userVocabCollectionProvider);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newVal ? 'Added to collection' : 'Removed from collection'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _toggleFavorite(VocabularyModel model) async {
    final notifier = ref.read(vocabLibraryNotifierProvider.notifier);
    final newVal = !model.isFavorite;
    await notifier.toggleFavorite(model.spec.id, newVal);
    ref.invalidate(vocabDetailsProvider(widget.vocabId));
    ref.invalidate(userVocabCollectionProvider);
  }

  Future<void> _changeStatus(VocabularyModel model, String status) async {
    final notifier = ref.read(vocabLibraryNotifierProvider.notifier);
    await notifier.updateStudyStatus(model.spec.id, status);
    ref.invalidate(vocabDetailsProvider(widget.vocabId));
    ref.invalidate(userVocabCollectionProvider);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Study status updated to: ${status.toUpperCase()}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _saveNotes(VocabularyModel model) async {
    final repo = ref.read(vocabRepositoryProvider);
    await repo.updateNotes(model.spec.id, _notesController.text.trim());
    ref.invalidate(vocabDetailsProvider(widget.vocabId));
    ref.invalidate(userVocabCollectionProvider);
    setState(() => _isEditingNotes = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Personal notes updated'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(vocabDetailsProvider(widget.vocabId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Vocabulary Details', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading details: $err')),
        data: (model) {
          if (model == null) {
            return const Center(child: Text('Vocabulary details not found'));
          }

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

                      // Example Usage
                      _buildSectionTitle('Example Usage'),
                      _buildExamplesCard(context, model),
                      const SizedBox(height: 20),

                      // Related Content
                      _buildSectionTitle('Related Content'),
                      _buildRelatedCard(context, model),
                      const SizedBox(height: 20),

                      // Personal Notes
                      if (model.isAdded) ...[
                        _buildSectionTitle('Personal Study Notes'),
                        _buildPersonalNotesCard(context, model),
                        const SizedBox(height: 20),
                      ],

                      // Developer Notes (admin only)
                      if (isAdmin && model.spec.personalNotes != null && model.spec.personalNotes!.isNotEmpty) ...[
                        _buildSectionTitle('CMS Editorial Notes'),
                        _buildAdminNotesCard(context, model),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom action bar
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

  Widget _buildHeaderCard(BuildContext context, VocabularyModel model) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'vocab-word-${model.spec.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      model.spec.word,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  model.spec.kana,
                  style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  model.spec.meaning,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('JLPT N${model.spec.jlpt}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue)),
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
            Column(
              children: [
                IconButton(
                  icon: Icon(model.isFavorite ? Icons.star : Icons.star_border, color: Colors.amber),
                  onPressed: () => _toggleFavorite(model),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                  tooltip: 'Update Study Progress',
                  onSelected: (st) => _changeStatus(model, st),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'unlearned', child: Text('UNLEARNED')),
                    const PopupMenuItem(value: 'learning', child: Text('LEARNING')),
                    const PopupMenuItem(value: 'mastered', child: Text('MASTERED')),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard(BuildContext context, VocabularyModel model) {
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
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        children: [
          buildRow('Part of Speech', model.spec.partOfSpeech.isEmpty ? 'None' : model.spec.partOfSpeech),
          const Divider(),
          buildRow('Frequency Rank', model.spec.frequency > 0 ? '#${model.spec.frequency}' : 'Unranked'),
          const Divider(),
          buildRow('Pitch Accent Pattern', 'Heiban (placeholder)'), // Pitch accent placeholder
          const Divider(),
          buildRow('Tags', model.spec.tags.isEmpty ? 'None' : model.spec.tags.join(', ')),
        ],
      ),
    );
  }

  Widget _buildExamplesCard(BuildContext context, VocabularyModel model) {
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
          const Text('Example Sentences', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          if (model.spec.exampleSentences.isEmpty)
            const Text('No example sentences available')
          else
            ...model.spec.exampleSentences.map((s) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right_rounded, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(child: Text(s, style: const TextStyle(fontSize: 14, height: 1.4))),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildRelatedCard(BuildContext context, VocabularyModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget buildChip(String label, Color color) {
      return Container(
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
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
          const Text('Linked Kanji References', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          if (model.spec.kanjiUsed.isEmpty)
            const Text('No linked Kanji')
          else
            Wrap(
              children: model.spec.kanjiUsed.map((k) => buildChip(k, Colors.blue)).toList(),
            ),
          const Divider(height: 24),
          const Text('Grammar & Listening Modules', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Wrap(
            children: [
              buildChip('N3 Listening Section 2', Colors.orange),
              buildChip('Common Particle Usages', Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalNotesCard(BuildContext context, VocabularyModel model) {
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
                hintText: 'Add study notes, mnemonics, or memory tips...',
                border: OutlineInputBorder(),
              ),
            )
          else
            Text(
              model.customNotes.isEmpty ? 'No personal notes added yet. Tap edit to add your own!' : model.customNotes,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }

  Widget _buildAdminNotesCard(BuildContext context, VocabularyModel model) {
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
          const Text('Editorial / Developer CMS Notes', style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(model.spec.personalNotes ?? ''),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context, VocabularyModel model) {
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
                    side: const BorderSide(color: PremiumDesignSystem.primaryBlue),
                    foregroundColor: PremiumDesignSystem.primaryBlue,
                  ),
                  onPressed: () => context.push('/vocabulary/collection'),
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
