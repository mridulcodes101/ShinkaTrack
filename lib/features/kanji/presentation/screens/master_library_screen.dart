import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/kanji/application/kanji_notifier.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/kanji/presentation/widgets/kanji_card.dart';
import 'package:shinka_track_n3/features/kanji/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/kanji/presentation/widgets/empty_state.dart';

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
    
    // Synchronize initial query if any
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = ref.read(libQueryProvider);
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
      ref.read(libraryNotifierProvider.notifier).loadNextPage();
    }
  }

  void _showFilters() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FilterDialog(
        initialJlpt: ref.read(libJlptFilterProvider),
        initialGrade: ref.read(libGradeFilterProvider),
        initialStrokeBucket: ref.read(libStrokesFilterProvider),
        initialIsAdded: ref.read(libIsAddedFilterProvider),
      ),
    );

    if (result != null) {
      ref.read(libJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(libGradeFilterProvider.notifier).state = result['grade'] as List<int>;
      ref.read(libStrokesFilterProvider.notifier).state = result['strokeBucket'] as String?;
      ref.read(libIsAddedFilterProvider.notifier).state = result['isAdded'] as bool?;
    }
  }

  void _toggleSort() {
    final current = ref.read(libSortProvider);
    final options = ['Kanji', 'Meaning', 'JLPT', 'Stroke Count', 'Date Added'];
    final nextIndex = (options.indexOf(current) + 1) % options.length;
    ref.read(libSortProvider.notifier).state = options[nextIndex];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorted by: ${options[nextIndex]}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(libraryNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kanji Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Browse and build your collection.',
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
          // Developer mode shortcut
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings, color: Colors.amber),
              tooltip: 'Developer CMS Portal',
              onPressed: () => context.push('/admin'),
            ),
          
          // Toggle List/Grid View
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: _isGridView ? 'Switch to List' : 'Switch to Grid',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          
          // Sort trigger
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Change Sort Option',
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header block
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by character, onyomi, kunyomi...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(libQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(libQueryProvider.notifier).state = val.trim();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                
                // Advanced filters button
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

          // Active filter badges indicator row
          _buildActiveFiltersIndicator(),

          // Main list content
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                    ? KanjiEmptyState(
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
    final jlpt = ref.watch(libJlptFilterProvider);
    final grade = ref.watch(libGradeFilterProvider);
    final strokes = ref.watch(libStrokesFilterProvider);
    final isAdded = ref.watch(libIsAddedFilterProvider);

    final hasFilters = jlpt.isNotEmpty || grade.isNotEmpty || strokes != null || isAdded != null;
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
              ref.read(libJlptFilterProvider.notifier).state = jlpt.where((l) => l != lvl).toList();
            })),
          if (grade.isNotEmpty)
            ...grade.map((grd) => _buildFilterIndicatorChip('Grade $grd', () {
              ref.read(libGradeFilterProvider.notifier).state = grade.where((g) => g != grd).toList();
            })),
          if (strokes != null)
            _buildFilterIndicatorChip('Strokes: $strokes', () {
              ref.read(libStrokesFilterProvider.notifier).state = null;
            }),
          if (isAdded != null)
            _buildFilterIndicatorChip(isAdded ? 'Added' : 'Not Added', () {
              ref.read(libIsAddedFilterProvider.notifier).state = null;
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

  Widget _buildLibraryContent(LibraryState state) {
    if (_isGridView) {
      return GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final item = state.items[index];
          return _buildGridCard(item);
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
        return KanjiCard(
          kanji: item,
          onAddPressed: () {
            ref.read(libraryNotifierProvider.notifier).toggleAdded(item.spec.id, true);
          },
          onViewDetailsPressed: () {
            context.push('/kanji_details?id=${item.spec.id}');
          },
        );
      },
    );
  }

  Widget _buildGridCard(KanjiModel item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => context.push('/kanji_details?id=${item.spec.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.isAdded 
                ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3) 
                : Colors.black.withValues(alpha: 0.05),
            width: item.isAdded ? 1.5 : 1.0,
          ),
          boxShadow: PremiumDesignSystem.premiumShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.spec.character,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                item.spec.meaning,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('N${item.spec.jlptLevel}', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue)),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    item.isAdded ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: item.isAdded ? Colors.green : Colors.grey,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
