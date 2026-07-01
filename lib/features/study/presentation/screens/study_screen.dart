import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';
import 'package:shinka_track_n3/core/navigation/responsive_layout.dart';
import 'package:shinka_track_n3/core/widgets/app_card.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class StudyScreen extends ConsumerStatefulWidget {
  const StudyScreen({super.key});

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  StudyStatus? _selectedStatusFilter;
  String _searchQuery = '';
  bool _selectionMode = false;
  final List<String> _selectedKanjiIds = [];

  // SPEC-002 Learn Hub state fields
  bool _showHub = true;
  bool _filterCollectionOnly = false;

  // Advanced Filters & Sort State
  final List<int> _selectedJlptFilters = []; // empty = all
  bool _filterFavorite = false;
  bool _filterLearned = false;
  bool _filterUnlearned = false;
  bool _filterRecentlyAdded = false;
  bool _filterRecentlyReviewed = false;
  String _sortOption = 'Recently Added'; // 'Alphabetically', 'Recently Added', 'Review Date', 'Stroke Count', 'JLPT'
  int _kanjiLimit = 40;

  void _updateFab() {
    if (!mounted) return;
    if (_showHub) {
      ref.read(activeFabProvider.notifier).state = FabConfig(
        label: 'Add to Collection',
        icon: Icons.bookmark_add,
        onPressed: () => context.push('/add_kanji'),
      );
    } else {
      if (_tabController.index == 0) {
        final isAdmin = ref.read(adminModeProvider);
        if (isAdmin) {
          ref.read(activeFabProvider.notifier).state = FabConfig(
            label: 'Add Master Kanji',
            icon: Icons.add,
            onPressed: () => context.push('/add_kanji'),
          );
        } else {
          ref.read(activeFabProvider.notifier).state = FabConfig(
            label: 'Add to My Collection',
            icon: Icons.bookmark_add,
            onPressed: _addSelectedToCollection,
          );
        }
      } else {
        ref.read(activeFabProvider.notifier).state = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
        _kanjiLimit = 40;
      });
    });

    // Synchronize initial tab from studyTabProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFab();
      final initialTab = ref.read(studyTabProvider);
      if (initialTab >= 0 && initialTab < 5) {
        _tabController.index = initialTab;
      }
    });

    _tabController.addListener(() {
      if (!mounted) return;
      setState(() {});
      _updateFab();
      if (!_tabController.indexIsChanging) {
        ref.read(studyTabProvider.notifier).state = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final label = ref.read(activeFabProvider)?.label;
      if (label == 'Add to Collection' || label == 'Add Master Kanji' || label == 'Add to My Collection') {
        ref.read(activeFabProvider.notifier).state = null;
      }
    });
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildLearnHub(
    bool isDark,
    AsyncValue<List<KanjiEntity>> kanjiAsync,
    AsyncValue<List<VocabularyEntity>> vocabAsync,
    AsyncValue<List<GrammarEntity>> grammarAsync,
    AsyncValue<List<ReadingEntity>> readingAsync,
    AsyncValue<List<ListeningEntity>> listeningAsync,
  ) {
    final kanji = kanjiAsync.value ?? [];
    final vocab = vocabAsync.value ?? [];
    final grammar = grammarAsync.value ?? [];
    final reading = readingAsync.value ?? [];
    final listening = listeningAsync.value ?? [];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Learn Hub', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _buildHubCard(
                title: 'Kanji',
                description: 'Master Chinese characters used in Japanese writing.',
                icon: Icons.abc_rounded,
                learned: kanji.where((k) => k.isLearned).length,
                total: kanji.length,
                due: kanji.where((k) => k.isAdded && !k.isLearned).length,
                onContinue: () {
                  context.push('/kanji/collection');
                },
                onBrowse: () {
                  context.push('/kanji/library');
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildHubCard(
                title: 'Vocabulary',
                description: 'Build your core word bank with translations and readings.',
                icon: Icons.translate,
                learned: vocab.where((v) => v.status == StudyStatus.mastered).length,
                total: vocab.length,
                due: vocab.where((v) => v.status == StudyStatus.learning).length,
                onContinue: () {
                  context.push('/vocabulary/collection');
                },
                onBrowse: () {
                  context.push('/vocabulary/library');
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildHubCard(
                title: 'Grammar',
                description: 'Understand sentence structure rules and particle usage.',
                icon: Icons.bookmark_outline,
                learned: grammar.where((g) => g.status == StudyStatus.mastered).length,
                total: grammar.length,
                due: grammar.where((g) => g.status == StudyStatus.learning).length,
                onContinue: () {
                  setState(() {
                    _filterCollectionOnly = true;
                    _showHub = false;
                    _tabController.index = 2;
                    _updateFab();
                  });
                },
                onBrowse: () {
                  setState(() {
                    _filterCollectionOnly = false;
                    _showHub = false;
                    _tabController.index = 2;
                    _updateFab();
                  });
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildHubCard(
                title: 'Reading',
                description: 'Practice comprehension on real N3 passages.',
                icon: Icons.menu_book,
                learned: reading.where((r) => r.status == StudyStatus.mastered).length,
                total: reading.length,
                due: reading.where((r) => r.status == StudyStatus.learning).length,
                onContinue: () {
                  setState(() {
                    _filterCollectionOnly = true;
                    _showHub = false;
                    _tabController.index = 3;
                    _updateFab();
                  });
                },
                onBrowse: () {
                  setState(() {
                    _filterCollectionOnly = false;
                    _showHub = false;
                    _tabController.index = 3;
                    _updateFab();
                  });
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildHubCard(
                title: 'Listening',
                description: 'Train your ear with audio prompts and scripts.',
                icon: Icons.headset,
                learned: listening.where((l) => l.status == StudyStatus.mastered).length,
                total: listening.length,
                due: listening.where((l) => l.status == StudyStatus.learning).length,
                onContinue: () {
                  setState(() {
                    _filterCollectionOnly = true;
                    _showHub = false;
                    _tabController.index = 4;
                    _updateFab();
                  });
                },
                onBrowse: () {
                  setState(() {
                    _filterCollectionOnly = false;
                    _showHub = false;
                    _tabController.index = 4;
                    _updateFab();
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHubCard({
    required String title,
    required String description,
    required IconData icon,
    required int learned,
    required int total,
    required int due,
    required VoidCallback onContinue,
    required VoidCallback onBrowse,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = total == 0 ? 0.0 : (learned / total);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.gapMD,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$learned / $total learned', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              if (due > 0)
                Text('$due reviews due', style: const TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: AppRadius.radiusSM,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: isDark ? Colors.white10 : Colors.black12,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            ),
          ),
          AppSpacing.gapMD,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBrowse,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Browse Library'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch studyTabProvider to reactively update index if changed externally
    ref.listen<int>(studyTabProvider, (prev, next) {
      if (next >= 0 && next < 5 && next != _tabController.index) {
        _tabController.animateTo(next);
      }
    });

    final kanjiAsync = ref.watch(kanjiListProvider);
    final vocabAsync = ref.watch(vocabListProvider);
    final grammarAsync = ref.watch(grammarListProvider);
    final readingAsync = ref.watch(readingListProvider);
    final listeningAsync = ref.watch(listeningListProvider);

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (_showHub) {
      return _buildLearnHub(isDark, kanjiAsync, vocabAsync, grammarAsync, readingAsync, listeningAsync);
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: _selectionMode && _tabController.index == 0
            ? Text('${_selectedKanjiIds.length} Selected')
            : Text('${_filterCollectionOnly ? "My Collection" : "Master Library"} - ${_tabController.index == 0 ? "Kanji" : _tabController.index == 1 ? "Vocab" : _tabController.index == 2 ? "Grammar" : _tabController.index == 3 ? "Reading" : "Listening"}', style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: _selectionMode && _tabController.index == 0
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectionMode = false;
                    _selectedKanjiIds.clear();
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _showHub = true;
                    _updateFab();
                  });
                },
              ),
        actions: _selectionMode && _tabController.index == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.select_all),
                  tooltip: 'Select All',
                  onPressed: () {
                    final allKanjis = ref.read(kanjiListProvider).value ?? [];
                    setState(() {
                      _selectedKanjiIds.clear();
                      _selectedKanjiIds.addAll(allKanjis.map((k) => k.id));
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.done_all, color: Colors.green),
                  tooltip: 'Toggle Learned',
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final allKanjis = ref.read(kanjiListProvider).value ?? [];
                    final selectedKanjis = allKanjis.where((k) => _selectedKanjiIds.contains(k.id)).toList();
                    final anyUnlearned = selectedKanjis.any((k) => !k.isLearned);
                    final newStatus = anyUnlearned ? StudyStatus.mastered : StudyStatus.unlearned;

                    for (var id in _selectedKanjiIds) {
                      await ref.read(kanjiListProvider.notifier).updateStatus(id, newStatus);
                    }

                    setState(() {
                      _selectionMode = false;
                      _selectedKanjiIds.clear();
                    });

                    if (!mounted) return;
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Selected Kanji marked as ${anyUnlearned ? "Learned" : "Unlearned"}.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
                  tooltip: 'Delete Selected',
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return AlertDialog(
                          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                          title: const Text('Delete Selected?', style: TextStyle(fontWeight: FontWeight.bold)),
                          content: Text('Are you sure you want to delete ${_selectedKanjiIds.length} selected Kanji? This will clear all scheduling and review data associated with them.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete All', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm == true) {
                      for (var id in _selectedKanjiIds) {
                        await ref.read(kanjiListProvider.notifier).deleteKanji(id);
                      }
                      setState(() {
                        _selectionMode = false;
                        _selectedKanjiIds.clear();
                      });
                      if (!mounted) return;
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('Selected Kanji deleted.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                ),
              ]
            : null,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Kanji', icon: Icon(Icons.abc_rounded, size: 18)),
            Tab(text: 'Vocab', icon: Icon(Icons.translate, size: 18)),
            Tab(text: 'Grammar', icon: Icon(Icons.bookmark_outline, size: 18)),
            Tab(text: 'Reading', icon: Icon(Icons.menu_book, size: 18)),
            Tab(text: 'Listening', icon: Icon(Icons.headset, size: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search & Filter controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search catalog...',
                          prefixIcon: const Icon(Icons.search, size: 20),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () => _searchController.clear(),
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    if (_tabController.index == 0) ...[
                      const SizedBox(width: 10),
                      IconButton.filledTonal(
                        icon: Icon(
                          Icons.filter_list_rounded,
                          color: _hasActiveFilters() ? PremiumDesignSystem.primaryBlue : null,
                        ),
                        onPressed: _showSearchFiltersPanel,
                        tooltip: 'Filter & Sort Options',
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildFilterChip('All', null),
                      const SizedBox(width: 8),
                      _buildFilterChip('Unlearned', StudyStatus.unlearned),
                      const SizedBox(width: 8),
                      _buildFilterChip('Learning', StudyStatus.learning),
                      const SizedBox(width: 8),
                      _buildFilterChip('Mastered', StudyStatus.mastered),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Tab contents
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildKanjiTab(kanjiAsync),
                _buildVocabTab(vocabAsync),
                _buildGrammarTab(grammarAsync),
                _buildReadingTab(readingAsync),
                _buildListeningTab(listeningAsync),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? (ref.watch(adminModeProvider)
              ? FloatingActionButton.extended(
                  onPressed: () => context.push('/add_kanji'),
                  backgroundColor: PremiumDesignSystem.primaryBlue,
                  label: const Text('Add Master Kanji', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  icon: const Icon(Icons.add, color: Colors.white),
                )
              : FloatingActionButton.extended(
                  onPressed: _addSelectedToCollection,
                  backgroundColor: PremiumDesignSystem.primaryBlue,
                  label: const Text('Add to My Collection', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  icon: const Icon(Icons.bookmark_add, color: Colors.white),
                ))
          : null,
    );
  }

  void _addSelectedToCollection() async {
    final messenger = ScaffoldMessenger.of(context);
    if (_selectedKanjiIds.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Long-press any Kanji cards below to select and add them to your collection!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    int count = 0;
    for (var id in _selectedKanjiIds) {
      await ref.read(kanjiListProvider.notifier).addToCollection(id);
      count++;
    }

    setState(() {
      _selectionMode = false;
      _selectedKanjiIds.clear();
    });

    messenger.showSnackBar(
      SnackBar(
        content: Text('Added $count Kanji to My Collection!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _hasActiveFilters() {
    return _selectedJlptFilters.isNotEmpty ||
        _filterFavorite ||
        _filterLearned ||
        _filterUnlearned ||
        _filterRecentlyAdded ||
        _filterRecentlyReviewed ||
        _sortOption != 'Recently Added';
  }

  void _showSearchFiltersPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final sheetBgColor = isDark ? PremiumDesignSystem.surfaceDark : Colors.white;

            void updateFilter(VoidCallback cb) {
              setState(() {
                _kanjiLimit = 40;
                setSheetState(cb);
              });
            }

            Widget buildFilterChip(String label, int val) {
              final isSelected = _selectedJlptFilters.contains(val);
              return FilterChip(
                label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                selected: isSelected,
                onSelected: (selected) {
                  updateFilter(() {
                    if (selected) {
                      _selectedJlptFilters.add(val);
                    } else {
                      _selectedJlptFilters.remove(val);
                    }
                  });
                },
              );
            }

            Widget buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
              return CheckboxListTile(
                title: Text(label, style: const TextStyle(fontSize: 14)),
                value: value,
                onChanged: onChanged,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: sheetBgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white24 : Colors.black12,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter & Sort Kanji',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: _hasActiveFilters()
                              ? () {
                                  updateFilter(() {
                                    _selectedJlptFilters.clear();
                                    _filterFavorite = false;
                                    _filterLearned = false;
                                    _filterUnlearned = false;
                                    _filterRecentlyAdded = false;
                                    _filterRecentlyReviewed = false;
                                    _sortOption = 'Recently Added';
                                  });
                                }
                              : null,
                          child: const Text('Reset All'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 12),

                    // Sort By Section
                    const Text('Sort By', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['Recently Added', 'Alphabetically', 'Review Date', 'Stroke Count', 'JLPT'].map((opt) {
                        final isSelected = _sortOption == opt;
                        return ChoiceChip(
                          label: Text(opt, style: const TextStyle(fontSize: 12)),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              updateFilter(() {
                                _sortOption = opt;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // JLPT Section
                    const Text('JLPT Level', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildFilterChip('N1', 1),
                        buildFilterChip('N2', 2),
                        buildFilterChip('N3', 3),
                        buildFilterChip('N4', 4),
                        buildFilterChip('N5', 5),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Status Section
                    const Text('Status & Attributes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    buildCheckbox('Favorites Only', _filterFavorite, (val) {
                      updateFilter(() {
                        _filterFavorite = val ?? false;
                      });
                    }),
                    buildCheckbox('Learned Only', _filterLearned, (val) {
                      updateFilter(() {
                        _filterLearned = val ?? false;
                        if (_filterLearned) _filterUnlearned = false; // Mutually exclusive
                      });
                    }),
                    buildCheckbox('Not Learned Only', _filterUnlearned, (val) {
                      updateFilter(() {
                        _filterUnlearned = val ?? false;
                        if (_filterUnlearned) _filterLearned = false; // Mutually exclusive
                      });
                    }),
                    buildCheckbox('Recently Added (< 7 days)', _filterRecentlyAdded, (val) {
                      updateFilter(() {
                        _filterRecentlyAdded = val ?? false;
                      });
                    }),
                    buildCheckbox('Recently Reviewed (< 7 days)', _filterRecentlyReviewed, (val) {
                      updateFilter(() {
                        _filterRecentlyReviewed = val ?? false;
                      });
                    }),
                    const SizedBox(height: 24),

                    // Apply Button
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PremiumDesignSystem.primaryBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Apply Filters', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- FILTER CHIPS ---

  Widget _buildFilterChip(String label, StudyStatus? status) {
    final isSelected = _selectedStatusFilter == status;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: isSelected,
      onSelected: (val) {
        if (val) {
          setState(() {
            _selectedStatusFilter = status;
          });
        }
      },
      selectedColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
      labelStyle: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected
            ? PremiumDesignSystem.primaryBlue
            : (isDark ? Colors.white70 : Colors.black87),
      ),
      backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
    );
  }

  // --- RECONCILE CHECKABLE PROGRESS ---

  void _onStatusChange(String id, String category, StudyStatus newStatus) {
    if (category == 'kanji') {
      ref.read(kanjiListProvider.notifier).updateStatus(id, newStatus);
    } else if (category == 'vocab') {
      ref.read(vocabListProvider.notifier).updateStatus(id, newStatus);
    } else if (category == 'grammar') {
      ref.read(grammarListProvider.notifier).updateStatus(id, newStatus);
    } else if (category == 'reading') {
      ref.read(readingListProvider.notifier).updateStatus(id, newStatus);
    } else if (category == 'listening') {
      ref.read(listeningListProvider.notifier).updateStatus(id, newStatus);
    }

    if (newStatus == StudyStatus.mastered) {
      ref.read(dailyGoalProvider.notifier).addProgress(items: 1);
    }
  }

  // --- RESPONSIVE LIST HELPER ---

  Widget _buildResponsiveGrid<T>({
    required List<T> items,
    required Widget Function(T item) builder,
    required double maxCrossAxisExtent,
  }) {
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No items match search and filter criteria.'),
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      if (width < 650) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) => builder(items[index]),
        );
      } else {
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
            childAspectRatio: 1.8,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => builder(items[index]),
        );
      }
    });
  }

  // --- KANJI TAB ---

  Widget _buildKanjiTab(AsyncValue<List<KanjiEntity>> kanjiAsync) {
    return kanjiAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading Kanji')),
      data: (list) {
        if (list.isEmpty) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                // Glowing stack vector illustration
                Center(
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                PremiumDesignSystem.primaryBlue.withValues(alpha: 0.2),
                                PremiumDesignSystem.primaryBlue.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  PremiumDesignSystem.primaryBlue,
                                  PremiumDesignSystem.primaryBlue.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '漢',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Title
                const Text(
                  'Build Your Personal Kanji Library',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  'Start adding the kanji you want to study.\nYour collection grows with your learning journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 32),
                // Statistics row (Current Kanji: 0, Today's Reviews: 0, Learned: 0)
                Row(
                  children: [
                    Expanded(
                      child: _buildOnboardingStatCard(
                        title: 'Current Kanji',
                        value: '0',
                        icon: Icons.auto_stories_outlined,
                        color: PremiumDesignSystem.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOnboardingStatCard(
                        title: "Today's Reviews",
                        value: '0',
                        icon: Icons.rate_review_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOnboardingStatCard(
                        title: 'Learned',
                        value: '0',
                        icon: Icons.task_alt_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                // Large primary floating-like button
                ElevatedButton.icon(
                  onPressed: () => context.push('/add_kanji'),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Add First Kanji',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PremiumDesignSystem.primaryBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    shadowColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 12),
                // Secondary button
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You can import your database backups anytime from the Settings tab.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Import Later',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }

        final filteredList = list.where((k) {
          if (_filterCollectionOnly && !k.isAdded) return false;
          // 1. Advanced Search Query Matching (Kanji, Meaning, Kunyomi, Onyomi, Radicals, JLPT, Grade, Notes, Examples)
          bool matchesSearch = true;
          if (_searchQuery.isNotEmpty) {
            final query = _searchQuery.toLowerCase();
            final matchesKanji = k.character.contains(query);
            final matchesMeaning = k.meaning.toLowerCase().contains(query);
            final matchesOnyomi = k.onyomi.toLowerCase().contains(query);
            final matchesKunyomi = k.kunyomi.toLowerCase().contains(query);
            final matchesRadicals = k.radicals.toLowerCase().contains(query);
            final matchesJlpt = 'n${k.jlptLevel}'.contains(query) || k.jlptLevel.toString() == query;
            final matchesGrade = k.gradeLevel != null &&
                ('grade ${k.gradeLevel}'.contains(query) || k.gradeLevel.toString() == query);
            final matchesNotes = k.notes.toLowerCase().contains(query);
            final matchesExamples = k.examples.any((ex) => ex.toLowerCase().contains(query));

            matchesSearch = matchesKanji ||
                matchesMeaning ||
                matchesOnyomi ||
                matchesKunyomi ||
                matchesRadicals ||
                matchesJlpt ||
                matchesGrade ||
                matchesNotes ||
                matchesExamples;
          }

          // 2. Interactive Filters
          // JLPT Levels
          bool matchesJlptFilter = true;
          if (_selectedJlptFilters.isNotEmpty) {
            matchesJlptFilter = _selectedJlptFilters.contains(k.jlptLevel);
          }

          // Favorites
          bool matchesFavFilter = true;
          if (_filterFavorite) {
            matchesFavFilter = k.isFavorite;
          }

          // Learned
          bool matchesLearnedFilter = true;
          if (_filterLearned) {
            matchesLearnedFilter = k.isLearned;
          }

          // Not Learned
          bool matchesUnlearnedFilter = true;
          if (_filterUnlearned) {
            matchesUnlearnedFilter = !k.isLearned;
          }

          // Recently Added (created within last 7 days)
          bool matchesRecentAdd = true;
          if (_filterRecentlyAdded) {
            matchesRecentAdd = DateTime.now().difference(k.createdAt).inDays <= 7;
          }

          // Recently Reviewed (reviewed within last 7 days)
          bool matchesRecentReview = true;
          if (_filterRecentlyReviewed) {
            matchesRecentReview = k.lastReviewed != null &&
                DateTime.now().difference(k.lastReviewed!).inDays <= 7;
          }

          // Status bar chips (All, Unlearned, Learning, Mastered)
          final matchesStatusTab = _selectedStatusFilter == null || k.status == _selectedStatusFilter;

          return matchesSearch &&
              matchesJlptFilter &&
              matchesFavFilter &&
              matchesLearnedFilter &&
              matchesUnlearnedFilter &&
              matchesRecentAdd &&
              matchesRecentReview &&
              matchesStatusTab;
        }).toList();

        // 3. Sort options execution
        switch (_sortOption) {
          case 'Alphabetically':
            filteredList.sort((a, b) => a.meaning.toLowerCase().compareTo(b.meaning.toLowerCase()));
            break;
          case 'Recently Added':
            filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            break;
          case 'Review Date':
            filteredList.sort((a, b) {
              if (a.nextReview == null && b.nextReview == null) return 0;
              if (a.nextReview == null) return 1;
              if (b.nextReview == null) return -1;
              return a.nextReview!.compareTo(b.nextReview!);
            });
            break;
          case 'Stroke Count':
            filteredList.sort((a, b) => a.strokeCount.compareTo(b.strokeCount));
            break;
          case 'JLPT':
            filteredList.sort((a, b) => a.jlptLevel.compareTo(b.jlptLevel));
            break;
        }

        final filteredIds = filteredList.map((k) => k.id).toList();
        return _buildOptimizedKanjiGrid(filteredIds);
      },
    );
  }

  Widget _buildOptimizedKanjiGrid(List<String> ids) {
    if (ids.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No items match search and filter criteria.'),
        ),
      );
    }

    final visibleIds = ids.take(_kanjiLimit).toList();

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
          if (_kanjiLimit < ids.length) {
            setState(() {
              _kanjiLimit += 40;
            });
          }
        }
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          if (width < 650) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              itemCount: visibleIds.length,
              itemBuilder: (context, index) {
                final id = visibleIds[index];
                return Consumer(
                  key: ValueKey('kanji_item_list_$id'),
                  builder: (context, ref, child) {
                    final k = ref.watch(kanjiItemProvider(id));
                    if (k == null) return const SizedBox.shrink();
                    return _buildKanjiCard(k);
                  },
                );
              },
            );
          } else {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1.8,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
              ),
              itemCount: visibleIds.length,
              itemBuilder: (context, index) {
                final id = visibleIds[index];
                return Consumer(
                  key: ValueKey('kanji_item_grid_$id'),
                  builder: (context, ref, child) {
                    final k = ref.watch(kanjiItemProvider(id));
                    if (k == null) return const SizedBox.shrink();
                    return _buildKanjiCard(k);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildKanjiCard(KanjiEntity k) {
    final statusColor = _getStatusColor(k.status);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedKanjiIds.contains(k.id);

    // Calculate learning progress (5 reviews usually master a card in study planner)
    final double progress = (k.reviewCount / 5).clamp(0.0, 1.0);

    return Dismissible(
      key: Key('kanji_card_${k.id}_v2'),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (_selectionMode) return false;
        if (direction == DismissDirection.startToEnd) {
          // Swipe right -> Edit
          context.push('/add_kanji?id=${k.id}');
          return false;
        } else {
          // Swipe left -> Delete
          _confirmDeleteKanji(context, k);
          return false;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: isSelected ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? PremiumDesignSystem.primaryBlue
                  : (isDark ? Colors.white10 : Colors.black12),
              width: isSelected ? 2 : 1,
            ),
          ),
          color: isSelected
              ? (isDark ? const Color(0xFF1E1E38) : const Color(0xFFEEF2FF))
              : (isDark ? PremiumDesignSystem.surfaceDark : Colors.white),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _selectionMode
                ? () {
                    setState(() {
                      if (_selectedKanjiIds.contains(k.id)) {
                        _selectedKanjiIds.remove(k.id);
                        if (_selectedKanjiIds.isEmpty) {
                          _selectionMode = false;
                        }
                      } else {
                        _selectedKanjiIds.add(k.id);
                      }
                    });
                  }
                : () => context.push('/kanji_details?id=${k.id}'),
            onLongPress: () {
              setState(() {
                _selectionMode = true;
                if (!_selectedKanjiIds.contains(k.id)) {
                  _selectedKanjiIds.add(k.id);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large Kanji block
                  Hero(
                    tag: 'kanji_char_${k.id}',
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [statusColor.withValues(alpha: 0.2), statusColor.withValues(alpha: 0.05)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: statusColor.withValues(alpha: 0.4), width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        k.character,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Content Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Meaning & Actions Row
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                k.meaning,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: -0.2),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_selectionMode)
                              Checkbox(
                                value: isSelected,
                                onChanged: (val) {
                                  setState(() {
                                    if (val == true) {
                                      if (!_selectedKanjiIds.contains(k.id)) {
                                        _selectedKanjiIds.add(k.id);
                                      }
                                    } else {
                                      _selectedKanjiIds.remove(k.id);
                                      if (_selectedKanjiIds.isEmpty) {
                                        _selectionMode = false;
                                      }
                                    }
                                  });
                                },
                              )
                            else ...[
                              // Star Toggle
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                icon: Icon(
                                  k.isFavorite ? Icons.star : Icons.star_border,
                                  color: k.isFavorite ? PremiumDesignSystem.amberGold : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () {
                                  ref.read(kanjiListProvider.notifier).toggleFavorite(k.id);
                                },
                              ),
                              // Checkmark Toggle
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                icon: Icon(
                                  k.isLearned ? Icons.check_circle : Icons.check_circle_outline,
                                  color: k.isLearned ? PremiumDesignSystem.forestEmerald : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () {
                                  final newStatus = k.isLearned ? StudyStatus.unlearned : StudyStatus.mastered;
                                  ref.read(kanjiListProvider.notifier).updateStatus(k.id, newStatus);
                                },
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Badges Row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'N${k.jlptLevel}',
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue),
                              ),
                            ),
                            if (k.gradeLevel != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  k.gradeLevel == 7 ? 'J. High' : 'G${k.gradeLevel}',
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange),
                                ),
                              ),
                            ],
                            if (k.radicals != '-') ...[
                              const SizedBox(width: 6),
                              Text(
                                'Radical: ${k.radicals}',
                                style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Onyomi & Kunyomi info
                        Text(
                          'On: ${k.onyomi}',
                          style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Kun: ${k.kunyomi}',
                          style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        // Progress Indicator
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: isDark ? Colors.white10 : Colors.black12,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    k.isLearned ? PremiumDesignSystem.forestEmerald : PremiumDesignSystem.primaryBlue,
                                  ),
                                  minHeight: 4,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(progress * 100).toInt()}%',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  // --- VOCAB TAB ---

  Widget _buildVocabTab(AsyncValue<List<VocabularyEntity>> vocabAsync) {
    return vocabAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading Vocabulary')),
      data: (list) {
        final filteredList = list.where((v) {
          if (_filterCollectionOnly && v.status == StudyStatus.unlearned) return false;
          final matchesSearch = v.word.contains(_searchQuery) ||
              v.reading.toLowerCase().contains(_searchQuery) ||
              v.meaning.toLowerCase().contains(_searchQuery);
          final matchesFilter = _selectedStatusFilter == null || v.status == _selectedStatusFilter;
          return matchesSearch && matchesFilter;
        }).toList();

        return _buildResponsiveGrid(
          items: filteredList,
          maxCrossAxisExtent: 340,
          builder: (v) => _buildVocabCard(v),
        );
      },
    );
  }

  Widget _buildVocabCard(VocabularyEntity v) {
    final statusColor = _getStatusColor(v.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        v.word,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.3),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          v.status.name.toUpperCase(),
                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: statusColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    v.reading,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    v.meaning,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _buildCheckableButton(v.id, 'vocab', v.status),
          ],
        ),
      ),
    );
  }

  // --- GRAMMAR TAB ---

  Widget _buildGrammarTab(AsyncValue<List<GrammarEntity>> grammarAsync) {
    return grammarAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading Grammar')),
      data: (list) {
        final filteredList = list.where((g) {
          if (_filterCollectionOnly && g.status == StudyStatus.unlearned) return false;
          final matchesSearch = g.title.toLowerCase().contains(_searchQuery) ||
              g.explanation.toLowerCase().contains(_searchQuery) ||
              g.structure.toLowerCase().contains(_searchQuery);
          final matchesFilter = _selectedStatusFilter == null || g.status == _selectedStatusFilter;
          return matchesSearch && matchesFilter;
        }).toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          itemCount: filteredList.length,
          itemBuilder: (context, index) => _buildGrammarCard(filteredList[index]),
        );
      },
    );
  }

  Widget _buildGrammarCard(GrammarEntity g) {
    final statusColor = _getStatusColor(g.status);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              g.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.3),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                g.explanation,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                width: 5,
                height: 28,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCheckableButton(g.id, 'grammar', g.status),
                  const SizedBox(width: 8),
                  const Icon(Icons.expand_more, size: 20),
                ],
              ),
            ),
            childrenPadding: const EdgeInsets.all(18.0),
            expandedAlignment: Alignment.topLeft,
            children: [
              Text(
                'Structure:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.5) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  g.structure,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Explanation:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 4),
              Text(g.explanation, style: const TextStyle(fontSize: 13.5, height: 1.4)),
              const SizedBox(height: 16),
              ...g.examples.map((ex) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ex.japanese,
                          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Colors.teal),
                        ),
                        Text(
                          ex.english,
                          style: TextStyle(fontSize: 11.5, color: Theme.of(context).colorScheme.outline),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // --- READING TAB ---

  Widget _buildReadingTab(AsyncValue<List<ReadingEntity>> readingAsync) {
    return readingAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading Readings')),
      data: (list) {
        final filteredList = list.where((r) {
          if (_filterCollectionOnly && r.status == StudyStatus.unlearned) return false;
          final matchesSearch = r.title.toLowerCase().contains(_searchQuery) ||
              r.passage.toLowerCase().contains(_searchQuery) ||
              r.question.toLowerCase().contains(_searchQuery);
          final matchesFilter = _selectedStatusFilter == null || r.status == _selectedStatusFilter;
          return matchesSearch && matchesFilter;
        }).toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          itemCount: filteredList.length,
          itemBuilder: (context, index) => _buildReadingCard(filteredList[index]),
        );
      },
    );
  }

  Widget _buildReadingCard(ReadingEntity r) {
    final statusColor = _getStatusColor(r.status);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              r.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.3),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Reading Lesson: ${r.passage.substring(0, min(r.passage.length, 30))}...',
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                width: 5,
                height: 28,
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(3)),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCheckableButton(r.id, 'reading', r.status),
                  const SizedBox(width: 8),
                  const Icon(Icons.expand_more, size: 20),
                ],
              ),
            ),
            childrenPadding: const EdgeInsets.all(18.0),
            expandedAlignment: Alignment.topLeft,
            children: [
              Text(
                'Passage (読解文):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.5) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  r.passage,
                  style: const TextStyle(fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Question (問い):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 4),
              Text(r.question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // Reveal answer button
              _buildRevealAnswerPanel(r.answer, r.explanation),
              const SizedBox(height: 18),
              // Notes area
              _buildNotesTextEditor(r.id, 'reading', r.notes),
            ],
          ),
        ),
      ),
    );
  }

  // --- LISTENING TAB ---

  Widget _buildListeningTab(AsyncValue<List<ListeningEntity>> listeningAsync) {
    return listeningAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading Listenings')),
      data: (list) {
        final filteredList = list.where((l) {
          if (_filterCollectionOnly && l.status == StudyStatus.unlearned) return false;
          final matchesSearch = l.title.toLowerCase().contains(_searchQuery) ||
              l.audioScript.toLowerCase().contains(_searchQuery) ||
              l.question.toLowerCase().contains(_searchQuery);
          final matchesFilter = _selectedStatusFilter == null || l.status == _selectedStatusFilter;
          return matchesSearch && matchesFilter;
        }).toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          itemCount: filteredList.length,
          itemBuilder: (context, index) => _buildListeningCard(filteredList[index]),
        );
      },
    );
  }

  Widget _buildListeningCard(ListeningEntity l) {
    final statusColor = _getStatusColor(l.status);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              l.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.3),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Listening practice with transcripts',
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                width: 5,
                height: 28,
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(3)),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCheckableButton(l.id, 'listening', l.status),
                  const SizedBox(width: 8),
                  const Icon(Icons.expand_more, size: 20),
                ],
              ),
            ),
            childrenPadding: const EdgeInsets.all(18.0),
            expandedAlignment: Alignment.topLeft,
            children: [
              // Audio script transcript
              Text(
                'Audio Script Transcript (台本):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.5) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  l.audioScript,
                  style: const TextStyle(fontSize: 13.5, height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Question (問い):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 4),
              Text(l.question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // Reveal answer panel
              _buildRevealAnswerPanel(l.answer, l.explanation),
              const SizedBox(height: 18),
              // Notes editor
              _buildNotesTextEditor(l.id, 'listening', l.notes),
            ],
          ),
        ),
      ),
    );
  }

  // --- REVEAL ANSWER WIDGET ---

  Widget _buildRevealAnswerPanel(String answer, String explanation) {
    return StateProviderWidget(
      builder: (context, ref, isRevealed, setRevealed) {
        if (!isRevealed) {
          return ElevatedButton.icon(
            onPressed: () => setRevealed(true),
            icon: const Icon(Icons.help_outline, size: 16),
            label: const Text('Show Answer & Explanation'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Correct Answer: $answer',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Explanation: $explanation',
                style: const TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- NOTION NOTES TEXT EDITOR ---

  Widget _buildNotesTextEditor(String id, String category, String initialNotes) {
    return NotesFieldWidget(
      initialText: initialNotes,
      onSave: (notes) {
        if (category == 'reading') {
          ref.read(readingListProvider.notifier).saveNotes(id, notes);
        } else if (category == 'listening') {
          ref.read(listeningListProvider.notifier).saveNotes(id, notes);
        }
      },
    );
  }

  // --- CHECKABLE / STATUS SELECTOR BUTTON ---

  Widget _buildCheckableButton(String id, String category, StudyStatus currentStatus) {
    return InkWell(
      onTap: () => _showStatusPickerSheet(id, category, currentStatus),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(
          currentStatus == StudyStatus.mastered
              ? Icons.check_box
              : currentStatus == StudyStatus.learning
                  ? Icons.indeterminate_check_box
                  : Icons.check_box_outline_blank,
          color: _getStatusColor(currentStatus),
          size: 26,
        ),
      ),
    );
  }

  void _showStatusPickerSheet(String id, String category, StudyStatus currentStatus) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Set Study Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildStatusOption(context, id, category, StudyStatus.unlearned, 'Unlearned',
                  'Item is currently locked or waiting in queue.', Icons.check_box_outline_blank, Colors.grey),
              const SizedBox(height: 10),
              _buildStatusOption(context, id, category, StudyStatus.learning, 'Learning',
                  'Actively reviewing this item in flashcards and quizzes.', Icons.indeterminate_check_box, Colors.orange),
              const SizedBox(height: 10),
              _buildStatusOption(context, id, category, StudyStatus.mastered, 'Mastered',
                  'Completed! Item counts towards your daily progress and overall completion.', Icons.check_box, Colors.green),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusOption(
    BuildContext context,
    String id,
    String category,
    StudyStatus status,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _onStatusChange(id, category, status);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(StudyStatus status) {
    switch (status) {
      case StudyStatus.mastered:
        return Colors.green;
      case StudyStatus.learning:
        return Colors.orange;
      case StudyStatus.unlearned:
        return Theme.of(context).colorScheme.outline;
    }
  }



  void _confirmDeleteKanji(BuildContext context, KanjiEntity k) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          title: const Text('Delete Kanji?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete "${k.character}"? This will also remove any active review sessions and calendar tasks for this Kanji.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                ref.read(kanjiListProvider.notifier).deleteKanji(k.id);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${k.character}" deleted.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}

// --- STATE MANAGEMENT HELPER FOR ANSWER REVEAL ---

class StateProviderWidget extends StatefulWidget {
  final Widget Function(BuildContext context, StateSetter setState, bool state, ValueChanged<bool> onChanged) builder;

  const StateProviderWidget({super.key, required this.builder});

  @override
  State<StateProviderWidget> createState() => _StateProviderWidgetState();
}

class _StateProviderWidgetState extends State<StateProviderWidget> {
  bool _state = false;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState, _state, (val) {
      setState(() {
        _state = val;
      });
    });
  }
}

// --- STATEFUL NOTES FIELD WIDGET FOR PERFORMANCE IN LISTS ---

class NotesFieldWidget extends StatefulWidget {
  final String initialText;
  final ValueChanged<String> onSave;

  const NotesFieldWidget({super.key, required this.initialText, required this.onSave});

  @override
  State<NotesFieldWidget> createState() => _NotesFieldWidgetState();
}

class _NotesFieldWidgetState extends State<NotesFieldWidget> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Notion Notes:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
            ),
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit, size: 16),
                onPressed: () => setState(() => _isEditing = true),
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined, size: 16, color: Colors.red),
                    onPressed: () {
                      _controller.text = widget.initialText;
                      setState(() => _isEditing = false);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                    onPressed: () {
                      widget.onSave(_controller.text);
                      setState(() => _isEditing = false);
                    },
                  ),
                ],
              )
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? Colors.black12 : Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isEditing ? PremiumDesignSystem.primaryBlue : Colors.transparent,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: _isEditing
              ? TextField(
                  controller: _controller,
                  maxLines: null,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: const InputDecoration(
                    hintText: 'Add your study notes here...',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                )
              : Text(
                  _controller.text.isEmpty ? 'No notes added yet. Tap edit to write notes.' : _controller.text,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontStyle: _controller.text.isEmpty ? FontStyle.italic : FontStyle.normal,
                    color: _controller.text.isEmpty ? Colors.grey : null,
                  ),
                ),
        ),
      ],
    );
  }
}
