import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });

    // Synchronize initial tab from studyTabProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialTab = ref.read(studyTabProvider);
      if (initialTab >= 0 && initialTab < 5) {
        _tabController.index = initialTab;
      }
    });

    _tabController.addListener(() {
      if (!mounted) return;
      setState(() {});
      if (!_tabController.indexIsChanging) {
        ref.read(studyTabProvider.notifier).state = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
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

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Study Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
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
                TextField(
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
          ? FloatingActionButton.extended(
              onPressed: () => _showAddKanjiDialog(context),
              backgroundColor: PremiumDesignSystem.primaryBlue,
              label: const Text('Add Kanji', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              icon: const Icon(Icons.add, color: Colors.white),
            )
          : null,
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
                  onPressed: () => _showAddKanjiDialog(context),
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
          final matchesSearch = k.character.contains(_searchQuery) ||
              k.onyomi.toLowerCase().contains(_searchQuery) ||
              k.kunyomi.toLowerCase().contains(_searchQuery) ||
              k.meaning.toLowerCase().contains(_searchQuery);
          final matchesFilter = _selectedStatusFilter == null || k.status == _selectedStatusFilter;
          return matchesSearch && matchesFilter;
        }).toList();

        return _buildResponsiveGrid(
          items: filteredList,
          maxCrossAxisExtent: 300,
          builder: (k) => _buildKanjiCard(k),
        );
      },
    );
  }

  Widget _buildKanjiCard(KanjiEntity k) {
    final statusColor = _getStatusColor(k.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [statusColor.withValues(alpha: 0.2), statusColor.withValues(alpha: 0.05)],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: statusColor.withValues(alpha: 0.4), width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                k.character,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    k.meaning,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: -0.2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'On: ${k.onyomi}',
                    style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                  ),
                  Text(
                    'Kun: ${k.kunyomi}',
                    style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCheckableButton(k.id, 'kanji', k.status),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                  onPressed: () => _confirmDeleteKanji(context, k),
                  tooltip: 'Delete Kanji',
                ),
              ],
            ),
          ],
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

  void _showAddKanjiDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String character = '';
    String meaning = '';
    String onyomi = '';
    String kunyomi = '';
    String radicals = '';
    int strokeCount = 0;
    int jlptLevel = 3;
    String unicode = '';

    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.add_card, color: PremiumDesignSystem.primaryBlue),
              SizedBox(width: 10),
              Text('Add Custom Kanji', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    maxLength: 3,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: 'Kanji Character *',
                      hintText: 'e.g. 愛',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Character is required';
                      }
                      return null;
                    },
                    onSaved: (val) => character = val!.trim(),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Meaning *',
                      hintText: 'e.g. Love, affection',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Meaning is required';
                      }
                      return null;
                    },
                    onSaved: (val) => meaning = val!.trim(),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Onyomi (Chinese reading)',
                      hintText: 'e.g. アイ (comma-separated)',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => onyomi = val?.trim() ?? '',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Kunyomi (Japanese reading)',
                      hintText: 'e.g. いと.しい (comma-separated)',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => kunyomi = val?.trim() ?? '',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Radicals',
                      hintText: 'e.g. 心 (heart)',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => radicals = val?.trim() ?? '',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stroke Count *',
                      hintText: 'e.g. 13',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Stroke count is required';
                      }
                      if (int.tryParse(val.trim()) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (val) => strokeCount = int.parse(val!.trim()),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: 3,
                    decoration: const InputDecoration(
                      labelText: 'JLPT Level',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 5, child: Text('N5')),
                      DropdownMenuItem(value: 4, child: Text('N4')),
                      DropdownMenuItem(value: 3, child: Text('N3')),
                      DropdownMenuItem(value: 2, child: Text('N2')),
                      DropdownMenuItem(value: 1, child: Text('N1')),
                    ],
                    onChanged: (val) {
                      if (val != null) jlptLevel = val;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Unicode',
                      hintText: 'e.g. U+611B',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => unicode = val?.trim() ?? '',
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  final onyomiList = onyomi.split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();
                  final kunyomiList = kunyomi.split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();

                  final newKanji = KanjiEntity(
                    id: 'custom_kanji_${DateTime.now().millisecondsSinceEpoch}',
                    kanji: character,
                    kunYomi: kunyomiList,
                    onYomi: onyomiList,
                    meaning: meaning,
                    radicals: radicals.isEmpty ? '-' : radicals,
                    strokeCount: strokeCount,
                    strokeOrderDiagramPath: null,
                    jlptLevel: jlptLevel,
                    gradeLevel: null,
                    unicode: unicode.isEmpty ? '-' : unicode,
                    notes: '',
                    examples: const [],
                    isLearned: false,
                    isFavorite: false,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    reviewCount: 0,
                    easeFactor: 2.5,
                  );
                  ref.read(kanjiListProvider.notifier).addKanji(newKanji);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"$character" added to your library!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
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
