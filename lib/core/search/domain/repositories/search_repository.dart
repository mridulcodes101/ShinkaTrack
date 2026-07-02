import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';

abstract class SearchRepository {
  Future<List<KanjiModel>> searchKanjis(String query);
  Future<List<VocabularyModel>> searchVocabularies(String query);
  Future<List<GrammarModel>> searchGrammars(String query);
  Future<List<ReadingModel>> searchReadings(String query);
  Future<List<ListeningModel>> searchListenings(String query);
}
