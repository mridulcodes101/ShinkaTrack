import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/repositories/vocabulary_repository.dart';
import 'package:shinka_track_n3/features/vocabulary/data/repositories/vocabulary_repository_impl.dart';

void main() {
  late AppDatabase db;
  late VocabularyRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = VocabularyRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-007: Vocabulary Module Core Repository Tests', () {
    final testVocab = MasterVocabulariesCompanion.insert(
      id: 'v_test',
      word: '食べる',
      kana: 'たべる',
      meaning: 'to eat',
      partOfSpeech: const Value('Verb'),
      jlptLevel: const Value(5),
      frequency: const Value(120),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('Retrieve Vocabulary from Master Library (Filters and Search)', () async {
      await db.into(db.masterVocabularies).insert(testVocab);

      // Search by word
      var list = await repository.getMasterLibrary(query: '食べる');
      expect(list.length, 1);
      expect(list.first.spec.meaning, 'to eat');

      // Filter by Part of Speech
      list = await repository.getMasterLibrary(partOfSpeech: ['Verb']);
      expect(list.length, 1);

      list = await repository.getMasterLibrary(partOfSpeech: ['Noun']);
      expect(list, isEmpty);

      // Filter by JLPT
      list = await repository.getMasterLibrary(jlpt: [5]);
      expect(list.length, 1);
    });

    test('Add to Collection and Update States', () async {
      await db.into(db.masterVocabularies).insert(testVocab);

      var collection = await repository.getUserCollection();
      expect(collection, isEmpty);

      // Add to collection
      await repository.addToCollection('v_test');

      collection = await repository.getUserCollection();
      expect(collection.length, 1);
      expect(collection.first.isAdded, isTrue);

      // Verify details
      final details = await repository.getVocabularyDetails('v_test');
      expect(details != null, isTrue);
      expect(details!.isAdded, isTrue);

      // Favorite toggle
      await repository.updateFavoriteStatus('v_test', true);
      final detailsFav = await repository.getVocabularyDetails('v_test');
      expect(detailsFav!.isFavorite, isTrue);

      // Study status update
      await repository.updateStudyStatus('v_test', 'learning');
      final detailsStatus = await repository.getVocabularyDetails('v_test');
      expect(detailsStatus!.status, 'learning');

      // Custom notes update
      await repository.updateNotes('v_test', 'My memory key mnemonic');
      final detailsNotes = await repository.getVocabularyDetails('v_test');
      expect(detailsNotes!.customNotes, 'My memory key mnemonic');

      // Remove from collection
      await repository.removeFromCollection('v_test');
      collection = await repository.getUserCollection();
      expect(collection, isEmpty);
    });
  });
}
