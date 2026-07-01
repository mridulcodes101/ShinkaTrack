import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/content/models/vocabulary_spec.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/models/vocabulary_model.dart';
import 'package:shinka_track_n3/features/vocabulary/domain/repositories/vocabulary_repository.dart';

class VocabularyRepositoryImpl implements VocabularyRepository {
  final AppDatabase db;

  VocabularyRepositoryImpl(this.db);

  VocabularyModel _mapRow(MasterVocabulary m, UserVocabulary? u) {
    List<String> decodeList(String? val) {
      if (val == null || val.isEmpty) return [];
      try {
        final decoded = jsonDecode(val);
        if (decoded is List) return decoded.cast<String>();
      } catch (_) {}
      return [];
    }

    final spec = VocabularySpec(
      id: m.id,
      word: m.word,
      kana: m.kana,
      meaning: m.meaning,
      partOfSpeech: m.partOfSpeech ?? '',
      jlpt: m.jlptLevel ?? 3,
      frequency: m.frequency ?? 0,
      kanjiUsed: decodeList(m.relatedKanji),
      relatedGrammar: const [],
      synonyms: decodeList(m.synonyms),
      antonyms: decodeList(m.antonyms),
      exampleSentences: decodeList(m.exampleSentences),
      tags: decodeList(m.tags),
      difficulty: 1.0,
      createdAt: m.createdAt,
      updatedAt: m.updatedAt,
      status: u?.status ?? 'unlearned',
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: m.updatedAt,
      personalNotes: u?.customNotes ?? '',
    );

    return VocabularyModel(
      spec: spec,
      isAdded: u?.isAdded ?? false,
      isFavorite: u?.isFavorite ?? false,
      status: u?.status ?? 'unlearned',
      reviewCount: u?.reviewCount ?? 0,
      nextReview: u?.nextReview,
      lastReviewed: u?.lastReviewed,
      easeFactor: u?.easeFactor ?? 2.5,
      customNotes: u?.customNotes ?? '',
    );
  }

  @override
  Future<List<VocabularyModel>> getMasterLibrary({
    List<int>? jlpt,
    List<String>? partOfSpeech,
    String? query,
    bool? isAdded,
    int limit = 50,
    int offset = 0,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterVocabularies).join([
      leftOuterJoin(db.userVocabularies, db.userVocabularies.masterVocabId.equalsExp(db.masterVocabularies.id)),
    ]);

    // Active filters
    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterVocabularies.jlptLevel.isIn(jlpt));
    }

    if (partOfSpeech != null && partOfSpeech.isNotEmpty) {
      queryBuilder.where(db.masterVocabularies.partOfSpeech.isIn(partOfSpeech));
    }

    if (isAdded != null) {
      if (isAdded) {
        queryBuilder.where(db.userVocabularies.isAdded.equals(true));
      } else {
        queryBuilder.where(db.userVocabularies.id.isNull() | db.userVocabularies.isAdded.equals(false));
      }
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterVocabularies.word.like(pattern) |
        db.masterVocabularies.kana.like(pattern) |
        db.masterVocabularies.meaning.lower().like(pattern) |
        db.masterVocabularies.partOfSpeech.lower().like(pattern) |
        db.masterVocabularies.tags.lower().like(pattern) |
        db.masterVocabularies.relatedKanji.like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'Recently Added') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterVocabularies.createdAt)]);
    } else if (sortBy == 'Frequency') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterVocabularies.frequency)]);
    } else if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterVocabularies.jlptLevel)]);
    } else {
      // Default: Alphabetical by word
      queryBuilder.orderBy([OrderingTerm.asc(db.masterVocabularies.word)]);
    }

    // Pagination
    queryBuilder.limit(limit, offset: offset);

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterVocabularies);
      final u = row.readTableOrNull(db.userVocabularies);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<List<VocabularyModel>> getUserCollection({
    List<int>? jlpt,
    List<String>? partOfSpeech,
    String? query,
    bool? favorite,
    String? status,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterVocabularies).join([
      innerJoin(db.userVocabularies, db.userVocabularies.masterVocabId.equalsExp(db.masterVocabularies.id)),
    ]);

    queryBuilder.where(db.userVocabularies.isAdded.equals(true));

    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterVocabularies.jlptLevel.isIn(jlpt));
    }
    if (partOfSpeech != null && partOfSpeech.isNotEmpty) {
      queryBuilder.where(db.masterVocabularies.partOfSpeech.isIn(partOfSpeech));
    }
    if (favorite != null) {
      queryBuilder.where(db.userVocabularies.isFavorite.equals(favorite));
    }
    if (status != null) {
      queryBuilder.where(db.userVocabularies.status.equals(status));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterVocabularies.word.like(pattern) |
        db.masterVocabularies.kana.like(pattern) |
        db.masterVocabularies.meaning.lower().like(pattern) |
        db.masterVocabularies.partOfSpeech.lower().like(pattern) |
        db.masterVocabularies.tags.lower().like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'Recently Added') {
      queryBuilder.orderBy([OrderingTerm.desc(db.userVocabularies.createdAt)]);
    } else if (sortBy == 'Frequency') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterVocabularies.frequency)]);
    } else if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterVocabularies.jlptLevel)]);
    } else {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterVocabularies.word)]);
    }

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterVocabularies);
      final u = row.readTable(db.userVocabularies);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<VocabularyModel?> getVocabularyDetails(String id) async {
    final queryBuilder = db.select(db.masterVocabularies).join([
      leftOuterJoin(db.userVocabularies, db.userVocabularies.masterVocabId.equalsExp(db.masterVocabularies.id)),
    ]);
    queryBuilder.where(db.masterVocabularies.id.equals(id));
    final row = await queryBuilder.getSingleOrNull();
    if (row == null) return null;
    return _mapRow(row.readTable(db.masterVocabularies), row.readTableOrNull(db.userVocabularies));
  }

  @override
  Future<void> addToCollection(String masterVocabId) async {
    final existing = await (db.select(db.userVocabularies)..where((t) => t.masterVocabId.equals(masterVocabId))).getSingleOrNull();
    if (existing == null) {
      await db.into(db.userVocabularies).insert(
        UserVocabulariesCompanion.insert(
          id: masterVocabId,
          masterVocabId: masterVocabId,
          isAdded: const Value(true),
          isFavorite: const Value(false),
          status: const Value('unlearned'),
          reviewCount: const Value(0),
          easeFactor: const Value(2.5),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      await (db.update(db.userVocabularies)..where((t) => t.masterVocabId.equals(masterVocabId))).write(
        UserVocabulariesCompanion(
          isAdded: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  @override
  Future<void> removeFromCollection(String masterVocabId) async {
    await (db.update(db.userVocabularies)..where((t) => t.masterVocabId.equals(masterVocabId))).write(
      UserVocabulariesCompanion(
        isAdded: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateFavoriteStatus(String masterVocabId, bool favorite) async {
    await (db.update(db.userVocabularies)..where((t) => t.masterVocabId.equals(masterVocabId))).write(
      UserVocabulariesCompanion(
        isFavorite: Value(favorite),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateStudyStatus(String masterVocabId, String status) async {
    await (db.update(db.userVocabularies)..where((t) => t.masterVocabId.equals(masterVocabId))).write(
      UserVocabulariesCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateNotes(String masterVocabId, String notes) async {
    await (db.update(db.userVocabularies)..where((t) => t.masterVocabId.equals(masterVocabId))).write(
      UserVocabulariesCompanion(
        customNotes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
