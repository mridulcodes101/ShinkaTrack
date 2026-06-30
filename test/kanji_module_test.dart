import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/kanji/domain/repositories/kanji_repository.dart';
import 'package:shinka_track_n3/features/kanji/data/repositories/kanji_repository_impl.dart';

void main() {
  late AppDatabase db;
  late KanjiRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = KanjiRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-006: Kanji Module Core Repository Tests', () {
    final testKanji = MasterKanjisCompanion.insert(
      id: 'k_test',
      kanji: '語',
      unicode: 'U+8A9E',
      jlptLevel: 3,
      gradeLevel: const Value(2),
      meaning: 'language, word',
      kunYomi: '["かた.る", "かた.らう"]',
      onYomi: '["ゴ"]',
      strokeCount: 14,
      radicals: '言',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('Retrieve Kanjis from Master Library (Filters and Search)', () async {
      await db.into(db.masterKanjis).insert(testKanji);

      // Search by character
      var list = await repository.getMasterLibrary(query: '語');
      expect(list.length, 1);
      expect(list.first.spec.meaning, 'language, word');

      // Filter by JLPT level
      list = await repository.getMasterLibrary(jlpt: [3]);
      expect(list.length, 1);

      // Filter by other JLPT level
      list = await repository.getMasterLibrary(jlpt: [4]);
      expect(list, isEmpty);

      // Stroke Count Bucket
      list = await repository.getMasterLibrary(strokeCountBucket: '11-15');
      expect(list.length, 1);
    });

    test('Add to Collection and Retrieve User Collection', () async {
      await db.into(db.masterKanjis).insert(testKanji);

      // Verify not added initially
      var collection = await repository.getUserCollection();
      expect(collection, isEmpty);

      // Add to collection
      await repository.addToCollection('k_test');

      collection = await repository.getUserCollection();
      expect(collection.length, 1);
      expect(collection.first.isAdded, isTrue);

      // Verify details
      final details = await repository.getKanjiDetails('k_test');
      expect(details != null, isTrue);
      expect(details!.isAdded, isTrue);
      expect(details.isFavorite, isFalse);

      // Toggle favorite status
      await repository.updateFavoriteStatus('k_test', true);
      final detailsFav = await repository.getKanjiDetails('k_test');
      expect(detailsFav!.isFavorite, isTrue);

      // Toggle mastered status
      await repository.updateMasteredStatus('k_test', true);
      final detailsMast = await repository.getKanjiDetails('k_test');
      expect(detailsMast!.isLearned, isTrue);

      // Update custom notes
      await repository.updateNotes('k_test', 'Custom mnemonic text');
      final detailsNotes = await repository.getKanjiDetails('k_test');
      expect(detailsNotes!.customNotes, 'Custom mnemonic text');

      // Remove from collection
      await repository.removeFromCollection('k_test');
      collection = await repository.getUserCollection();
      expect(collection, isEmpty);
    });
  });
}
