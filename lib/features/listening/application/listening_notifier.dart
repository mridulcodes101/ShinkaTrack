import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';
import 'package:shinka_track_n3/features/listening/domain/repositories/listening_repository.dart';
import 'package:shinka_track_n3/features/listening/data/repositories/listening_repository_impl.dart';

final listeningRepositoryProvider = Provider<ListeningRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ListeningRepositoryImpl(db);
});

// Master Library Filter State Providers
final listeningQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final listeningJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final listeningDifficultyFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // Easy, Medium, Hard
final listeningDurationFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // 0–2 minutes, 2–5 minutes, 5–10 minutes, 10+ minutes
final listeningIsAddedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final listeningBookmarkedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final listeningSortProvider = StateProvider.autoDispose<String>((ref) => 'Newest'); // Newest, Difficulty, Duration

// Paginated State Class
class ListeningLibraryState {
  final List<ListeningModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int offset;

  const ListeningLibraryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.offset = 0,
  });

  ListeningLibraryState copyWith({
    List<ListeningModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? offset,
  }) {
    return ListeningLibraryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
    );
  }
}

// Master Library Notifier
class ListeningLibraryNotifier extends StateNotifier<ListeningLibraryState> {
  final ListeningRepository _repository;
  final Ref _ref;
  static const int _limit = 40;

  ListeningLibraryNotifier(this._repository, this._ref) : super(const ListeningLibraryState()) {
    refresh();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newItems = await _repository.getMasterLibrary(
        jlpt: _ref.read(listeningJlptFilterProvider),
        difficultyBucket: _ref.read(listeningDifficultyFilterProvider),
        durationBucket: _ref.read(listeningDurationFilterProvider),
        query: _ref.read(listeningQueryProvider),
        isAdded: _ref.read(listeningIsAddedFilterProvider),
        bookmarked: _ref.read(listeningBookmarkedFilterProvider),
        limit: _limit,
        offset: state.offset,
        sortBy: _ref.read(listeningSortProvider),
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
        jlpt: _ref.read(listeningJlptFilterProvider),
        difficultyBucket: _ref.read(listeningDifficultyFilterProvider),
        durationBucket: _ref.read(listeningDurationFilterProvider),
        query: _ref.read(listeningQueryProvider),
        isAdded: _ref.read(listeningIsAddedFilterProvider),
        bookmarked: _ref.read(listeningBookmarkedFilterProvider),
        limit: _limit,
        offset: 0,
        sortBy: _ref.read(listeningSortProvider),
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
      items: state.items.map((l) {
        if (l.spec.id == id) {
          return l.copyWith(
            isFavorite: favorite ?? l.isFavorite,
            status: status ?? l.status,
            isAdded: added ?? l.isAdded,
          );
        }
        return l;
      }).toList(),
    );
  }
}

final listeningLibraryNotifierProvider = StateNotifierProvider.autoDispose<ListeningLibraryNotifier, ListeningLibraryState>((ref) {
  final repo = ref.watch(listeningRepositoryProvider);
  
  // Watch filter states to auto-refresh/recreate the notifier when filters change
  ref.watch(listeningQueryProvider);
  ref.watch(listeningJlptFilterProvider);
  ref.watch(listeningDifficultyFilterProvider);
  ref.watch(listeningDurationFilterProvider);
  ref.watch(listeningIsAddedFilterProvider);
  ref.watch(listeningBookmarkedFilterProvider);
  ref.watch(listeningSortProvider);

  return ListeningLibraryNotifier(repo, ref);
});

// User Collection State Providers
final userListeningQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final userListeningJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final userListeningDifficultyFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userListeningDurationFilterProvider = StateProvider.autoDispose<String?>((ref) => null);
final userListeningStatusFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // unlearned, reading, completed
final userListeningSortProvider = StateProvider.autoDispose<String>((ref) => 'Newest');

// User Collection Provider
final userListeningCollectionProvider = FutureProvider.autoDispose<List<ListeningModel>>((ref) async {
  final repo = ref.watch(listeningRepositoryProvider);
  final list = await repo.getUserCollection(
    jlpt: ref.watch(userListeningJlptFilterProvider),
    difficultyBucket: ref.watch(userListeningDifficultyFilterProvider),
    durationBucket: ref.watch(userListeningDurationFilterProvider),
    query: ref.watch(userListeningQueryProvider),
    status: ref.watch(userListeningStatusFilterProvider),
    sortBy: ref.watch(userListeningSortProvider),
  );
  return list;
});
