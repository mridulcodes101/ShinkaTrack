import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';

abstract class VocabularyRepository {
  Future<List<VocabularyModel>> getMasterLibrary({
    List<int>? jlpt,
    List<String>? partOfSpeech,
    String? query,
    bool? isAdded,
    int limit = 50,
    int offset = 0,
    String? sortBy, // 'Alphabetical', 'Recently Added', 'Frequency', 'JLPT'
  });

  Future<List<VocabularyModel>> getUserCollection({
    List<int>? jlpt,
    List<String>? partOfSpeech,
    String? query,
    bool? favorite,
    String? status, // 'unlearned', 'learning', 'mastered'
    String? sortBy,
  });

  Future<VocabularyModel?> getVocabularyDetails(String id);
  Future<void> addToCollection(String masterVocabId);
  Future<void> removeFromCollection(String masterVocabId);
  Future<void> updateFavoriteStatus(String masterVocabId, bool favorite);
  Future<void> updateStudyStatus(String masterVocabId, String status); // 'unlearned', 'learning', 'mastered'
  Future<void> updateNotes(String masterVocabId, String notes);
}
