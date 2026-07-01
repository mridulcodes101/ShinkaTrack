import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';

abstract class GrammarRepository {
  Future<List<GrammarModel>> getMasterLibrary({
    List<int>? jlpt,
    String? difficultyBucket, // 'Easy', 'Medium', 'Hard'
    String? query,
    bool? isAdded,
    int limit = 50,
    int offset = 0,
    String? sortBy, // 'Alphabetical', 'JLPT', 'Difficulty', 'Recently Added'
  });

  Future<List<GrammarModel>> getUserCollection({
    List<int>? jlpt,
    String? difficultyBucket,
    String? query,
    bool? favorite,
    String? status, // 'unlearned', 'learning', 'mastered'
    String? sortBy,
  });

  Future<GrammarModel?> getGrammarDetails(String id);
  Future<void> addToCollection(String masterGrammarId);
  Future<void> removeFromCollection(String masterGrammarId);
  Future<void> updateFavoriteStatus(String masterGrammarId, bool favorite);
  Future<void> updateStudyStatus(String masterGrammarId, String status); // 'unlearned', 'learning', 'mastered'
  Future<void> updateNotes(String masterGrammarId, String notes);
}
