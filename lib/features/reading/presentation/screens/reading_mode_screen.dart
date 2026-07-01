import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/reading/application/reading_notifier.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/interactive_text.dart';
import 'package:shinka_track_n3/features/reading/presentation/screens/reading_details_screen.dart';

class ReadingModeScreen extends ConsumerStatefulWidget {
  final String readingId;
  const ReadingModeScreen({super.key, required this.readingId});

  @override
  ConsumerState<ReadingModeScreen> createState() => _ReadingModeScreenState();
}

class _ReadingModeScreenState extends ConsumerState<ReadingModeScreen> {
  // Settings values
  String _fontSize = 'Medium'; // Small, Medium, Large, Extra Large
  String _lineHeight = 'Normal'; // Compact, Normal, Comfortable
  String _readingTheme = 'Light'; // Light, Dark, Sepia
  
  bool _showFurigana = true;
  bool _showTranslation = false;
  bool _highlightVocab = true;
  bool _highlightGrammar = true;
  bool _highlightKanji = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<int> _bookmarkedParagraphs = {};

  double _fontSizeValue() {
    switch (_fontSize) {
      case 'Small': return 14.0;
      case 'Large': return 22.0;
      case 'Extra Large': return 28.0;
      default: return 17.0; // Medium
    }
  }

  double _lineHeightValue() {
    switch (_lineHeight) {
      case 'Compact': return 1.2;
      case 'Comfortable': return 2.1;
      default: return 1.6; // Normal
    }
  }

  Color _themeBgColor(bool isDark) {
    if (_readingTheme == 'Dark') return Colors.black;
    if (_readingTheme == 'Sepia') return const Color(0xFFF4ECD8);
    return isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight;
  }

  Color _themeTextColor(bool isDark) {
    if (_readingTheme == 'Dark') return Colors.white;
    if (_readingTheme == 'Sepia') return const Color(0xFF5B4636);
    return isDark ? Colors.white : Colors.black87;
  }

  void _showVocabSheet(String vocabId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vocabId, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Meaning: to test; to experiment; to try out', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            const Text('JLPT: N3', style: TextStyle(fontSize: 13, color: PremiumDesignSystem.primaryBlue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Add to Collection'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                      // In future sprints, route to Vocabulary detail
                    },
                    child: const Text('Open Vocabulary'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGrammarSheet(String grammarId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(grammarId, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Meaning: making an effort to form a habit', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                  // Route to Grammar detail
                },
                child: const Text('Open Grammar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showKanjiSheet(String kanjiChar) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(kanjiChar, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Meaning: test; try', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            const Text('Stroke Count: 13', style: TextStyle(fontSize: 13, color: Colors.teal, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                  // Route to Kanji detail
                },
                child: const Text('Open Kanji'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompletionOverlay(ReadingModel model) {
    final int wordCount = model.spec.passage.split(RegExp(r'\s+')).length;
    
    // Complete reading status persistence
    ref.read(readingLibraryNotifierProvider.notifier).updateStudyStatus(model.spec.id, 'completed');
    ref.invalidate(userReadingCollectionProvider);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.stars, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Reading Complete!', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Congratulations! You finished reading "${model.spec.title}".'),
            const SizedBox(height: 16),
            _buildCompletionRow('Reading Time', '${model.spec.estimatedReadingTime} min'),
            _buildCompletionRow('Words Read', '$wordCount'),
            _buildCompletionRow('Grammar Covered', '${model.spec.grammarReferences.length} items'),
            _buildCompletionRow('Vocabulary Covered', '${model.spec.vocabularyReferences.length} items'),
            _buildCompletionRow('Kanji Covered', '${model.spec.kanjiReferences.length} items'),
            _buildCompletionRow('Comprehension Score', '80% (Placeholder)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Read Again'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              context.pop(); // Exit Reading Mode back to list
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(readingDetailsProvider(widget.readingId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _themeBgColor(isDark),
      appBar: AppBar(
        title: const Text('Reading Mode', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _themeTextColor(isDark),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Reader Settings',
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: _buildSettingsDrawer(),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading passage: $err')),
        data: (model) {
          if (model == null) {
            return const Center(child: Text('Reading passage not found'));
          }

          // Trigger reading status if unlearned
          if (model.status == 'unlearned') {
            ref.read(readingLibraryNotifierProvider.notifier).updateStudyStatus(model.spec.id, 'reading');
          }

          final paragraphs = model.spec.passage.split('\n');

          return Column(
            children: [
              // Top Progress Indicator
              LinearProgressIndicator(
                value: 0.5, // progress placeholder
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Distraction-free title
                      Text(
                        model.spec.title,
                        style: TextStyle(
                          fontSize: _fontSizeValue() + 6,
                          fontWeight: FontWeight.bold,
                          color: _themeTextColor(isDark),
                        ),
                      ),
                      const Divider(height: 36),

                      // Paragraph sections (with bookmark triggers)
                      ...paragraphs.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final paraText = entry.value.trim();
                        if (paraText.isEmpty) return const SizedBox.shrink();

                        final isBookmarked = _bookmarkedParagraphs.contains(idx);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bookmark indicator column
                              IconButton(
                                icon: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: isBookmarked ? PremiumDesignSystem.primaryBlue : Colors.grey.withValues(alpha: 0.4),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isBookmarked) {
                                      _bookmarkedParagraphs.remove(idx);
                                    } else {
                                      _bookmarkedParagraphs.add(idx);
                                    }
                                  });
                                },
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.only(right: 8),
                              ),

                              // Interactive paragraph block
                              Expanded(
                                child: InteractiveText(
                                  text: paraText,
                                  vocabIds: model.spec.vocabularyReferences,
                                  grammarIds: model.spec.grammarReferences,
                                  kanjiIds: model.spec.kanjiReferences,
                                  onVocabTapped: _showVocabSheet,
                                  onGrammarTapped: _showGrammarSheet,
                                  onKanjiTapped: _showKanjiSheet,
                                  fontSize: _fontSizeValue(),
                                  lineHeight: _lineHeightValue(),
                                  highlightVocab: _highlightVocab,
                                  highlightGrammar: _highlightGrammar,
                                  highlightKanji: _highlightKanji,
                                  showFurigana: _showFurigana,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      // English Translation Section
                      if (_showTranslation) ...[
                        const Divider(height: 48),
                        Text(
                          'ENGLISH TRANSLATION',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.withValues(alpha: 0.8), letterSpacing: 1.0),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          model.spec.translation.isEmpty ? 'Translation placeholder.' : model.spec.translation,
                          style: TextStyle(
                            fontSize: _fontSizeValue() - 2,
                            height: _lineHeightValue(),
                            color: _themeTextColor(isDark).withValues(alpha: 0.8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],

                      const SizedBox(height: 40),

                      // Reached end completion button
                      Center(
                        child: SizedBox(
                          height: 52,
                          width: 220,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.check),
                            label: const Text('I Finished Reading', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () => _showCompletionOverlay(model),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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

  Widget _buildSettingsDrawer() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            const Text('Reader Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 24),

            // Typography Size Section
            const Text('FONT SIZE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: ['Small', 'Medium', 'Large', 'Extra Large'].map((sz) {
                final isSelected = _fontSize == sz;
                return ChoiceChip(
                  label: Text(sz),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _fontSize = sz);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Line Height Section
            const Text('LINE HEIGHT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: ['Compact', 'Normal', 'Comfortable'].map((lh) {
                final isSelected = _lineHeight == lh;
                return ChoiceChip(
                  label: Text(lh),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _lineHeight = lh);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Reading Theme Section
            const Text('THEME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: ['Light', 'Dark', 'Sepia'].map((tm) {
                final isSelected = _readingTheme == tm;
                return ChoiceChip(
                  label: Text(tm),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _readingTheme = tm);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Toggle Switches
            const Text('VISIBILITY & HIGHLIGHTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Show Furigana', style: TextStyle(fontSize: 14)),
              value: _showFurigana,
              onChanged: (val) => setState(() => _showFurigana = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Show English Translation', style: TextStyle(fontSize: 14)),
              value: _showTranslation,
              onChanged: (val) => setState(() => _showTranslation = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Vocabulary', style: TextStyle(fontSize: 14)),
              value: _highlightVocab,
              onChanged: (val) => setState(() => _highlightVocab = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Grammar', style: TextStyle(fontSize: 14)),
              value: _highlightGrammar,
              onChanged: (val) => setState(() => _highlightGrammar = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Kanji', style: TextStyle(fontSize: 14)),
              value: _highlightKanji,
              onChanged: (val) => setState(() => _highlightKanji = val),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
