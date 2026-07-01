import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/grammar/application/grammar_notifier.dart';
import 'package:shinka_track_n3/features/grammar/presentation/widgets/grammar_card.dart';
import 'package:shinka_track_n3/features/grammar/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/grammar/presentation/widgets/empty_state.dart';

class MasterLibraryScreen extends ConsumerStatefulWidget {
  const MasterLibraryScreen({super.key});

  @override
  ConsumerState<MasterLibraryScreen> createState() => _MasterLibraryScreenState();
}

class _MasterLibraryScreenState extends ConsumerState<MasterLibraryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = ref.read(grammarQueryProvider);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
      ref.read(grammarLibraryNotifierProvider.notifier).loadNextPage();
    }
  }

  void _showFilters() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => GrammarFilterDialog(
        initialJlpt: ref.read(grammarJlptFilterProvider),
        initialDifficulty: ref.read(grammarDifficultyFilterProvider),
        initialIsAdded: ref.read(grammarIsAddedFilterProvider),
        initialStatus: null,
      ),
    );

    if (result != null) {
      ref.read(grammarJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(grammarDifficultyFilterProvider.notifier).state = result['difficulty'] as String?;
      ref.read(grammarIsAddedFilterProvider.notifier).state = result['isAdded'] as bool?;
    }
  }

  void _toggleSort() {
    final current = ref.read(grammarSortProvider);
    final options = ['Alphabetical', 'JLPT', 'Difficulty', 'Recently Added'];
    final nextIndex = (options.indexOf(current) + 1) % options.length;
    ref.read(grammarSortProvider.notifier).state = options[nextIndex];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorted by: ${options[nextIndex]}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(grammarLibraryNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grammar Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Master Japanese grammar step by step.',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings, color: Colors.amber),
              tooltip: 'Developer CMS Portal',
              onPressed: () => context.push('/admin'),
            ),
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Change Sort Option',
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search grammar patterns, meanings...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(grammarQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(grammarQueryProvider.notifier).state = val.trim();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                      foregroundColor: PremiumDesignSystem.primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _showFilters,
                    child: const Icon(Icons.filter_list),
                  ),
                ),
              ],
            ),
          ),

          // Active filters
          _buildActiveFiltersIndicator(),

          // List
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                    ? const GrammarEmptyState(
                        isUserCollection: false,
                        onActionButtonPressed: null,
                      )
                    : _buildLibraryList(state),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFiltersIndicator() {
    final jlpt = ref.watch(grammarJlptFilterProvider);
    final difficulty = ref.watch(grammarDifficultyFilterProvider);
    final isAdded = ref.watch(grammarIsAddedFilterProvider);

    final hasFilters = jlpt.isNotEmpty || difficulty != null || isAdded != null;
    if (!hasFilters) return const SizedBox.shrink();

    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          if (jlpt.isNotEmpty)
            ...jlpt.map((lvl) => _buildFilterIndicatorChip('JLPT N$lvl', () {
              ref.read(grammarJlptFilterProvider.notifier).state = jlpt.where((l) => l != lvl).toList();
            })),
          if (difficulty != null)
            _buildFilterIndicatorChip('Difficulty: $difficulty', () {
              ref.read(grammarDifficultyFilterProvider.notifier).state = null;
            }),
          if (isAdded != null)
            _buildFilterIndicatorChip(isAdded ? 'Added' : 'Not Added', () {
              ref.read(grammarIsAddedFilterProvider.notifier).state = null;
            }),
        ],
      ),
    );
  }

  Widget _buildFilterIndicatorChip(String label, VoidCallback onDelete) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        deleteIcon: const Icon(Icons.close, size: 14),
        onDeleted: onDelete,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildLibraryList(GrammarLibraryState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: state.items.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.items.length) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ));
        }
        final item = state.items[index];
        return GrammarCard(
          grammar: item,
          onAddPressed: () {
            ref.read(grammarLibraryNotifierProvider.notifier).toggleAdded(item.spec.id, true);
          },
          onViewLessonPressed: () {
            context.push('/grammar_details?id=${item.spec.id}');
          },
        );
      },
    );
  }
}
