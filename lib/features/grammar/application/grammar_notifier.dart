import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';
import 'package:shinka_track_n3/features/grammar/domain/repositories/grammar_repository.dart';
import 'package:shinka_track_n3/features/grammar/data/repositories/grammar_repository_impl.dart';

final grammarRepositoryProvider = Provider<GrammarRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GrammarRepositoryImpl(db);
});

// Master Library Filter State Providers
final grammarQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final grammarJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final grammarDifficultyFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // Easy, Medium, Hard
final grammarIsAddedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final grammarSortProvider = StateProvider.autoDispose<String>((ref) => 'Alphabetical'); // Alphabetical, JLPT, Difficulty, Recently Added

// Paginated State Class
class GrammarLibraryState {
  final List<GrammarModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int offset;

  const GrammarLibraryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.offset = 0,
  });

  GrammarLibraryState copyWith({
    List<GrammarModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? offset,
  }) {
    return GrammarLibraryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
    );
  }
}

// Master Library Notifier
class GrammarLibraryNotifier extends StateNotifier<GrammarLibraryState> {
  final GrammarRepository _repository;
  final Ref _ref;
  static const int _limit = 40;

  GrammarLibraryNotifier(this._repository, this._ref) : super(const GrammarLibraryState()) {
    refresh();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newItems = await _repository.getMasterLibrary(
        jlpt: _ref.read(grammarJlptFilterProvider),
        difficultyBucket: _ref.read(grammarDifficultyFilterProvider),
        query: _ref.read(grammarQueryProvider),
        isAdded: _ref.read(grammarIsAddedFilterProvider),
        limit: _limit,
        offset: state.offset,
        sortBy: _ref.read(grammarSortProvider),
      );

      state = state.copyWith(
        items: [...state.items, ...newItems],
        isLoadingMore: false,
        offset: state.offset + _limit,
        hasMore: newItems.length >= _limit,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, offset: 0, items: [], hasMore: true);

    try {
      final items = await _repository.getMasterLibrary(
        jlpt: _ref.read(grammarJlptFilterProvider),
        difficultyBucket: _ref.read(grammarDifficultyFilterProvider),
        query: _ref.read(grammarQueryProvider),
        isAdded: _ref.read(grammarIsAddedFilterProvider),
        limit: _limit,
        offset: 0,
        sortBy: _ref.read(grammarSortProvider),
      );

      state = state.copyWith(
        items: items,
        isLoading: false,
        offset: _limit,
        hasMore: items.length >= _limit,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggleFavorite(String id, bool val) async {
    await _repository.updateFavoriteStatus(id, val);
    _updateItemLocally(id, favorite: val);
  }

  Future<void> updateStudyStatus(String id, String val) async {
    await _repository.updateStudyStatus(id, val);
    _updateItemLocally(id, status: val);
  }

  Future<void> toggleAdded(String id, bool val) async {
    if (val) {
      await _repository.addToCollection(id);
    } else {
      await _repository.removeFromCollection(id);
    }
    _updateItemLocally(id, added: val);
  }

  void _updateItemLocally(String id, {bool? favorite, String? status, bool? added}) {
    state = state.copyWith(
      items: state.items.map((g) {
        if (g.spec.id == id) {
          return g.copyWith(
            isFavorite: favorite ?? g.isFavorite,
            status: status ?? g.status,
            isAdded: added ?? g.isAdded,
          );
        }
        return g;
      }).toList(),
    );
  }
}

final grammarLibraryNotifierProvider = StateNotifierProvider.autoDispose<GrammarLibraryNotifier, GrammarLibraryState>((ref) {
  final repo = ref.watch(grammarRepositoryProvider);
  
  // Watch filter states to auto-refresh/recreate the notifier when filters change
  ref.watch(grammarQueryProvider);
  ref.watch(grammarJlptFilterProvider);
  ref.watch(grammarDifficultyFilterProvider);
  ref.watch(grammarIsAddedFilterProvider);
  ref.watch(grammarSortProvider);

  return GrammarLibraryNotifier(repo, ref);
});

// User Collection State Providers
final userGrammarQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final userGrammarJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final userGrammarDifficultyFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userGrammarStatusFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // unlearned, learning, mastered
final userGrammarSortProvider = StateProvider.autoDispose<String>((ref) => 'Alphabetical');

// User Collection Provider
final userGrammarCollectionProvider = FutureProvider.autoDispose<List<GrammarModel>>((ref) async {
  final repo = ref.watch(grammarRepositoryProvider);
  final list = await repo.getUserCollection(
    jlpt: ref.watch(userGrammarJlptFilterProvider),
    difficultyBucket: ref.watch(userGrammarDifficultyFilterProvider),
    query: ref.watch(userGrammarQueryProvider),
    status: ref.watch(userGrammarStatusFilterProvider),
    sortBy: ref.watch(userGrammarSortProvider),
  );
  return list;
});
