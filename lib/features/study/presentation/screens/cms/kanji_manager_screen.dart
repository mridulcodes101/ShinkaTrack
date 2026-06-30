import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/add_edit_kanji_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/kanji_detail_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/cms_dashboard_screen.dart';

final cmsKanjisProvider = StateNotifierProvider.autoDispose<CmsKanjisNotifier, AsyncValue<List<KanjiSpec>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return CmsKanjisNotifier(repo);
});

class CmsKanjisNotifier extends StateNotifier<AsyncValue<List<KanjiSpec>>> {
  final StudyRepository _repository;
  CmsKanjisNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadKanjis();
  }

  Future<void> loadKanjis() async {
    try {
      final list = await _repository.getMasterKanjisSpec();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> saveKanji(KanjiSpec spec) async {
    await _repository.saveMasterKanjiSpec(spec);
    await loadKanjis();
  }

  Future<void> archiveKanji(String id) async {
    await _repository.deleteMasterKanjiSpec(id, permanent: false);
    await loadKanjis();
  }

  Future<void> deleteKanjiPermanently(String id) async {
    await _repository.deleteMasterKanjiSpec(id, permanent: true);
    await loadKanjis();
  }
}

class KanjiManagerScreen extends ConsumerStatefulWidget {
  const KanjiManagerScreen({super.key});

  @override
  ConsumerState<KanjiManagerScreen> createState() => _KanjiManagerScreenState();
}

class _KanjiManagerScreenState extends ConsumerState<KanjiManagerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Filters
  final Set<int> _selectedJlpt = {};
  final Set<String> _selectedStatuses = {};
  
  // Sort field
  String _sortBy = 'Kanji'; // Kanji, Frequency, JLPT, Stroke Count, Date Added

  // Multi selection
  final Set<String> _selectedIds = {};
  bool _selectionMode = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        if (_selectedIds.isEmpty) _selectionMode = false;
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedIds.clear();
      _selectionMode = false;
    });
  }

  Future<void> _bulkArchive() async {
    final notifier = ref.read(cmsKanjisProvider.notifier);
    for (var id in _selectedIds) {
      await notifier.archiveKanji(id);
    }
    _clearSelection();
    ref.invalidate(cmsStatsProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bulk archived completed successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cmsKanjisProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: _selectionMode
            ? Text('${_selectedIds.length} Selected')
            : const Text('Kanji Manager', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        leading: _selectionMode
            ? IconButton(icon: const Icon(Icons.close), onPressed: _clearSelection)
            : null,
        actions: _selectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.archive),
                  tooltip: 'Archive Selected',
                  onPressed: _bulkArchive,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  tooltip: 'Delete Selected',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Confirm Bulk Delete'),
                        content: Text('Are you sure you want to permanently delete ${_selectedIds.length} items? This cannot be undone.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () async {
                              Navigator.pop(ctx);
                              final notifier = ref.read(cmsKanjisProvider.notifier);
                              for (var id in _selectedIds) {
                                await notifier.deleteKanjiPermanently(id);
                              }
                              _clearSelection();
                              ref.invalidate(cmsStatsProvider);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref.read(cmsKanjisProvider.notifier).loadKanjis(),
                ),
              ],
      ),
      body: Column(
        children: [
          // Search & Filter header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by Kanji, Meaning, Unicode, Radical, tags...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.black12,
              ),
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
            ),
          ),
          
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Sort Dropdown
                _buildSortDropdown(),
                const SizedBox(width: 8),
                // JLPT Levels
                ...[5, 4, 3, 2, 1].map((lvl) {
                  final selected = _selectedJlpt.contains(lvl);
                  return Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilterChip(
                      label: Text('N$lvl'),
                      selected: selected,
                      selectedColor: PremiumDesignSystem.primaryBlue.withOpacity(0.2),
                      checkmarkColor: PremiumDesignSystem.primaryBlue,
                      onSelected: (val) {
                        setState(() {
                          if (val) {
                            _selectedJlpt.add(lvl);
                          } else {
                            _selectedJlpt.remove(lvl);
                          }
                        });
                      },
                    ),
                  );
                }),
                // Status Filters
                ...['Published', 'Draft', 'Archived'].map((status) {
                  final selected = _selectedStatuses.contains(status);
                  return Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilterChip(
                      label: Text(status),
                      selected: selected,
                      selectedColor: PremiumDesignSystem.secondaryPink.withOpacity(0.2),
                      checkmarkColor: PremiumDesignSystem.secondaryPink,
                      onSelected: (val) {
                        setState(() {
                          if (val) {
                            _selectedStatuses.add(status);
                          } else {
                            _selectedStatuses.remove(status);
                          }
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Kanji List
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading kanjis: $err')),
              data: (list) {
                final filtered = _applyFilters(list);
                if (filtered.isEmpty) {
                  return const Center(child: Text('No matching Kanji found'));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    final isSelected = _selectedIds.contains(item.id);
                    return _buildKanjiCard(item, isSelected);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PremiumDesignSystem.primaryBlue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditKanjiScreen(),
            ),
          ).then((_) {
            ref.read(cmsKanjisProvider.notifier).loadKanjis();
            ref.invalidate(cmsStatsProvider);
          });
        },
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<String>(
        value: _sortBy,
        underline: const SizedBox(),
        icon: const Icon(Icons.sort, size: 16),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),
        items: ['Kanji', 'Frequency', 'JLPT', 'Stroke Count', 'Date Added'].map((val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) {
            setState(() => _sortBy = val);
          }
        },
      ),
    );
  }

  List<KanjiSpec> _applyFilters(List<KanjiSpec> list) {
    var filtered = list.where((item) {
      // 1. Search Query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesBasic = item.character.contains(query) ||
            item.meaning.toLowerCase().contains(query) ||
            item.unicode.toLowerCase().contains(query) ||
            item.radicals.toLowerCase().contains(query);
        final matchesTags = item.tags.any((t) => t.toLowerCase().contains(query));
        final matchesExamples = item.exampleWords.any((w) => w.toLowerCase().contains(query));
        if (!matchesBasic && !matchesTags && !matchesExamples) return false;
      }
      // 2. JLPT Levels
      if (_selectedJlpt.isNotEmpty && !_selectedJlpt.contains(item.jlptLevel)) {
        return false;
      }
      // 3. Statuses
      if (_selectedStatuses.isNotEmpty && !_selectedStatuses.contains(item.status)) {
        return false;
      }
      return true;
    }).toList();

    // Sorting
    filtered.sort((a, b) {
      if (_sortBy == 'Kanji') {
        return a.character.compareTo(b.character);
      } else if (_sortBy == 'Frequency') {
        return a.frequencyRank.compareTo(b.frequencyRank);
      } else if (_sortBy == 'JLPT') {
        return a.jlptLevel.compareTo(b.jlptLevel);
      } else if (_sortBy == 'Stroke Count') {
        return a.strokeCount.compareTo(b.strokeCount);
      } else if (_sortBy == 'Date Added') {
        return b.createdAt.compareTo(a.createdAt);
      }
      return 0;
    });

    return filtered;
  }

  Widget _buildKanjiCard(KanjiSpec item, bool isSelected) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color getStatusColor(String s) {
      if (s == 'Published') return Colors.green;
      if (s == 'Draft') return Colors.orange;
      return Colors.red;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? const BorderSide(color: PremiumDesignSystem.primaryBlue, width: 2)
            : BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      color: isSelected
          ? (isDark ? Colors.blue.withOpacity(0.15) : Colors.blue.withOpacity(0.05))
          : (isDark ? PremiumDesignSystem.surfaceDark : Colors.white),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () {
          if (_selectionMode) {
            _toggleSelection(item.id);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KanjiDetailScreen(spec: item)),
            ).then((_) {
              ref.read(cmsKanjisProvider.notifier).loadKanjis();
              ref.invalidate(cmsStatsProvider);
            });
          }
        },
        onLongPress: () {
          setState(() {
            _selectionMode = true;
            _toggleSelection(item.id);
          });
        },
        leading: Text(
          item.character,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                item.meaning,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: getStatusColor(item.status).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.status,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: getStatusColor(item.status)),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(
              children: [
                Text('N${item.jlptLevel}', style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Text('${item.strokeCount} strokes', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 12),
                if (item.frequencyRank > 0)
                  Text('Freq: #${item.frequencyRank}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
        trailing: _selectionMode
            ? Checkbox(
                value: isSelected,
                activeColor: PremiumDesignSystem.primaryBlue,
                onChanged: (_) => _toggleSelection(item.id),
              )
            : const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }
}
