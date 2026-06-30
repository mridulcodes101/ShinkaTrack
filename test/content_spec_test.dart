import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/core/content/models/vocabulary_spec.dart';
import 'package:shinka_track_n3/core/content/models/grammar_spec.dart';
import 'package:shinka_track_n3/core/content/models/reading_spec.dart';
import 'package:shinka_track_n3/core/content/models/listening_spec.dart';
import 'package:shinka_track_n3/core/content/validation/content_validator.dart';

void main() {
  group('SPEC-004: Content Spec Models parsing', () {
    test('KanjiSpec JSON parsing', () {
      final json = {
        'id': 'k1',
        'character': '明',
        'unicode': 'U+660E',
        'meaning': 'bright, light',
        'onyomi': ['メイ', 'ミョウ'],
        'kunyomi': ['あか.るい', 'あ.ける'],
        'jlptLevel': 3,
        'gradeLevel': 2,
        'strokeCount': 8,
        'radicals': '日',
        'primaryRadical': '日',
        'frequencyRank': 76,
        'joyoStatus': '常用',
        'exampleWords': ['明日', '説明'],
        'exampleSentences': ['明日は晴れです。'],
        'relatedKanji': ['暗'],
        'tags': ['nature', 'time'],
        'difficulty': 1.5,
        'createdAt': '2026-06-30T12:00:00Z',
        'updatedAt': '2026-06-30T12:00:00Z',
        'schemaVersion': 1,
        'contentVersion': 2,
        'lastUpdated': '2026-06-30T12:00:00Z',
      };

      final spec = KanjiSpec.fromJson(json);

      expect(spec.id, 'k1');
      expect(spec.character, '明');
      expect(spec.onyomi, contains('メイ'));
      expect(spec.jlptLevel, 3);
      expect(spec.difficulty, 1.5);
      expect(spec.schemaVersion, 1);
      expect(spec.contentVersion, 2);
    });

    test('VocabularySpec CSV parsing', () {
      final row = [
        'v1',
        '諦める',
        'あきらめる',
        'To give up',
        '3',
        'verb',
        '1042',
        'k1;k2',
        'g1',
        '捨てる',
        '続ける',
        '夢を諦めない。',
        'verbs',
        '2.4',
        '2026-06-30T12:00:00Z',
        '2026-06-30T12:00:00Z',
        '1',
        '1',
        '2026-06-30T12:00:00Z'
      ];

      final mapping = {
        'id': 0,
        'word': 1,
        'kana': 2,
        'meaning': 3,
        'jlpt': 4,
        'partOfSpeech': 5,
        'frequency': 6,
        'kanjiUsed': 7,
        'relatedGrammar': 8,
        'synonyms': 9,
        'antonyms': 10,
        'exampleSentences': 11,
        'tags': 12,
        'difficulty': 13,
        'createdAt': 14,
        'updatedAt': 15,
        'schemaVersion': 16,
        'contentVersion': 17,
        'lastUpdated': 18
      };

      final spec = VocabularySpec.fromCsv(row, mapping);

      expect(spec.id, 'v1');
      expect(spec.word, '諦める');
      expect(spec.meaning, 'To give up');
      expect(spec.kanjiUsed, containsAll(['k1', 'k2']));
      expect(spec.synonyms, contains('捨てる'));
      expect(spec.schemaVersion, 1);
    });

    test('GrammarSpec JSON parsing', () {
      final json = {
        'id': 'g1',
        'pattern': 'に対して',
        'meaning': 'Towards, in contrast to',
        'formation': 'Noun + に対して',
        'usage': 'Used to target action or attitude',
        'nuance': 'Contrasting or targeting',
        'formality': 'Neutral',
        'jlpt': 3,
        'examples': [
          {'jp': '先生に対して', 'en': 'Towards the teacher'}
        ],
        'commonMistakes': [
          {'bad': '先生にたいし', 'good': '先生に対して', 'reason': 'Needs te form'}
        ],
        'relatedGrammar': ['g2'],
        'vocabs': ['v1'],
        'kanjis': ['k1'],
        'difficulty': 2.0,
        'tags': ['contrast'],
        'createdAt': '2026-06-30T12:00:00Z',
        'updatedAt': '2026-06-30T12:00:00Z',
        'schemaVersion': 1,
        'contentVersion': 1,
      };

      final spec = GrammarSpec.fromJson(json);

      expect(spec.id, 'g1');
      expect(spec.grammarPattern, 'に対して');
      expect(spec.examples.first.japanese, '先生に対して');
      expect(spec.commonMistakes.first.incorrect, '先生にたいし');
      expect(spec.relatedVocabulary, contains('v1'));
    });
  });

  group('SPEC-004: Validation Engine tests', () {
    final validKanji = KanjiSpec(
      id: 'k1',
      character: '明',
      unicode: 'U+660E',
      meaning: 'bright',
      onyomi: ['メイ'],
      kunyomi: ['あか.るい'],
      jlptLevel: 3,
      gradeLevel: 2,
      strokeCount: 8,
      radicals: '日',
      primaryRadical: '日',
      frequencyRank: 10,
      joyoStatus: '常用',
      exampleWords: [],
      exampleSentences: [],
      relatedKanji: [],
      tags: [],
      difficulty: 1.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: DateTime.now(),
    );

    final validVocab = VocabularySpec(
      id: 'v1',
      word: '諦める',
      kana: 'あきらめる',
      meaning: 'To give up',
      jlpt: 3,
      partOfSpeech: 'verb',
      frequency: 100,
      kanjiUsed: ['k1'],
      relatedGrammar: [],
      synonyms: [],
      antonyms: [],
      exampleSentences: [],
      tags: [],
      difficulty: 1.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: DateTime.now(),
    );

    final validGrammar = GrammarSpec(
      id: 'g1',
      grammarPattern: 'に対して',
      meaning: 'Towards',
      formation: 'Noun + に対して',
      usage: 'Targeting',
      nuance: 'None',
      formalLevel: 'Neutral',
      jlpt: 3,
      examples: [const GrammarExampleSpec(japanese: '先生に対して', english: 'Towards the teacher')],
      commonMistakes: [],
      relatedGrammar: [],
      relatedVocabulary: ['v1'],
      relatedKanji: ['k1'],
      difficulty: 1.0,
      tags: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: DateTime.now(),
    );

    final validReading = ReadingSpec(
      id: 'r1',
      title: 'Tea Culture',
      jlpt: 3,
      difficulty: 1.0,
      estimatedReadingTime: 5,
      passage: 'お茶は美味しい。',
      translation: 'Tea is delicious.',
      vocabularyReferences: ['v1'],
      grammarReferences: ['g1'],
      kanjiReferences: ['k1'],
      questions: [
        const ReadingQuestionSpec(
          id: 'q1',
          questionText: 'What is delicious?',
          options: ['Tea', 'Coffee'],
          correctOptionIndex: 0,
          explanation: 'The passage says tea.',
        )
      ],
      answers: ['0'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: DateTime.now(),
    );

    final validListening = ListeningSpec(
      id: 'l1',
      title: 'Directions',
      jlpt: 3,
      difficulty: 1.0,
      transcript: 'まっすぐ行ってください。',
      translation: 'Please go straight.',
      vocabularyReferences: ['v1'],
      grammarReferences: ['g1'],
      kanjiReferences: ['k1'],
      duration: 35.5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: DateTime.now(),
    );

    test('Valid pack validation should succeed', () {
      final res = ContentValidator.validate(
        kanjis: [validKanji],
        vocabularies: [validVocab],
        grammars: [validGrammar],
        readings: [validReading],
        listenings: [validListening],
      );

      expect(res.isValid, isTrue);
      expect(res.errors, isEmpty);
    });

    test('Presence validation failure checks', () {
      final invalidKanji = KanjiSpec(
        id: 'k2',
        character: '暗',
        unicode: 'U+9999',
        meaning: '  ', // empty meaning
        onyomi: [],
        kunyomi: [],
        jlptLevel: 0, // invalid level
        gradeLevel: 1,
        strokeCount: 0, // invalid strokes
        radicals: '',
        primaryRadical: '',
        frequencyRank: 0,
        joyoStatus: '',
        exampleWords: [],
        exampleSentences: [],
        relatedKanji: [],
        tags: [],
        difficulty: 1.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        schemaVersion: 1,
        contentVersion: 1,
        lastUpdated: DateTime.now(),
      );

      final res = ContentValidator.validate(
        kanjis: [invalidKanji],
        vocabularies: [],
        grammars: [],
        readings: [],
        listenings: [],
      );

      expect(res.isValid, isFalse);
      final fields = res.errors.map((e) => e.field).toList();
      expect(fields, contains('meaning'));
      expect(fields, contains('jlptLevel'));
      expect(fields, contains('strokeCount'));
    });

    test('Uniqueness validation failure checks', () {
      // Duplicate Kanji character and duplicate ID
      final res = ContentValidator.validate(
        kanjis: [validKanji, validKanji],
        vocabularies: [],
        grammars: [],
        readings: [],
        listenings: [],
      );

      expect(res.isValid, isFalse);
      expect(res.errors.any((e) => e.field == 'id'), isTrue);
      expect(res.errors.any((e) => e.field == 'character'), isTrue);
    });

    test('Broken reference integrity checks', () {
      // Vocab uses invalid kanji ID 'k999'
      final invalidVocab = VocabularySpec(
        id: 'v2',
        word: '食べる',
        kana: 'たべる',
        meaning: 'To eat',
        jlpt: 3,
        partOfSpeech: 'verb',
        frequency: 200,
        kanjiUsed: ['k999'], // broken reference
        relatedGrammar: [],
        synonyms: [],
        antonyms: [],
        exampleSentences: [],
        tags: [],
        difficulty: 1.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        schemaVersion: 1,
        contentVersion: 1,
        lastUpdated: DateTime.now(),
      );

      final res = ContentValidator.validate(
        kanjis: [validKanji],
        vocabularies: [invalidVocab],
        grammars: [],
        readings: [],
        listenings: [],
      );

      expect(res.isValid, isFalse);
      expect(res.errors.first.field, 'kanjiUsed');
      expect(res.errors.first.message, contains('Kanji ID "k999" does not exist'));
    });
  });
}
