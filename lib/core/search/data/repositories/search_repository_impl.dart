import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/kanji/domain/repositories/kanji_repository.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/repositories/vocabulary_repository.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';
import 'package:shinka_track_n3/features/grammar/domain/repositories/grammar_repository.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';
import 'package:shinka_track_n3/features/reading/domain/repositories/reading_repository.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';
import 'package:shinka_track_n3/features/listening/domain/repositories/listening_repository.dart';
import 'package:shinka_track_n3/core/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final KanjiRepository kanjiRepo;
  final VocabularyRepository vocabRepo;
  final GrammarRepository grammarRepo;
  final ReadingRepository readingRepo;
  final ListeningRepository listeningRepo;

  SearchRepositoryImpl({
    required this.kanjiRepo,
    required this.vocabRepo,
    required this.grammarRepo,
    required this.readingRepo,
    required this.listeningRepo,
  });

  @override
  Future<List<KanjiModel>> searchKanjis(String query) async {
    return kanjiRepo.getMasterLibrary(query: query, limit: 100);
  }

  @override
  Future<List<VocabularyModel>> searchVocabularies(String query) async {
    return vocabRepo.getMasterLibrary(query: query, limit: 100);
  }

  @override
  Future<List<GrammarModel>> searchGrammars(String query) async {
    return grammarRepo.getMasterLibrary(query: query, limit: 100);
  }

  @override
  Future<List<ReadingModel>> searchReadings(String query) async {
    return readingRepo.getMasterLibrary(query: query, limit: 100);
  }

  @override
  Future<List<ListeningModel>> searchListenings(String query) async {
    return listeningRepo.getMasterLibrary(query: query, limit: 100);
  }
}
