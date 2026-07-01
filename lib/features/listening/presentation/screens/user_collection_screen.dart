import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/listening/application/listening_notifier.dart';
import 'package:shinka_track_n3/features/listening/presentation/widgets/listening_card.dart';
import 'package:shinka_track_n3/features/listening/presentation/widgets/filter_dialog.dart';
import 'package:shinka_track_n3/features/listening/presentation/widgets/empty_state.dart';

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
      _searchController.text = ref.read(userListeningQueryProvider);
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
      builder: (context) => ListeningFilterDialog(
        initialJlpt: ref.read(userListeningJlptFilterProvider),
        initialDifficulty: ref.read(userListeningDifficultyFilterProvider),
        initialDuration: ref.read(userListeningDurationFilterProvider),
        initialBookmarked: null,
        initialStatus: ref.read(userListeningStatusFilterProvider),
      ),
    );

    if (result != null) {
      ref.read(userListeningJlptFilterProvider.notifier).state = result['jlpt'] as List<int>;
      ref.read(userListeningDifficultyFilterProvider.notifier).state = result['difficulty'] as String?;
      ref.read(userListeningDurationFilterProvider.notifier).state = result['duration'] as String?;
      ref.read(userListeningStatusFilterProvider.notifier).state = result['status'] as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncCollection = ref.watch(userListeningCollectionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('My Bookmarked Lessons', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(userListeningCollectionProvider),
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
                      hintText: 'Search bookmarked lessons...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(userListeningQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    ),
                    onChanged: (val) {
                      ref.read(userListeningQueryProvider.notifier).state = val.trim();
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
                  return ListeningEmptyState(
                    isUserCollection: true,
                    onActionButtonPressed: () {
                      context.push('/listening/library');
                    },
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListeningCard(
                      listening: item,
                      onBookmarkPressed: () async {
                        await ref.read(listeningLibraryNotifierProvider.notifier).toggleBookmark(item.spec.id, !item.isFavorite);
                        ref.invalidate(userListeningCollectionProvider);
                      },
                      onPlayPressed: () {
                        context.push('/listening_player?id=${item.spec.id}');
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
