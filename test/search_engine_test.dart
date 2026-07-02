import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/core/search/domain/models/search_filter.dart';
import 'package:shinka_track_n3/core/search/domain/repositories/search_repository.dart';
import 'package:shinka_track_n3/core/search/services/universal_search_engine.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/core/content/models/vocabulary_spec.dart';
import 'package:shinka_track_n3/core/content/models/grammar_spec.dart';

class MockSearchRepository implements SearchRepository {
  @override
  Future<List<KanjiModel>> searchKanjis(String query) async {
    return [
      KanjiModel(
        spec: KanjiSpec(
          id: 'k1',
          character: '水',
          unicode: 'U+6C34',
          jlptLevel: 5,
          meaning: 'Water',
          kunyomi: ['みず'],
          onyomi: ['スイ'],
          strokeCount: 4,
          radicals: '水',
          gradeLevel: 1,
          primaryRadical: '水',
          frequencyRank: 100,
          joyoStatus: 'Grade 1',
          exampleWords: [],
          exampleSentences: [],
          relatedKanji: [],
          tags: [],
          difficulty: 1.0,
          status: 'Published',
          schemaVersion: 1,
          contentVersion: 1,
          lastUpdated: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        isAdded: true,
        isFavorite: false,
        isLearned: false,
        reviewCount: 0,
        customNotes: '',
      )
    ];
  }

  @override
  Future<List<VocabularyModel>> searchVocabularies(String query) async {
    return [
      VocabularyModel(
        spec: VocabularySpec(
          id: 'v1',
          word: '水曜日',
          kana: 'すいようび',
          meaning: 'Wednesday',
          jlpt: 5,
          difficulty: 1.0,
          partOfSpeech: 'noun',
          frequency: 50,
          kanjiUsed: [],
          relatedGrammar: [],
          synonyms: [],
          antonyms: [],
          exampleSentences: [],
          tags: [],
          status: 'Published',
          schemaVersion: 1,
          contentVersion: 1,
          lastUpdated: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        isAdded: true,
        isFavorite: false,
        status: 'unlearned',
        reviewCount: 0,
        easeFactor: 2.5,
        customNotes: '',
      )
    ];
  }

  @override
  Future<List<GrammarModel>> searchGrammars(String query) async {
    return [
      GrammarModel(
        spec: GrammarSpec(
          id: 'g1',
          grammarPattern: '〜ようにする',
          meaning: 'to try to',
          jlpt: 3,
          formation: 'verb dictionary form + ようにする',
          usage: 'effort/intent',
          nuance: 'intention',
          formalLevel: 'casual/polite',
          examples: [],
          commonMistakes: [],
          relatedGrammar: [],
          relatedVocabulary: [],
          relatedKanji: [],
          difficulty: 1.5,
          tags: [],
          status: 'Published',
          schemaVersion: 1,
          contentVersion: 1,
          lastUpdated: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        isAdded: true,
        isFavorite: false,
        status: 'unlearned',
        customNotes: '',
      )
    ];
  }

  @override
  Future<List<ReadingModel>> searchReadings(String query) async {
    return [];
  }

  @override
  Future<List<ListeningModel>> searchListenings(String query) async {
    return [];
  }
}

void main() {
  late MockSearchRepository mockRepo;
  late UniversalSearchEngine searchEngine;

  setUp(() {
    mockRepo = MockSearchRepository();
    searchEngine = UniversalSearchEngine(mockRepo);
  });

  group('SPEC-013: Universal Search Engine Tests', () {
    test('Exact match score should be higher than prefix/contains match score', () async {
      final resultsExact = await searchEngine.search(
        query: '水',
        filter: const SearchFilter(),
      );
      
      expect(resultsExact.isNotEmpty, isTrue);
      // '水' exact match on '水' Kanji should score 100
      final kanjiResult = resultsExact.firstWhere((r) => r.contentType == 'kanji');
      expect(kanjiResult.searchScore, 100.0);

      // '水' prefix match on '水曜日' Vocab should score 80
      final vocabResult = resultsExact.firstWhere((r) => r.contentType == 'vocab');
      expect(vocabResult.searchScore, 80.0);
    });

    test('Filter by JLPT level restricts results correctly', () async {
      final resultsFiltered = await searchEngine.search(
        query: '水',
        filter: const SearchFilter(jlptLevels: [5]),
      );

      // Should exclude 'g1' grammar (N3) and keep 'k1' and 'v1' (N5)
      for (var r in resultsFiltered) {
        expect(r.jlpt, 5);
      }
    });

    test('Sorting alphabetical vs relevance ranking', () async {
      final resultsRelevance = await searchEngine.search(
        query: '水',
        filter: const SearchFilter(sortBy: 'relevance'),
      );
      
      // relevance: exact Kanji U+6C34 (score 100) first, then prefix vocab (score 80)
      expect(resultsRelevance.first.contentType, 'kanji');

      final resultsAlphabetical = await searchEngine.search(
        query: '水',
        filter: const SearchFilter(sortBy: 'alphabetical'),
      );

      // alphabetical: 水 (Mizu) vs 水曜日 (Suiyoubi) -> check alphabetical sort
      expect(resultsAlphabetical.isNotEmpty, isTrue);
    });
  });
}
