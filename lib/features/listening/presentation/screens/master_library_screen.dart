import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/listening/application/listening_notifier.dart';
import 'package:shinka_track_n3/features/listening/presentation/widgets/listening_card.dart';
import 'package:shinka_track_n3/features/listening/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/listening/presentation/widgets/empty_state.dart';

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
      _searchController.text = ref.read(listeningQueryProvider);
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
      ref.read(listeningLibraryNotifierProvider.notifier).loadNextPage();
    }
  }

  void _showFilters() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ListeningFilterDialog(
        initialJlpt: ref.read(listeningJlptFilterProvider),
        initialDifficulty: ref.read(listeningDifficultyFilterProvider),
        initialDuration: ref.read(listeningDurationFilterProvider),
        initialBookmarked: ref.read(listeningBookmarkedFilterProvider),
        initialStatus: null,
      ),
    );

    if (result != null) {
      ref.read(listeningJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(listeningDifficultyFilterProvider.notifier).state = result['difficulty'] as String?;
      ref.read(listeningDurationFilterProvider.notifier).state = result['duration'] as String?;
      ref.read(listeningBookmarkedFilterProvider.notifier).state = result['bookmarked'] as bool?;
    }
  }

  void _toggleSort() {
    final current = ref.read(listeningSortProvider);
    final options = ['Newest', 'Difficulty', 'Duration'];
    final nextIndex = (options.indexOf(current) + 1) % options.length;
    ref.read(listeningSortProvider.notifier).state = options[nextIndex];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorted by: ${options[nextIndex]}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listeningLibraryNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Listening Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Improve your Japanese listening skills.',
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
                      hintText: 'Search listening lessons...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(listeningQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(listeningQueryProvider.notifier).state = val.trim();
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

          // Lesson List
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                    ? const ListeningEmptyState(
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
    final jlpt = ref.watch(listeningJlptFilterProvider);
    final difficulty = ref.watch(listeningDifficultyFilterProvider);
    final duration = ref.watch(listeningDurationFilterProvider);
    final bookmarked = ref.watch(listeningBookmarkedFilterProvider);

    final hasFilters = jlpt.isNotEmpty || difficulty != null || duration != null || bookmarked != null;
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
              ref.read(listeningJlptFilterProvider.notifier).state = jlpt.where((l) => l != lvl).toList();
            })),
          if (difficulty != null)
            _buildFilterIndicatorChip('Difficulty: $difficulty', () {
              ref.read(listeningDifficultyFilterProvider.notifier).state = null;
            }),
          if (duration != null)
            _buildFilterIndicatorChip('Duration: $duration', () {
              ref.read(listeningDurationFilterProvider.notifier).state = null;
            }),
          if (bookmarked != null)
            _buildFilterIndicatorChip('Bookmarked', () {
              ref.read(listeningBookmarkedFilterProvider.notifier).state = null;
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

  Widget _buildLibraryContent(ListeningLibraryState state) {
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
          return ListeningCard(
            listening: item,
            onBookmarkPressed: () {
              ref.read(listeningLibraryNotifierProvider.notifier).toggleBookmark(item.spec.id, !item.isFavorite);
            },
            onPlayPressed: () {
              context.push('/listening_player?id=${item.spec.id}');
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
        return ListeningCard(
          listening: item,
          onBookmarkPressed: () {
            ref.read(listeningLibraryNotifierProvider.notifier).toggleBookmark(item.spec.id, !item.isFavorite);
          },
          onPlayPressed: () {
            context.push('/listening_player?id=${item.spec.id}');
          },
        );
      },
    );
  }
}
