import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/kanji/application/kanji_notifier.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/kanji/presentation/widgets/kanji_card.dart';
import 'package:shinka_track_n3/features/kanji/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/kanji/presentation/widgets/empty_state.dart';

class UserCollectionScreen extends ConsumerStatefulWidget {
  const UserCollectionScreen({super.key});

  @override
  ConsumerState<UserCollectionScreen> createState() => _UserCollectionScreenState();
}

class _UserCollectionScreenState extends ConsumerState<UserCollectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = ref.read(userQueryProvider);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilters() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FilterDialog(
        initialJlpt: ref.read(userJlptFilterProvider),
        initialGrade: ref.read(userGradeFilterProvider),
        initialStrokeBucket: ref.read(userStrokesFilterProvider),
        initialIsAdded: null,
        isUserCollection: true,
      ),
    );

    if (result != null) {
      ref.read(userJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(userGradeFilterProvider.notifier).state = result['grade'] as List<int>;
      ref.read(userStrokesFilterProvider.notifier).state = result['strokeBucket'] as String?;
    }
  }

  void _toggleSort() {
    final current = ref.read(userSortProvider);
    final options = ['Kanji', 'Meaning', 'JLPT', 'Stroke Count', 'Date Added'];
    final nextIndex = (options.indexOf(current) + 1) % options.length;
    ref.read(userSortProvider.notifier).state = options[nextIndex];
  }

  @override
  Widget build(BuildContext context) {
    final asyncCollection = ref.watch(userCollectionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('My Kanji Collection', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Change Sort Option',
            onPressed: _toggleSort,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(userCollectionProvider),
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
                      hintText: 'Search my collection...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(userQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(userQueryProvider.notifier).state = val.trim();
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

          // Collection list view
          Expanded(
            child: asyncCollection.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading collection: $err')),
              data: (list) {
                if (list.isEmpty) {
                  return KanjiEmptyState(
                    isUserCollection: true,
                    onActionButtonPressed: () {
                      context.push('/kanji/library');
                    },
                  );
                }

                // Categorize collection elements
                final favorites = list.where((k) => k.isFavorite).toList();
                final mastered = list.where((k) => k.isLearned).toList();
                final studying = list.where((k) => !k.isLearned).toList();
                final recentlyAdded = List<KanjiModel>.from(list);
                recentlyAdded.sort((a, b) => b.spec.createdAt.compareTo(a.spec.createdAt));

                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    // Collection Stats Header Card
                    _buildOverviewCard(list),
                    
                    // Continue Studying Carousel
                    if (studying.isNotEmpty)
                      _buildHorizontalSection('Continue Studying', studying),
                      
                    // Favourites Carousel
                    if (favorites.isNotEmpty)
                      _buildHorizontalSection('Favourites', favorites),

                    // Mastered Carousel
                    if (mastered.isNotEmpty)
                      _buildHorizontalSection('Mastered', mastered),

                    // Recently Added Carousel
                    if (recentlyAdded.isNotEmpty)
                      _buildHorizontalSection('Recently Added', recentlyAdded.take(10).toList()),

                    // All Kanji Section
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('All Collection Kanji', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('${list.length} characters', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return KanjiCard(
                          kanji: item,
                          onAddPressed: () {},
                          onViewDetailsPressed: () {
                            context.push('/kanji_details?id=${item.spec.id}');
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(List<KanjiModel> list) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = list.length;
    final mastered = list.where((k) => k.isLearned).length;
    final progress = total == 0 ? 0.0 : (mastered / total);

    return Container(
      margin: const EdgeInsets.all(16),
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
              const Text('Mastery Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('$mastered / $total Mastered', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalSection(String title, List<KanjiModel> items) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.3),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: InkWell(
                  onTap: () => context.push('/kanji_details?id=${item.spec.id}'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                      boxShadow: PremiumDesignSystem.premiumShadow,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.spec.character, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          item.spec.meaning,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
