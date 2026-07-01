import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';

abstract class ListeningRepository {
  Future<List<ListeningModel>> getMasterLibrary({
    List<int>? jlpt,
    String? difficultyBucket, // 'Easy', 'Medium', 'Hard'
    String? durationBucket, // '0–2 minutes', '2–5 minutes', '5–10 minutes', '10+ minutes'
    String? query,
    bool? isAdded,
    bool? bookmarked,
    int limit = 50,
    int offset = 0,
    String? sortBy, // 'Newest', 'Difficulty', 'Duration'
  });

  Future<List<ListeningModel>> getUserCollection({
    List<int>? jlpt,
    String? difficultyBucket,
    String? durationBucket,
    String? query,
    bool? favorite,
    String? status, // 'unlearned', 'reading', 'completed'
    String? sortBy,
  });

  Future<ListeningModel?> getListeningDetails(String id);
  Future<void> addToCollection(String masterListeningId);
  Future<void> removeFromCollection(String masterListeningId);
  Future<void> updateBookmarkStatus(String masterListeningId, bool bookmarked);
  Future<void> updateStudyStatus(String masterListeningId, String status); // 'unlearned', 'reading', 'completed'
  Future<void> updateNotes(String masterListeningId, String notes);
}
