import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/review/domain/models/review_history.dart';
import 'package:shinka_track_n3/features/review/domain/repositories/review_repository.dart';
import 'package:shinka_track_n3/features/review/data/repositories/review_repository_impl.dart';

void main() {
  late AppDatabase db;
  late ReviewRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = ReviewRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-011: Spaced Repetition Review Engine Tests', () {
    final testItem = ReviewItemsCompanion.insert(
      id: 'kanji_test_k',
      itemType: 'kanji',
      itemId: 'test_k',
      stage: const Value(1),
      nextReviewDate: DateTime.now().subtract(const Duration(hours: 1)),
      lastReviewDate: DateTime.now().subtract(const Duration(days: 1)),
    );

    test('Retrieve Due Items & Log Review History', () async {
      await db.into(db.reviewItems).insert(testItem);

      // Fetch due items
      final due = await repository.getDueReviewItems();
      expect(due.length, 1);
      expect(due.first.contentType, 'kanji');
      expect(due.first.masterContentId, 'test_k');

      // Log review history
      await repository.logReviewHistory(
        ReviewHistory(
          id: 'hist_1',
          itemId: 'test_k',
          itemType: 'kanji',
          timestamp: DateTime.now(),
          result: 'correct',
          timeTakenSeconds: 3,
          prevInterval: 1,
          nextInterval: 3,
        ),
      );

      final history = await repository.getReviewHistory();
      expect(history.length, 1);
      expect(history.first.result, 'correct');
      expect(history.first.timeTakenSeconds, 3);
    });

    test('Update Review Spacing State (Rating Options)', () async {
      await db.into(db.reviewItems).insert(testItem);

      // Verify state update (rating Easy)
      await repository.updateReviewItemState(
        itemId: 'test_k',
        itemType: 'kanji',
        rating: 'Easy',
        isCorrect: true,
        durationSeconds: 2,
      );

      // Verify updated stage in DB
      final item = await (db.select(db.reviewItems)..where((x) => x.id.equals('kanji_test_k'))).getSingle();
      expect(item.stage, 2); // stage incremented
      expect(item.nextReviewDate.isAfter(DateTime.now()), isTrue);
    });
  });
}
