import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/search/domain/models/search_result.dart';
import 'package:shinka_track_n3/core/search/domain/models/search_filter.dart';
import 'package:shinka_track_n3/core/search/application/search_notifier.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: PremiumDesignSystem.premiumShadow,
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search Kanji, Vocabulary, Grammar...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: PremiumDesignSystem.primaryBlue),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
              onChanged: (val) {
                ref.read(searchQueryProvider.notifier).state = val;
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Search Filters',
            onPressed: () => _showFiltersDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: query.trim().isEmpty 
          ? _buildEmptyState(context) 
          : _buildSearchResults(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final recent = ref.watch(recentSearchesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recent.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RECENT SEARCHES',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
                ),
                TextButton(
                  onPressed: () => ref.read(recentSearchesProvider.notifier).clearAll(),
                  child: const Text('Clear All', style: TextStyle(fontSize: 12, color: PremiumDesignSystem.secondaryPink)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recent.map((item) {
                return Chip(
                  backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text(item, style: const TextStyle(fontSize: 13)),
                  deleteIcon: const Icon(Icons.close, size: 16, color: Colors.grey),
                  onDeleted: () => ref.read(recentSearchesProvider.notifier).deleteSearch(item),
                  deleteButtonTooltipMessage: 'Delete',
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
          ],

          const Text(
            'SUGGESTED TOPICS',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
          ),
          const SizedBox(height: 12),
          _buildSuggestionChip('JLPT N3 Grammar'),
          _buildSuggestionChip('Onyomi vs Kunyomi'),
          _buildSuggestionChip('Common Particles'),
          _buildSuggestionChip('Listening Practice'),

          const SizedBox(height: 32),
          const Text(
            'JLPT LEVELS',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [5, 4, 3, 2, 1].map((n) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                  foregroundColor: PremiumDesignSystem.primaryBlue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  elevation: 0,
                ),
                onPressed: () {
                  ref.read(searchFilterProvider.notifier).state = SearchFilter(jlptLevels: [n]);
                  _searchController.text = 'JLPT N$n';
                  ref.read(searchQueryProvider.notifier).state = 'JLPT N$n';
                },
                child: Text('N$n', style: const TextStyle(fontWeight: FontWeight.bold)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: ListTile(
        leading: const Icon(Icons.trending_up, color: PremiumDesignSystem.primaryBlue),
        title: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        onTap: () {
          _searchController.text = text;
          ref.read(searchQueryProvider.notifier).state = text;
        },
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final resultsAsync = ref.watch(searchResultsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return resultsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error carrying out search query.')),
      data: (results) {
        if (results.isEmpty) {
          return _buildNoResultsState(context);
        }

        // Group by content type
        final grouped = <String, List<SearchResult>>{};
        for (var r in results) {
          grouped.putIfAbsent(r.contentType, () => []).add(r);
        }

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          children: grouped.keys.map((type) {
            final list = grouped[type]!;
            return _buildGroupSection(context, type, list);
          }).toList(),
        );
      },
    );
  }

  Widget _buildNoResultsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: PremiumDesignSystem.secondaryPink.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search_off_rounded, size: 64, color: PremiumDesignSystem.secondaryPink),
            ),
            const SizedBox(height: 24),
            const Text('No Results Found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Try searching by Kanji, Meaning, Grammar, or Vocabulary to match your target learning targets.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupSection(BuildContext context, String type, List<SearchResult> items) {
    final firstFive = items.take(5).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            type.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ...firstFive.map((item) {
                IconData icon;
                switch (item.icon) {
                  case 'menu_book':
                    icon = Icons.menu_book;
                    break;
                  case 'translate':
                    icon = Icons.translate;
                    break;
                  case 'g_translate':
                    icon = Icons.g_translate;
                    break;
                  case 'chrome_reader_mode':
                    icon = Icons.chrome_reader_mode;
                    break;
                  case 'audiotrack':
                    icon = Icons.audiotrack;
                    break;
                  default:
                    icon = Icons.search;
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                    foregroundColor: PremiumDesignSystem.primaryBlue,
                    child: Icon(icon, size: 20),
                  ),
                  title: Text(item.primaryTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item.secondaryTitle),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('N${item.jlpt}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () => context.push(item.route),
                );
              }),
              if (items.length > 5) ...[
                const Divider(height: 1),
                TextButton(
                  onPressed: () {
                    // Show all matching types
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Showing all ${items.length} items.')),
                    );
                  },
                  child: const Text('View All Match Results', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _showFiltersDialog(BuildContext context) {
    final filter = ref.read(searchFilterProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Search Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('JLPT Levels', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [5, 4, 3, 2, 1].map((level) {
                      final isSel = filter.jlptLevels.contains(level);
                      return ChoiceChip(
                        selectedColor: PremiumDesignSystem.primaryBlue,
                        label: Text('N$level', style: TextStyle(color: isSel ? Colors.white : Colors.black)),
                        selected: isSel,
                        onSelected: (val) {
                          final levels = List<int>.from(filter.jlptLevels);
                          if (val) {
                            levels.add(level);
                          } else {
                            levels.remove(level);
                          }
                          setModalState(() {
                            ref.read(searchFilterProvider.notifier).state = filter.copyWith(jlptLevels: levels);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text('Sort By', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: filter.sortBy,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'relevance', child: Text('Relevance Score')),
                      DropdownMenuItem(value: 'alphabetical', child: Text('Alphabetical')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          ref.read(searchFilterProvider.notifier).state = filter.copyWith(sortBy: val);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PremiumDesignSystem.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ref.invalidate(searchResultsProvider);
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
