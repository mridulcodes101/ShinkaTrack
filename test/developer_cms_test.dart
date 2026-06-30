import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/core/content/models/vocabulary_spec.dart';
import 'package:shinka_track_n3/features/study/data/repositories/study_repository_impl.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';

void main() {
  late AppDatabase db;
  late StudyRepository repository;

  setUp(() {
    // Set up in-memory sqlite database for clean testing
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = StudyRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-005: Developer CMS & Master Database CRUD Tests', () {
    final testKanji = KanjiSpec(
      id: 'k_test',
      character: '試',
      unicode: 'U+8A66',
      meaning: 'test, try',
      onyomi: ['シ'],
      kunyomi: ['こころ.みる', 'ため.す'],
      jlptLevel: 3,
      gradeLevel: 4,
      strokeCount: 13,
      radicals: '言',
      primaryRadical: '言',
      frequencyRank: 382,
      joyoStatus: '常用',
      exampleWords: ['試験'],
      exampleSentences: ['日本語の試験を受けます。'],
      relatedKanji: [],
      tags: ['study'],
      difficulty: 1.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: 'Published',
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: DateTime.now(),
      personalNotes: 'Used in grammar tests',
      svgStrokeOrder: '<svg>path</svg>',
      audio: 'k_test.mp3',
    );

    test('Insert and Retrieve Master Kanji Spec', () async {
      await repository.saveMasterKanjiSpec(testKanji);

      final kanjis = await repository.getMasterKanjisSpec();
      expect(kanjis.length, 1);
      
      final fetched = kanjis.first;
      expect(fetched.id, 'k_test');
      expect(fetched.character, '試');
      expect(fetched.meaning, 'test, try');
      expect(fetched.status, 'Published');
      expect(fetched.strokeCount, 13);
      expect(fetched.onyomi, contains('シ'));
    });

    test('Update Master Kanji Spec (Maintaining Timestamps and Contents)', () async {
      await repository.saveMasterKanjiSpec(testKanji);

      final updated = KanjiSpec(
        id: 'k_test',
        character: '試',
        unicode: 'U+8A66',
        meaning: 'trial, test', // changed meaning
        onyomi: ['シ'],
        kunyomi: ['こころ.みる'],
        jlptLevel: 3,
        gradeLevel: 4,
        strokeCount: 13,
        radicals: '言',
        primaryRadical: '言',
        frequencyRank: 382,
        joyoStatus: '常用',
        exampleWords: ['試験'],
        exampleSentences: [],
        relatedKanji: [],
        tags: ['study', 'updated'], // added tag
        difficulty: 1.0,
        createdAt: testKanji.createdAt,
        updatedAt: DateTime.now(),
        status: 'Draft', // changed status
        schemaVersion: 1,
        contentVersion: 2,
        lastUpdated: DateTime.now(),
      );

      await repository.saveMasterKanjiSpec(updated);

      final kanjis = await repository.getMasterKanjisSpec();
      expect(kanjis.length, 1);

      final fetched = kanjis.first;
      expect(fetched.meaning, 'trial, test');
      expect(fetched.status, 'Draft');
      expect(fetched.tags, contains('updated'));
    });

    test('Soft Delete (Archive) and Permanent Delete', () async {
      await repository.saveMasterKanjiSpec(testKanji);

      // Soft delete: status -> Archived
      await repository.deleteMasterKanjiSpec('k_test', permanent: false);
      var kanjis = await repository.getMasterKanjisSpec();
      expect(kanjis.length, 1);
      expect(kanjis.first.status, 'Archived');

      // Permanent delete
      await repository.deleteMasterKanjiSpec('k_test', permanent: true);
      kanjis = await repository.getMasterKanjisSpec();
      expect(kanjis, isEmpty);
    });

    test('Database Statistics Compilation', () async {
      // Setup some test data
      await repository.saveMasterKanjiSpec(testKanji);

      final draftVocab = VocabularySpec(
        id: 'v_draft',
        word: '試験',
        kana: 'しけん',
        meaning: 'exam',
        jlpt: 3,
        partOfSpeech: 'noun',
        frequency: 200,
        kanjiUsed: ['k_test'],
        relatedGrammar: [],
        synonyms: [],
        antonyms: [],
        exampleSentences: [],
        tags: [],
        difficulty: 1.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: 'Draft',
        schemaVersion: 1,
        contentVersion: 1,
        lastUpdated: DateTime.now(),
      );

      await repository.saveMasterVocabularySpec(draftVocab);

      final stats = await repository.getDatabaseStatistics();

      // Check counts
      expect(stats['kanji']['total'], greaterThanOrEqualTo(1));
      expect(stats['kanji']['Published'], greaterThanOrEqualTo(1));
      expect(stats['vocabulary']['total'], greaterThanOrEqualTo(1));
      expect(stats['vocabulary']['Draft'], greaterThanOrEqualTo(1));

      // Check validation summaries
      expect(stats['brokenReferences'], 0);
      expect(stats['duplicateRecords'], 0);
      expect(stats['averageCompleteness'] != null, isTrue);
    });
  });
}
