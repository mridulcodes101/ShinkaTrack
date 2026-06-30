import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';

abstract class KanjiRepository {
  Future<List<KanjiModel>> getMasterLibrary({
    List<int>? jlpt,
    List<int>? grade,
    String? strokeCountBucket, // '1-5', '6-10', '11-15', '16+'
    String? query,
    String? radical,
    bool? isAdded,
    int limit = 50,
    int offset = 0,
    String? sortBy, // 'Kanji', 'Meaning', 'JLPT', 'Stroke Count', 'Date Added'
  });

  Future<List<KanjiModel>> getUserCollection({
    List<int>? jlpt,
    List<int>? grade,
    String? strokeCountBucket,
    String? query,
    String? radical,
    bool? favorite,
    bool? mastered,
    String? sortBy,
  });

  Future<KanjiModel?> getKanjiDetails(String id);
  Future<void> addToCollection(String masterKanjiId);
  Future<void> removeFromCollection(String masterKanjiId);
  Future<void> updateFavoriteStatus(String masterKanjiId, bool favorite);
  Future<void> updateMasteredStatus(String masterKanjiId, bool mastered);
  Future<void> updateNotes(String masterKanjiId, String notes);
}
