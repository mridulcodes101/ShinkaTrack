import 'package:shinka_track_n3/features/review/domain/models/review_item.dart';
import 'package:shinka_track_n3/features/review/domain/models/review_history.dart';

abstract class ReviewRepository {
  Future<List<ReviewItem>> getDueReviewItems();
  Future<List<ReviewItem>> getOverdueReviewItems();
  Future<List<ReviewItem>> getUpcomingReviewItems({int limit = 50});
  Future<List<ReviewItem>> getWeakItems({int limit = 10});
  Future<List<ReviewItem>> getRecentlyFailedItems({int limit = 10});
  
  Future<List<ReviewHistory>> getReviewHistory({
    String? query,
    String? resultFilter,
    int limit = 50,
    int offset = 0,
  });

  Future<Map<String, dynamic>> getReviewStatistics();

  Future<void> logReviewHistory(ReviewHistory history);
  Future<void> updateReviewItemState({
    required String itemId,
    required String itemType,
    required String rating, // Again, Hard, Good, Easy
    required bool isCorrect,
    required int durationSeconds,
  });
}
