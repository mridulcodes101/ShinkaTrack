import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/listening/domain/repositories/listening_repository.dart';
import 'package:shinka_track_n3/features/listening/data/repositories/listening_repository_impl.dart';

void main() {
  late AppDatabase db;
  late ListeningRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = ListeningRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-010: Listening Module Core Repository Tests', () {
    final testListening = MasterListeningsCompanion.insert(
      id: 'l_test',
      title: '日常会話の練習',
      transcript: '佐藤さん、会議室の準備をお願いします。',
      audioPath: const Value('assets/audio/l_test.mp3'),
      length: const Value(90), // 1.5 mins (0-2 min bucket)
      difficulty: const Value('Easy'),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('Retrieve Listening from Master Library (Filters and Search)', () async {
      await db.into(db.masterListenings).insert(testListening);

      // Search by title
      var list = await repository.getMasterLibrary(query: '日常会話');
      expect(list.length, 1);
      expect(list.first.spec.title, '日常会話の練習');

      // Filter by Difficulty
      list = await repository.getMasterLibrary(difficultyBucket: 'Easy');
      expect(list.length, 1);

      // Filter by duration bucket
      list = await repository.getMasterLibrary(durationBucket: '0–2 minutes');
      expect(list.length, 1);
    });

    test('Add to Collection, Bookmarks and Update States', () async {
      await db.into(db.masterListenings).insert(testListening);

      var collection = await repository.getUserCollection();
      expect(collection, isEmpty);

      // Bookmark lesson (implicitly adds to collection)
      await repository.updateBookmarkStatus('l_test', true);

      collection = await repository.getUserCollection();
      expect(collection.length, 1);
      expect(collection.first.isAdded, isTrue);
      expect(collection.first.isFavorite, isTrue);

      // Verify details
      final details = await repository.getListeningDetails('l_test');
      expect(details != null, isTrue);
      expect(details!.isFavorite, isTrue);

      // Study status update
      await repository.updateStudyStatus('l_test', 'completed');
      final detailsStatus = await repository.getListeningDetails('l_test');
      expect(detailsStatus!.status, 'completed');

      // Remove from collection
      await repository.removeFromCollection('l_test');
      collection = await repository.getUserCollection();
      expect(collection, isEmpty);
    });
  });
}
