import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';

abstract class ReadingRepository {
  Future<List<ReadingModel>> getMasterLibrary({
    List<int>? jlpt,
    String? difficultyBucket, // 'Easy', 'Medium', 'Hard'
    String? timeBucket, // '<5 min', '5–10 min', '10–20 min', '20+ min'
    String? query,
    bool? isAdded,
    bool? bookmarked,
    int limit = 50,
    int offset = 0,
    String? sortBy, // 'Newest', 'JLPT', 'Reading Time', 'Difficulty'
  });

  Future<List<ReadingModel>> getUserCollection({
    List<int>? jlpt,
    String? difficultyBucket,
    String? timeBucket,
    String? query,
    bool? favorite,
    String? status, // 'unlearned', 'reading', 'completed'
    String? sortBy,
  });

  Future<ReadingModel?> getReadingDetails(String id);
  Future<void> addToCollection(String masterReadingId);
  Future<void> removeFromCollection(String masterReadingId);
  Future<void> updateBookmarkStatus(String masterReadingId, bool bookmarked);
  Future<void> updateStudyStatus(String masterReadingId, String status); // 'unlearned', 'reading', 'completed'
  Future<void> updateNotes(String masterReadingId, String notes);
}
