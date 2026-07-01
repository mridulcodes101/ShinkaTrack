import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/grammar/application/grammar_notifier.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';

final grammarDetailsProvider = FutureProvider.autoDispose.family<GrammarModel?, String>((ref, id) async {
  final repo = ref.watch(grammarRepositoryProvider);
  return repo.getGrammarDetails(id);
});

class GrammarDetailsScreen extends ConsumerStatefulWidget {
  final String grammarId;
  const GrammarDetailsScreen({super.key, required this.grammarId});

  @override
  ConsumerState<GrammarDetailsScreen> createState() => _GrammarDetailsScreenState();
}

class _GrammarDetailsScreenState extends ConsumerState<GrammarDetailsScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isEditingNotes = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _toggleAdded(GrammarModel model) async {
    final notifier = ref.read(grammarLibraryNotifierProvider.notifier);
    final newVal = !model.isAdded;
    await notifier.toggleAdded(model.spec.id, newVal);
    ref.invalidate(grammarDetailsProvider(widget.grammarId));
    ref.invalidate(userGrammarCollectionProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newVal ? 'Added to collection' : 'Removed from collection'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _toggleFavorite(GrammarModel model) async {
    final notifier = ref.read(grammarLibraryNotifierProvider.notifier);
    final newVal = !model.isFavorite;
    await notifier.toggleFavorite(model.spec.id, newVal);
    ref.invalidate(grammarDetailsProvider(widget.grammarId));
    ref.invalidate(userGrammarCollectionProvider);
  }

  Future<void> _changeStatus(GrammarModel model, String status) async {
    final notifier = ref.read(grammarLibraryNotifierProvider.notifier);
    await notifier.updateStudyStatus(model.spec.id, status);
    ref.invalidate(grammarDetailsProvider(widget.grammarId));
    ref.invalidate(userGrammarCollectionProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Study status updated to: ${status.toUpperCase()}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _saveNotes(GrammarModel model) async {
    final repo = ref.read(grammarRepositoryProvider);
    await repo.updateNotes(model.spec.id, _notesController.text.trim());
    ref.invalidate(grammarDetailsProvider(widget.grammarId));
    ref.invalidate(userGrammarCollectionProvider);
    setState(() => _isEditingNotes = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Personal study notes updated'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(grammarDetailsProvider(widget.grammarId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Grammar Lesson', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading lesson: $err')),
        data: (model) {
          if (model == null) {
            return const Center(child: Text('Grammar lesson not found'));
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

                      // Section 1: Meaning
                      _buildSectionHeader('1. Meaning & Concept'),
                      _buildMeaningCard(context, model),
                      const SizedBox(height: 20),

                      // Section 2: Formation Syntax
                      _buildSectionHeader('2. Formation Structure'),
                      _buildFormationCard(context, model),
                      const SizedBox(height: 20),

                      // Section 3: Usage Guidelines
                      _buildSectionHeader('3. Usage Guidelines'),
                      _buildUsageCard(context, model),
                      const SizedBox(height: 20),

                      // Section 4: Subtle Nuance
                      _buildSectionHeader('4. Subtle Nuance'),
                      _buildNuanceCard(context, model),
                      const SizedBox(height: 20),

                      // Section 5: Example Sentences Cards
                      _buildSectionHeader('5. Example Sentences'),
                      _buildExamplesSection(context, model),
                      const SizedBox(height: 20),

                      // Section 6: Common Mistakes
                      _buildSectionHeader('6. Common Mistakes'),
                      _buildCommonMistakesCard(context, model),
                      const SizedBox(height: 20),

                      // Section 7: Related Grammar
                      _buildSectionHeader('7. Related Grammar Points'),
                      _buildRelatedGrammarSection(context, model),
                      const SizedBox(height: 20),

                      // Section 8: Related Vocabulary
                      _buildSectionHeader('8. Related Vocabulary'),
                      _buildRelatedVocabSection(context, model),
                      const SizedBox(height: 20),

                      // Section 9: Related Kanji
                      _buildSectionHeader('9. Related Kanji'),
                      _buildRelatedKanjiSection(context, model),
                      const SizedBox(height: 20),

                      // Personal notes (Visible to added collection)
                      if (model.isAdded) ...[
                        _buildSectionHeader('Personal Study Notes'),
                        _buildPersonalNotesCard(context, model),
                        const SizedBox(height: 20),
                      ],

                      // Section 10: Developer Notes (Visible in Admin Mode only)
                      if (isAdmin) ...[
                        _buildSectionHeader('10. Developer CMS Notes'),
                        _buildAdminNotesCard(context, model),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Button
              _buildBottomActionBar(context, model),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, GrammarModel model) {
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
                  tag: 'grammar-pattern-${model.spec.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      model.spec.grammarPattern,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
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

  Widget _buildMeaningCard(BuildContext context, GrammarModel model) {
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
          Text(
            model.spec.meaning,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: PremiumDesignSystem.primaryBlue),
          ),
          const SizedBox(height: 12),
          const Text(
            'This grammar pattern is commonly used to express intention, regular habits, or contextual conditions depending on formation syntax details.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationCard(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.black26 : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Syntax Rules',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            model.spec.formation.isEmpty ? 'Verb (Dictionary Form) + ' + model.spec.grammarPattern : model.spec.formation,
            style: const TextStyle(fontSize: 16, fontFamily: 'monospace', fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageCard(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Text(
        model.spec.usage.isEmpty ? 'Spoken & Written. Formal level varies based on politeness endings.' : model.spec.usage,
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _buildNuanceCard(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Text(
        model.spec.nuance.isEmpty ? 'Displays dynamic differences between synonymous grammar patterns.' : model.spec.nuance,
        style: const TextStyle(fontSize: 14, height: 1.5, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _buildExamplesSection(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (model.spec.examples.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No example sentences available.'),
        ),
      );
    }

    return Column(
      children: model.spec.examples.map((ex) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ex.japanese,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Furigana placeholder
                const Text(
                  '[Furigana Mode Active]',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const Divider(height: 20),
                Text(
                  ex.english,
                  style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87),
                ),
                const SizedBox(height: 12),
                
                // Content Links (No implementation placeholder chips)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildLinkChip('Vocab Link', Colors.blue),
                    _buildLinkChip('Kanji Link', Colors.teal),
                    _buildLinkChip('Grammar Link', Colors.purple),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLinkChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCommonMistakesCard(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (model.spec.commonMistakes.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: PremiumDesignSystem.premiumShadow,
        ),
        child: const Text('No common mistakes catalogued yet.'),
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
        children: model.spec.commonMistakes.map((mistake) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.cancel, color: Colors.redAccent, size: 16),
                    const SizedBox(width: 8),
                    Text(mistake.incorrect, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Text(mistake.correct, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                if (mistake.explanation.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(mistake.explanation, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
                const Divider(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRelatedGrammarSection(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.spec.relatedGrammar.isEmpty ? 3 : model.spec.relatedGrammar.length,
        itemBuilder: (context, index) {
          final String title = model.spec.relatedGrammar.isEmpty ? '〜わけにはいかない' : model.spec.relatedGrammar[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRelatedVocabSection(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final words = ['練習', '試合', '試す', '準備'];
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(words[index], style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRelatedKanjiSection(BuildContext context, GrammarModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final kanji = ['試', '験', '説', '法'];
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(kanji[index], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPersonalNotesCard(BuildContext context, GrammarModel model) {
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
                hintText: 'Add personal grammar rules notes...',
                border: OutlineInputBorder(),
              ),
            )
          else
            Text(
              model.customNotes.isEmpty ? 'No personal notes added yet. Tap edit to add notes.' : model.customNotes,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }

  Widget _buildAdminNotesCard(BuildContext context, GrammarModel model) {
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
          Text(model.spec.memoryTips ?? ''),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context, GrammarModel model) {
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
                  onPressed: () => context.push('/grammar/collection'),
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
