import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/reading/application/reading_notifier.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/reading_card.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/reading/presentation/widgets/empty_state.dart';

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
      _searchController.text = ref.read(userReadingQueryProvider);
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
      builder: (context) => ReadingFilterDialog(
        initialJlpt: ref.read(userReadingJlptFilterProvider),
        initialDifficulty: ref.read(userReadingDifficultyFilterProvider),
        initialTime: ref.read(userReadingTimeFilterProvider),
        initialBookmarked: null,
        initialStatus: ref.read(userReadingStatusFilterProvider),
      ),
    );

    if (result != null) {
      ref.read(userReadingJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(userReadingDifficultyFilterProvider.notifier).state = result['difficulty'] as String?;
      ref.read(userReadingTimeFilterProvider.notifier).state = result['time'] as String?;
      ref.read(userReadingStatusFilterProvider.notifier).state = result['status'] as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncCollection = ref.watch(userReadingCollectionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('My Bookmarks', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(userReadingCollectionProvider),
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
                      hintText: 'Search bookmarked passages...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(userReadingQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(userReadingQueryProvider.notifier).state = val.trim();
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

          // Content
          Expanded(
            child: asyncCollection.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading collection: $err')),
              data: (list) {
                if (list.isEmpty) {
                  return ReadingEmptyState(
                    isUserCollection: true,
                    onActionButtonPressed: () {
                      context.push('/reading/library');
                    },
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ReadingCard(
                      reading: item,
                      onBookmarkPressed: () async {
                        await ref.read(readingLibraryNotifierProvider.notifier).toggleBookmark(item.spec.id, !item.isFavorite);
                        ref.invalidate(userReadingCollectionProvider);
                      },
                      onReadPressed: () {
                        context.push('/reading_mode?id=${item.spec.id}');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
