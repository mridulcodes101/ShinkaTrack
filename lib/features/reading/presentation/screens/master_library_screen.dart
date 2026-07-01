import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/reading/application/reading_notifier.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/reading_card.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/empty_state.dart';

class MasterLibraryScreen extends ConsumerStatefulWidget {
  const MasterLibraryScreen({super.key});

  @override
  ConsumerState<MasterLibraryScreen> createState() => _MasterLibraryScreenState();
}

class _MasterLibraryScreenState extends ConsumerState<MasterLibraryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = ref.read(readingQueryProvider);
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
      ref.read(readingLibraryNotifierProvider.notifier).loadNextPage();
    }
  }

  void _showFilters() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ReadingFilterDialog(
        initialJlpt: ref.read(readingJlptFilterProvider),
        initialDifficulty: ref.read(readingDifficultyFilterProvider),
        initialTime: ref.read(readingTimeFilterProvider),
        initialBookmarked: ref.read(readingBookmarkedFilterProvider),
        initialStatus: null,
      ),
    );

    if (result != null) {
      ref.read(readingJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(readingDifficultyFilterProvider.notifier).state = result['difficulty'] as String?;
      ref.read(readingTimeFilterProvider.notifier).state = result['time'] as String?;
      ref.read(readingBookmarkedFilterProvider.notifier).state = result['bookmarked'] as bool?;
    }
  }

  void _toggleSort() {
    final current = ref.read(readingSortProvider);
    final options = ['Newest', 'JLPT', 'Reading Time', 'Difficulty'];
    final nextIndex = (options.indexOf(current) + 1) % options.length;
    ref.read(readingSortProvider.notifier).state = options[nextIndex];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorted by: ${options[nextIndex]}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readingLibraryNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reading Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Improve your reading comprehension.',
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
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: _isGridView ? 'Switch to List View' : 'Switch to Grid View',
            onPressed: () {
              setState(() => _isGridView = !_isGridView);
            },
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
                      hintText: 'Search title, difficulty...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(readingQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(readingQueryProvider.notifier).state = val.trim();
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

          // Active filter chips
          _buildActiveFiltersIndicator(),

          // Passage List
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                    ? const ReadingEmptyState(
                        isUserCollection: false,
                        onActionButtonPressed: null,
                      )
                    : _buildLibraryContent(state),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFiltersIndicator() {
    final jlpt = ref.watch(readingJlptFilterProvider);
    final difficulty = ref.watch(readingDifficultyFilterProvider);
    final time = ref.watch(readingTimeFilterProvider);
    final bookmarked = ref.watch(readingBookmarkedFilterProvider);

    final hasFilters = jlpt.isNotEmpty || difficulty != null || time != null || bookmarked != null;
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
              ref.read(readingJlptFilterProvider.notifier).state = jlpt.where((l) => l != lvl).toList();
            })),
          if (difficulty != null)
            _buildFilterIndicatorChip('Difficulty: $difficulty', () {
              ref.read(readingDifficultyFilterProvider.notifier).state = null;
            }),
          if (time != null)
            _buildFilterIndicatorChip('Time: $time', () {
              ref.read(readingTimeFilterProvider.notifier).state = null;
            }),
          if (bookmarked != null)
            _buildFilterIndicatorChip('Bookmarked', () {
              ref.read(readingBookmarkedFilterProvider.notifier).state = null;
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

  Widget _buildLibraryContent(ReadingLibraryState state) {
    if (_isGridView) {
      return GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final item = state.items[index];
          return ReadingCard(
            reading: item,
            onBookmarkPressed: () {
              ref.read(readingLibraryNotifierProvider.notifier).toggleBookmark(item.spec.id, !item.isFavorite);
            },
            onReadPressed: () {
              context.push('/reading_mode?id=${item.spec.id}');
            },
          );
        },
      );
    }

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
        return ReadingCard(
          reading: item,
          onBookmarkPressed: () {
            ref.read(readingLibraryNotifierProvider.notifier).toggleBookmark(item.spec.id, !item.isFavorite);
          },
          onReadPressed: () {
            context.push('/reading_mode?id=${item.spec.id}');
          },
        );
      },
    );
  }
}
