import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/grammar/domain/repositories/grammar_repository.dart';
import 'package:shinka_track_n3/features/grammar/data/repositories/grammar_repository_impl.dart';

void main() {
  late AppDatabase db;
  late GrammarRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = GrammarRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-008: Grammar Module Core Repository Tests', () {
    final testGrammar = MasterGrammarsCompanion.insert(
      id: 'g_test',
      pattern: 'ようにする',
      meaning: 'to try to, to make an effort to',
      formation: const Value('Verb (dictionary form) + ようにする'),
      usage: const Value('Indicates making a conscious effort to establish a habit.'),
      examples: const Value('[{"japanese": "体にいいので、毎日野菜を食べるようにしています。", "english": "Because it is good for my body, I make an effort to eat vegetables every day."}]'),
      commonMistakes: const Value('[{"incorrect": "毎日食べるようにするでした。", "correct": "毎日食べるようにしていました。", "explanation": "Do not mix past tense directly before pattern."}]'),
      relatedGrammar: const Value('["g_test_2"]'),
      jlptLevel: const Value(3),
      tags: const Value('["Intention", "Habit"]'),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('Retrieve Grammar from Master Library (Filters and Search)', () async {
      await db.into(db.masterGrammars).insert(testGrammar);

      // Search by pattern
      var list = await repository.getMasterLibrary(query: 'ようにする');
      expect(list.length, 1);
      expect(list.first.spec.meaning, 'to try to, to make an effort to');

      // Filter by JLPT
      list = await repository.getMasterLibrary(jlpt: [3]);
      expect(list.length, 1);

      list = await repository.getMasterLibrary(jlpt: [4]);
      expect(list, isEmpty);

      // Filter by Difficulty
      list = await repository.getMasterLibrary(difficultyBucket: 'Medium');
      expect(list.length, 1);
    });

    test('Add to Collection and Update States', () async {
      await db.into(db.masterGrammars).insert(testGrammar);

      var collection = await repository.getUserCollection();
      expect(collection, isEmpty);

      // Add to collection
      await repository.addToCollection('g_test');

      collection = await repository.getUserCollection();
      expect(collection.length, 1);
      expect(collection.first.isAdded, isTrue);

      // Verify details
      final details = await repository.getGrammarDetails('g_test');
      expect(details != null, isTrue);
      expect(details!.isAdded, isTrue);

      // Favorite toggle
      await repository.updateFavoriteStatus('g_test', true);
      final detailsFav = await repository.getGrammarDetails('g_test');
      expect(detailsFav!.isFavorite, isTrue);

      // Study status update
      await repository.updateStudyStatus('g_test', 'learning');
      final detailsStatus = await repository.getGrammarDetails('g_test');
      expect(detailsStatus!.status, 'learning');

      // Custom notes update
      await repository.updateNotes('g_test', 'Conscious effort indicator');
      final detailsNotes = await repository.getGrammarDetails('g_test');
      expect(detailsNotes!.customNotes, 'Conscious effort indicator');

      // Remove from collection
      await repository.removeFromCollection('g_test');
      collection = await repository.getUserCollection();
      expect(collection, isEmpty);
    });
  });
}
