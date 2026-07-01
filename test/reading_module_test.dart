import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/reading/domain/repositories/reading_repository.dart';
import 'package:shinka_track_n3/features/reading/data/repositories/reading_repository_impl.dart';

void main() {
  late AppDatabase db;
  late ReadingRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = ReadingRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-009: Reading Module Core Repository Tests', () {
    final testReading = MasterReadingsCompanion.insert(
      id: 'r_test',
      title: 'コンビニの歴史',
      passage: '日本のコンビニは1970年代に始まりました。\n現在は日常生活に欠かせない存在です。',
      translation: const Value('The history of convenience stores in Japan began in the 1970s.'),
      kanjiIds: const Value('["歴", "史"]'),
      vocabularyIds: const Value('["コンビニ", "歴史"]'),
      grammarIds: const Value('["〜について"]'),
      estimatedReadingTime: const Value(4),
      difficulty: const Value('Medium'),
      level: const Value(3),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('Retrieve Reading from Master Library (Filters and Search)', () async {
      await db.into(db.masterReadings).insert(testReading);

      final all = await db.select(db.masterReadings).get();
      print('DEBUG DB ROWS: ${all.map((e) => 'id: ${e.id}, title: ${e.title}, status: ${e.status}').toList()}');

      var testListEmpty = await repository.getMasterLibrary(query: null);
      print('DEBUG QUERY NULL COUNT: ${testListEmpty.length}');
      for (final item in testListEmpty) {
        print('  - id: ${item.spec.id}, title: ${item.spec.title}, level: ${item.spec.jlpt}, diff: ${item.spec.difficulty}');
      }

      var list = await repository.getMasterLibrary(query: 'コンビニ');
      print('DEBUG QUERY "コンビニ" COUNT: ${list.length}');
      expect(list.length, 1);
      expect(list.first.spec.title, 'コンビニの歴史');

      // Filter by JLPT
      list = await repository.getMasterLibrary(jlpt: [3]);
      expect(list.length, 1);

      list = await repository.getMasterLibrary(jlpt: [5]);
      expect(list, isEmpty);

      // Filter by Difficulty
      list = await repository.getMasterLibrary(difficultyBucket: 'Medium');
      expect(list.length, 1);

      // Filter by time bucket
      list = await repository.getMasterLibrary(timeBucket: '<5 min');
      expect(list.length, 1);
    });

    test('Add to Collection, Bookmarks and Update States', () async {
      await db.into(db.masterReadings).insert(testReading);

      var collection = await repository.getUserCollection();
      expect(collection, isEmpty);

      // Bookmark passage (implicitly adds to collection)
      await repository.updateBookmarkStatus('r_test', true);

      collection = await repository.getUserCollection();
      expect(collection.length, 1);
      expect(collection.first.isAdded, isTrue);
      expect(collection.first.isFavorite, isTrue);

      // Verify details
      final details = await repository.getReadingDetails('r_test');
      expect(details != null, isTrue);
      expect(details!.isFavorite, isTrue);

      // Study status update
      await repository.updateStudyStatus('r_test', 'reading');
      final detailsStatus = await repository.getReadingDetails('r_test');
      expect(detailsStatus!.status, 'reading');

      // Remove from collection
      await repository.removeFromCollection('r_test');
      collection = await repository.getUserCollection();
      expect(collection, isEmpty);
    });
  });
}
