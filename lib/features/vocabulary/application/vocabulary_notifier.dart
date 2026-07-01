import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/repositories/vocabulary_repository.dart';
import 'package:shinka_track_n3/features/vocabulary/data/repositories/vocabulary_repository_impl.dart';

final vocabRepositoryProvider = Provider<VocabularyRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return VocabularyRepositoryImpl(db);
});

// Master Library Filter State Providers
final vocabQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final vocabJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final vocabPosFilterProvider = StateProvider.autoDispose<List<String>>((ref) => []);
final vocabIsAddedFilterProvider = StateProvider.autoDispose<bool?>((ref) => null);
final vocabSortProvider = StateProvider.autoDispose<String>((ref) => 'Alphabetical'); // Alphabetical, Recently Added, Frequency, JLPT

// Paginated State Class
class VocabLibraryState {
  final List<VocabularyModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int offset;

  const VocabLibraryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.offset = 0,
  });

  VocabLibraryState copyWith({
    List<VocabularyModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? offset,
  }) {
    return VocabLibraryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
    );
  }
}

// Master Library Notifier
class VocabLibraryNotifier extends StateNotifier<VocabLibraryState> {
  final VocabularyRepository _repository;
  final Ref _ref;
  static const int _limit = 40;

  VocabLibraryNotifier(this._repository, this._ref) : super(const VocabLibraryState()) {
    refresh();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newItems = await _repository.getMasterLibrary(
        jlpt: _ref.read(vocabJlptFilterProvider),
        partOfSpeech: _ref.read(vocabPosFilterProvider),
        query: _ref.read(vocabQueryProvider),
        isAdded: _ref.read(vocabIsAddedFilterProvider),
        limit: _limit,
        offset: state.offset,
        sortBy: _ref.read(vocabSortProvider),
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
        jlpt: _ref.read(vocabJlptFilterProvider),
        partOfSpeech: _ref.read(vocabPosFilterProvider),
        query: _ref.read(vocabQueryProvider),
        isAdded: _ref.read(vocabIsAddedFilterProvider),
        limit: _limit,
        offset: 0,
        sortBy: _ref.read(vocabSortProvider),
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
      items: state.items.map((v) {
        if (v.spec.id == id) {
          return v.copyWith(
            isFavorite: favorite ?? v.isFavorite,
            status: status ?? v.status,
            isAdded: added ?? v.isAdded,
          );
        }
        return v;
      }).toList(),
    );
  }
}

final vocabLibraryNotifierProvider = StateNotifierProvider.autoDispose<VocabLibraryNotifier, VocabLibraryState>((ref) {
  final repo = ref.watch(vocabRepositoryProvider);
  
  // Watch filter states to auto-refresh/recreate the notifier when filters change
  ref.watch(vocabQueryProvider);
  ref.watch(vocabJlptFilterProvider);
  ref.watch(vocabPosFilterProvider);
  ref.watch(vocabIsAddedFilterProvider);
  ref.watch(vocabSortProvider);

  return VocabLibraryNotifier(repo, ref);
});

// User Collection State Providers
final userVocabQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final userVocabJlptFilterProvider = StateProvider.autoDispose<List<int>>((ref) => []);
final userVocabPosFilterProvider = StateProvider.autoDispose<List<String>>((ref) => []);
final userVocabStatusFilterProvider = StateProvider.autoDispose<String?>((ref) => null); // unlearned, learning, mastered
final userVocabSortProvider = StateProvider.autoDispose<String>((ref) => 'Alphabetical');

// User Collection Provider
final userVocabCollectionProvider = FutureProvider.autoDispose<List<VocabularyModel>>((ref) async {
  final repo = ref.watch(vocabRepositoryProvider);
  final list = await repo.getUserCollection(
    jlpt: ref.watch(userVocabJlptFilterProvider),
    partOfSpeech: ref.watch(userVocabPosFilterProvider),
    query: ref.watch(userVocabQueryProvider),
    status: ref.watch(userVocabStatusFilterProvider),
    sortBy: ref.watch(userVocabSortProvider),
  );
  return list;
});
