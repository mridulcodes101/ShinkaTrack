import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/kanji/domain/repositories/kanji_repository.dart';
import 'package:shinka_track_n3/features/kanji/data/repositories/kanji_repository_impl.dart';

final kanjiRepositoryProvider = Provider<KanjiRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return KanjiRepositoryImpl(db);
});

// Master Library Filter State Providers
final libQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final libJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final libGradeFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final libStrokesFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final libRadicalFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final libIsAddedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final libSortProvider = StateProvider.autoDispose<String>((ref) => 'Kanji'); // Kanji, Meaning, JLPT, Stroke Count, Date Added

// Paginated State Class
class LibraryState {
  final List<KanjiModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int offset;

  const LibraryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.offset = 0,
  });

  LibraryState copyWith({
    List<KanjiModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? offset,
  }) {
    return LibraryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
    );
  }
}

// Master Library Notifier
class LibraryNotifier extends StateNotifier<LibraryState> {
  final KanjiRepository _repository;
  final Ref _ref;
  static const int _limit = 40;

  LibraryNotifier(this._repository, this._ref) : super(const LibraryState()) {
    refresh();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newItems = await _repository.getMasterLibrary(
        jlpt: _ref.read(libJlptFilterProvider),
        grade: _ref.read(libGradeFilterProvider),
        strokeCountBucket: _ref.read(libStrokesFilterProvider),
        query: _ref.read(libQueryProvider),
        radical: _ref.read(libRadicalFilterProvider),
        isAdded: _ref.read(libIsAddedFilterProvider),
        limit: _limit,
        offset: state.offset,
        sortBy: _ref.read(libSortProvider),
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
        jlpt: _ref.read(libJlptFilterProvider),
        grade: _ref.read(libGradeFilterProvider),
        strokeCountBucket: _ref.read(libStrokesFilterProvider),
        query: _ref.read(libQueryProvider),
        radical: _ref.read(libRadicalFilterProvider),
        isAdded: _ref.read(libIsAddedFilterProvider),
        limit: _limit,
        offset: 0,
        sortBy: _ref.read(libSortProvider),
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

  Future<void> toggleMastered(String id, bool val) async {
    await _repository.updateMasteredStatus(id, val);
    _updateItemLocally(id, mastered: val);
  }

  Future<void> toggleAdded(String id, bool val) async {
    if (val) {
      await _repository.addToCollection(id);
    } else {
      await _repository.removeFromCollection(id);
    }
    _updateItemLocally(id, added: val);
  }

  void _updateItemLocally(String id, {bool? favorite, bool? mastered, bool? added}) {
    state = state.copyWith(
      items: state.items.map((k) {
        if (k.spec.id == id) {
          return k.copyWith(
            isFavorite: favorite ?? k.isFavorite,
            isLearned: mastered ?? k.isLearned,
            isAdded: added ?? k.isAdded,
          );
        }
        return k;
      }).toList(),
    );
  }
}

final libraryNotifierProvider = StateNotifierProvider.autoDispose<LibraryNotifier, LibraryState>((ref) {
  final repo = ref.watch(kanjiRepositoryProvider);
  
  // Watch filter states to auto-refresh/recreate the notifier when filters change
  ref.watch(libQueryProvider);
  ref.watch(libJlptFilterProvider);
  ref.watch(libGradeFilterProvider);
  ref.watch(libStrokesFilterProvider);
  ref.watch(libRadicalFilterProvider);
  ref.watch(libIsAddedFilterProvider);
  ref.watch(libSortProvider);

  return LibraryNotifier(repo, ref);
});

// User Collection State Providers
final userQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final userJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final userGradeFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final userStrokesFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userRadicalFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userSortProvider = StateProvider.autoDispose<String>((ref) => 'Kanji');

// User Collection Provider
final userCollectionProvider = FutureProvider.autoDispose<List<KanjiModel>>((ref) async {
  final repo = ref.watch(kanjiRepositoryProvider);
  final list = await repo.getUserCollection(
    jlpt: ref.watch(userJlptFilterProvider),
    grade: ref.watch(userGradeFilterProvider),
    strokeCountBucket: ref.watch(userStrokesFilterProvider),
    query: ref.watch(userQueryProvider),
    radical: ref.watch(userRadicalFilterProvider),
    sortBy: ref.watch(userSortProvider),
  );
  return list;
});
