import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/domain/entities/review_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

// --- TODAY'S DUE REVIEWS NOTIFIER ---

class DueReviewsNotifier extends StateNotifier<AsyncValue<List<ReviewItemEntity>>> {
  final Ref _ref;

  DueReviewsNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadDueReviews();
  }

  Future<void> loadDueReviews() async {
    try {
      final repo = _ref.read(repositoryProvider);
      final list = await repo.getDueReviews(DateTime.now());
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> completeReview(String reviewId) async {
    // Optimistically filter item out
    state.whenData((list) {
      state = AsyncValue.data(list.where((r) => r.id != reviewId).toList());
    });

    try {
      final repo = _ref.read(repositoryProvider);
      await repo.submitReviewCompletion(reviewId);
      
      // Invalidate related providers so they reload
      _ref.invalidate(missedReviewsProvider);
      _ref.invalidate(upcomingReviewsProvider);
      _ref.invalidate(kanjiListProvider);
      _ref.invalidate(vocabListProvider);
      _ref.invalidate(grammarListProvider);
      _ref.invalidate(readingListProvider);
      _ref.invalidate(listeningListProvider);
      _ref.invalidate(streakProvider);
      _ref.invalidate(overallProgressProvider);
      
      // Reload self
      await loadDueReviews();
    } catch (e) {
      await loadDueReviews();
    }
  }
}

final dueReviewsProvider = StateNotifierProvider<DueReviewsNotifier, AsyncValue<List<ReviewItemEntity>>>((ref) {
  return DueReviewsNotifier(ref);
});

// --- OVERDUE/MISSED REVIEWS NOTIFIER ---

class MissedReviewsNotifier extends StateNotifier<AsyncValue<List<ReviewItemEntity>>> {
  final Ref _ref;

  MissedReviewsNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadMissedReviews();
  }

  Future<void> loadMissedReviews() async {
    try {
      final repo = _ref.read(repositoryProvider);
      final list = await repo.getMissedReviews(DateTime.now());
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> completeReview(String reviewId) async {
    state.whenData((list) {
      state = AsyncValue.data(list.where((r) => r.id != reviewId).toList());
    });

    try {
      final repo = _ref.read(repositoryProvider);
      await repo.submitReviewCompletion(reviewId);

      _ref.invalidate(dueReviewsProvider);
      _ref.invalidate(upcomingReviewsProvider);
      _ref.invalidate(kanjiListProvider);
      _ref.invalidate(vocabListProvider);
      _ref.invalidate(grammarListProvider);
      _ref.invalidate(readingListProvider);
      _ref.invalidate(listeningListProvider);
      _ref.invalidate(streakProvider);
      _ref.invalidate(overallProgressProvider);

      await loadMissedReviews();
    } catch (e) {
      await loadMissedReviews();
    }
  }
}

final missedReviewsProvider = StateNotifierProvider<MissedReviewsNotifier, AsyncValue<List<ReviewItemEntity>>>((ref) {
  return MissedReviewsNotifier(ref);
});

// --- UPCOMING REVIEWS NOTIFIER ---

class UpcomingReviewsNotifier extends StateNotifier<AsyncValue<List<ReviewItemEntity>>> {
  final Ref _ref;

  UpcomingReviewsNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadUpcomingReviews();
  }

  Future<void> loadUpcomingReviews() async {
    try {
      final repo = _ref.read(repositoryProvider);
      final list = await repo.getUpcomingReviews(DateTime.now());
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final upcomingReviewsProvider = StateNotifierProvider<UpcomingReviewsNotifier, AsyncValue<List<ReviewItemEntity>>>((ref) {
  return UpcomingReviewsNotifier(ref);
});
