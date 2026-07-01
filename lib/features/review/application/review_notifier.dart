import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/review/domain/models/review_item.dart';
import 'package:shinka_track_n3/features/review/domain/models/review_history.dart';
import 'package:shinka_track_n3/features/review/domain/repositories/review_repository.dart';
import 'package:shinka_track_n3/features/review/data/repositories/review_repository_impl.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ReviewRepositoryImpl(db);
});

// Future providers for Review Home
final reviewStatsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getReviewStatistics();
});

final dueReviewsProvider = FutureProvider.autoDispose<List<ReviewItem>>((ref) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getDueReviewItems();
});

final upcomingReviewsProvider = FutureProvider.autoDispose<List<ReviewItem>>((ref) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getUpcomingReviewItems();
});

final weakItemsProvider = FutureProvider.autoDispose<List<ReviewItem>>((ref) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getWeakItems();
});

final recentlyFailedReviewsProvider = FutureProvider.autoDispose<List<ReviewItem>>((ref) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getRecentlyFailedItems();
});

// History Search & Filter State
final reviewHistorySearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final reviewHistoryResultFilterProvider = StateProvider.autoDispose<String?>((ref) => null);

final reviewHistoryListProvider = FutureProvider.autoDispose<List<ReviewHistory>>((ref) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getReviewHistory(
    query: ref.watch(reviewHistorySearchQueryProvider),
    resultFilter: ref.watch(reviewHistoryResultFilterProvider),
  );
});

// Review Session State Class
class ReviewSessionState {
  final List<ReviewItem> queue;
  final int currentIndex;
  final List<ReviewItem> incorrectItems;
  final int correctCount;
  final int incorrectCount;
  final DateTime? sessionStartTime;
  final DateTime? currentCardStartTime;
  final Map<String, int> cardDurations; // itemId -> seconds
  final bool isCompleted;

  const ReviewSessionState({
    this.queue = const [],
    this.currentIndex = 0,
    this.incorrectItems = const [],
    this.correctCount = 0,
    this.incorrectCount = 0,
    this.sessionStartTime,
    this.currentCardStartTime,
    this.cardDurations = const {},
    this.isCompleted = false,
  });

  ReviewItem? get currentItem => (currentIndex < queue.length) ? queue[currentIndex] : null;

  ReviewSessionState copyWith({
    List<ReviewItem>? queue,
    int? currentIndex,
    List<ReviewItem>? incorrectItems,
    int? correctCount,
    int? incorrectCount,
    DateTime? sessionStartTime,
    DateTime? currentCardStartTime,
    Map<String, int>? cardDurations,
    bool? isCompleted,
  }) {
    return ReviewSessionState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      incorrectItems: incorrectItems ?? this.incorrectItems,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      sessionStartTime: sessionStartTime ?? this.sessionStartTime,
      currentCardStartTime: currentCardStartTime ?? this.currentCardStartTime,
      cardDurations: cardDurations ?? this.cardDurations,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// Session Notifier
class ReviewSessionNotifier extends StateNotifier<ReviewSessionState> {
  final ReviewRepository _repository;
  final Ref _ref;

  ReviewSessionNotifier(this._repository, this._ref) : super(const ReviewSessionState());

  void startSession(List<ReviewItem> rawItems) {
    // Priority Sorting Queue: Due Today -> Overdue -> Weak Items
    final List<ReviewItem> sorted = List.from(rawItems);
    sorted.sort((a, b) {
      final now = DateTime.now();
      final aDue = a.nextReview != null && a.nextReview!.isBefore(now);
      final bDue = b.nextReview != null && b.nextReview!.isBefore(now);

      if (aDue && !bDue) return -1;
      if (!aDue && bDue) return 1;

      // Overdue priority (further past nextReview)
      if (a.nextReview != null && b.nextReview != null) {
        return a.nextReview!.compareTo(b.nextReview!);
      }

      // Default to weak items first (lower correct count)
      return a.correctCount.compareTo(b.correctCount);
    });

    final now = DateTime.now();
    state = ReviewSessionState(
      queue: sorted,
      currentIndex: 0,
      incorrectItems: [],
      correctCount: 0,
      incorrectCount: 0,
      sessionStartTime: now,
      currentCardStartTime: now,
      cardDurations: {},
      isCompleted: false,
    );
  }

  Future<void> submitAnswer(String rating) async {
    final item = state.currentItem;
    if (item == null) return;

    final cardStartTime = state.currentCardStartTime ?? DateTime.now();
    final now = DateTime.now();
    final durationSeconds = now.difference(cardStartTime).inSeconds.clamp(1, 300);

    final isCorrect = rating != 'Again';

    // Log spacing update to database
    await _repository.updateReviewItemState(
      itemId: item.masterContentId,
      itemType: item.contentType,
      rating: rating,
      isCorrect: isCorrect,
      durationSeconds: durationSeconds,
    );

    // Save history log
    final nextInterval = rating == 'Easy' ? 7 : (rating == 'Good' ? 3 : 1);
    await _repository.logReviewHistory(
      ReviewHistory(
        id: const Uuid().v4(),
        itemId: item.masterContentId,
        itemType: item.contentType,
        timestamp: now,
        result: isCorrect ? 'correct' : 'incorrect',
        timeTakenSeconds: durationSeconds,
        prevInterval: item.interval,
        nextInterval: nextInterval,
      ),
    );

    // Update state
    final nextIndex = state.currentIndex + 1;
    final isSessionFinished = nextIndex >= state.queue.length;

    state = state.copyWith(
      currentIndex: nextIndex,
      correctCount: state.correctCount + (isCorrect ? 1 : 0),
      incorrectCount: state.incorrectCount + (isCorrect ? 0 : 1),
      incorrectItems: isCorrect ? state.incorrectItems : [...state.incorrectItems, item],
      currentCardStartTime: now,
      cardDurations: {...state.cardDurations, item.id: durationSeconds},
      isCompleted: isSessionFinished,
    );

    if (isSessionFinished) {
      _ref.invalidate(reviewStatsProvider);
      _ref.invalidate(dueReviewsProvider);
      _ref.invalidate(upcomingReviewsProvider);
      _ref.invalidate(weakItemsProvider);
      _ref.invalidate(recentlyFailedReviewsProvider);
      _ref.invalidate(reviewHistoryListProvider);
    }
  }

  void restartSession() {
    startSession(state.queue);
  }

  void startReviewIncorrectSession() {
    if (state.incorrectItems.isNotEmpty) {
      startSession(state.incorrectItems);
    }
  }
}

final reviewSessionNotifierProvider = StateNotifierProvider.autoDispose<ReviewSessionNotifier, ReviewSessionState>((ref) {
  final repo = ref.watch(reviewRepositoryProvider);
  return ReviewSessionNotifier(repo, ref);
});
