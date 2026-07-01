import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/vocabulary/application/vocabulary_notifier.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';
import 'package:shinka_track_n3/features/vocabulary/presentation/widgets/vocabulary_card.dart';
import 'package:shinka_track_n3/features/vocabulary/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/vocabulary/presentation/widgets/empty_state.dart';

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
      _searchController.text = ref.read(vocabQueryProvider);
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
      ref.read(vocabLibraryNotifierProvider.notifier).loadNextPage();
    }
  }

  void _showFilters() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => VocabularyFilterDialog(
        initialJlpt: ref.read(vocabJlptFilterProvider),
        initialPos: ref.read(vocabPosFilterProvider),
        initialIsAdded: ref.read(vocabIsAddedFilterProvider),
        initialStatus: null,
      ),
    );

    if (result != null) {
      ref.read(vocabJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(vocabPosFilterProvider.notifier).state = result['pos'] as List<String>;
      ref.read(vocabIsAddedFilterProvider.notifier).state = result['isAdded'] as bool?;
    }
  }

  void _toggleSort() {
    final current = ref.read(vocabSortProvider);
    final options = ['Alphabetical', 'Recently Added', 'Frequency', 'JLPT'];
    final nextIndex = (options.indexOf(current) + 1) % options.length;
    ref.read(vocabSortProvider.notifier).state = options[nextIndex];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorted by: ${options[nextIndex]}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vocabLibraryNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAdmin = ref.watch(adminModeProvider);

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vocabulary Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Build your Japanese vocabulary.',
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
            tooltip: _isGridView ? 'Switch to List' : 'Switch to Grid',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
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
          // Search & Filter Block
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search vocabulary, hiragana, meanings...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(vocabQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(vocabQueryProvider.notifier).state = val.trim();
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

          // Active filter badges row
          _buildActiveFiltersIndicator(),

          // Main list content
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                    ? const VocabularyEmptyState(
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
    final jlpt = ref.watch(vocabJlptFilterProvider);
    final pos = ref.watch(vocabPosFilterProvider);
    final isAdded = ref.watch(vocabIsAddedFilterProvider);

    final hasFilters = jlpt.isNotEmpty || pos.isNotEmpty || isAdded != null;
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
              ref.read(vocabJlptFilterProvider.notifier).state = jlpt.where((l) => l != lvl).toList();
            })),
          if (pos.isNotEmpty)
            ...pos.map((p) => _buildFilterIndicatorChip(p, () {
              ref.read(vocabPosFilterProvider.notifier).state = pos.where((po) => po != p).toList();
            })),
          if (isAdded != null)
            _buildFilterIndicatorChip(isAdded ? 'Added' : 'Not Added', () {
              ref.read(vocabIsAddedFilterProvider.notifier).state = null;
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

  Widget _buildLibraryContent(VocabLibraryState state) {
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
        return VocabularyCard(
          vocab: item,
          onAddPressed: () {
            ref.read(vocabLibraryNotifierProvider.notifier).toggleAdded(item.spec.id, true);
          },
          onViewDetailsPressed: () {
            context.push('/vocabulary_details?id=${item.spec.id}');
          },
        );
      },
    );
  }

  Widget _buildGridCard(VocabularyModel item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => context.push('/vocabulary_details?id=${item.spec.id}'),
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
                item.spec.word,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                item.spec.kana,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                    child: Text('N${item.spec.jlpt}', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue)),
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
