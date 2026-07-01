import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';
import 'package:shinka_track_n3/features/reading/domain/repositories/reading_repository.dart';
import 'package:shinka_track_n3/features/reading/data/repositories/reading_repository_impl.dart';

final readingRepositoryProvider = Provider<ReadingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ReadingRepositoryImpl(db);
});

// Master Library Filter State Providers
final readingQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final readingJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final readingDifficultyFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // Easy, Medium, Hard
final readingTimeFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // <5 min, 5–10 min, 10–20 min, 20+ min
final readingIsAddedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final readingBookmarkedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final readingSortProvider = StateProvider.autoDispose<String>((ref) => 'Newest'); // Newest, JLPT, Reading Time, Difficulty

// Paginated State Class
class ReadingLibraryState {
  final List<ReadingModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int offset;

  const ReadingLibraryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.offset = 0,
  });

  ReadingLibraryState copyWith({
    List<ReadingModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? offset,
  }) {
    return ReadingLibraryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
    );
  }
}

// Master Library Notifier
class ReadingLibraryNotifier extends StateNotifier<ReadingLibraryState> {
  final ReadingRepository _repository;
  final Ref _ref;
  static const int _limit = 40;

  ReadingLibraryNotifier(this._repository, this._ref) : super(const ReadingLibraryState()) {
    refresh();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newItems = await _repository.getMasterLibrary(
        jlpt: _ref.read(readingJlptFilterProvider),
        difficultyBucket: _ref.read(readingDifficultyFilterProvider),
        timeBucket: _ref.read(readingTimeFilterProvider),
        query: _ref.read(readingQueryProvider),
        isAdded: _ref.read(readingIsAddedFilterProvider),
        bookmarked: _ref.read(readingBookmarkedFilterProvider),
        limit: _limit,
        offset: state.offset,
        sortBy: _ref.read(readingSortProvider),
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
        jlpt: _ref.read(readingJlptFilterProvider),
        difficultyBucket: _ref.read(readingDifficultyFilterProvider),
        timeBucket: _ref.read(readingTimeFilterProvider),
        query: _ref.read(readingQueryProvider),
        isAdded: _ref.read(readingIsAddedFilterProvider),
        bookmarked: _ref.read(readingBookmarkedFilterProvider),
        limit: _limit,
        offset: 0,
        sortBy: _ref.read(readingSortProvider),
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

  Future<void> toggleBookmark(String id, bool val) async {
    await _repository.updateBookmarkStatus(id, val);
    _updateItemLocally(id, favorite: val, added: val ? true : null);
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
      items: state.items.map((r) {
        if (r.spec.id == id) {
          return r.copyWith(
            isFavorite: favorite ?? r.isFavorite,
            status: status ?? r.status,
            isAdded: added ?? r.isAdded,
          );
        }
        return r;
      }).toList(),
    );
  }
}

final readingLibraryNotifierProvider = StateNotifierProvider.autoDispose<ReadingLibraryNotifier, ReadingLibraryState>((ref) {
  final repo = ref.watch(readingRepositoryProvider);
  
  // Watch filter states to auto-refresh/recreate the notifier when filters change
  ref.watch(readingQueryProvider);
  ref.watch(readingJlptFilterProvider);
  ref.watch(readingDifficultyFilterProvider);
  ref.watch(readingTimeFilterProvider);
  ref.watch(readingIsAddedFilterProvider);
  ref.watch(readingBookmarkedFilterProvider);
  ref.watch(readingSortProvider);

  return ReadingLibraryNotifier(repo, ref);
});

// User Collection State Providers
final userReadingQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final userReadingJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final userReadingDifficultyFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userReadingTimeFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userReadingStatusFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // unlearned, reading, completed
final userReadingSortProvider = StateProvider.autoDispose<String>((ref) => 'Newest');

// User Collection Provider
final userReadingCollectionProvider = FutureProvider.autoDispose<List<ReadingModel>>((ref) async {
  final repo = ref.watch(readingRepositoryProvider);
  final list = await repo.getUserCollection(
    jlpt: ref.watch(userReadingJlptFilterProvider),
    difficultyBucket: ref.watch(userReadingDifficultyFilterProvider),
    timeBucket: ref.watch(userReadingTimeFilterProvider),
    query: ref.watch(userReadingQueryProvider),
    status: ref.watch(userReadingStatusFilterProvider),
    sortBy: ref.watch(userReadingSortProvider),
  );
  return list;
});
