import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/features/kanji/domain/models/kanji_model.dart';
import 'package:shinka_track_n3/features/kanji/domain/repositories/kanji_repository.dart';

class KanjiRepositoryImpl implements KanjiRepository {
  final AppDatabase db;

  KanjiRepositoryImpl(this.db);

  KanjiModel _mapRow(MasterKanji m, UserKanji? u) {
    List<String> decodeList(String? val) {
      if (val == null || val.isEmpty) return [];
      try {
        final decoded = jsonDecode(val);
        if (decoded is List) return decoded.cast<String>();
      } catch (_) {}
      return [];
    }

    final spec = KanjiSpec(
      id: m.id,
      character: m.kanji,
      unicode: m.unicode,
      meaning: m.meaning,
      onyomi: decodeList(m.onYomi),
      kunyomi: decodeList(m.kunYomi),
      jlptLevel: m.jlptLevel,
      gradeLevel: m.gradeLevel ?? 1,
      strokeCount: m.strokeCount,
      radicals: m.radicals,
      primaryRadical: m.radicals.isNotEmpty ? m.radicals[0] : '',
      frequencyRank: m.frequencyRank ?? 0,
      joyoStatus: m.status,
      exampleWords: decodeList(m.exampleWords),
      exampleSentences: decodeList(m.exampleSentences),
      relatedKanji: const [],
      tags: decodeList(m.tags),
      difficulty: 1.0,
      createdAt: m.createdAt,
      updatedAt: m.updatedAt,
      status: m.status,
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: m.updatedAt,
      personalNotes: m.notes,
      svgStrokeOrder: m.strokeOrderDiagram,
      audio: m.audioPath,
    );

    return KanjiModel(
      spec: spec,
      isAdded: u?.isAdded ?? false,
      isLearned: u?.isLearned ?? false,
      isFavorite: u?.isFavorite ?? false,
      reviewCount: u?.reviewCount ?? 0,
      nextReview: u?.nextReview,
      lastReviewed: u?.lastReviewed,
      customNotes: u?.customNotes ?? '',
    );
  }

  @override
  Future<List<KanjiModel>> getMasterLibrary({
    List<int>? jlpt,
    List<int>? grade,
    String? strokeCountBucket,
    String? query,
    String? radical,
    bool? isAdded,
    int limit = 50,
    int offset = 0,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterKanjis).join([
      leftOuterJoin(db.userKanjis, db.userKanjis.masterKanjiId.equalsExp(db.masterKanjis.id)),
    ]);

    // Active records only (Published/Draft - not Archived)
    queryBuilder.where(db.masterKanjis.status.isNotValue('Archived'));

    // JLPT Levels
    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterKanjis.jlptLevel.isIn(jlpt));
    }

    // Grades
    if (grade != null && grade.isNotEmpty) {
      queryBuilder.where(db.masterKanjis.gradeLevel.isIn(grade));
    }

    // Stroke Count Buckets
    if (strokeCountBucket != null) {
      if (strokeCountBucket == '1-5') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerOrEqualValue(1) & db.masterKanjis.strokeCount.isSmallerOrEqualValue(5));
      } else if (strokeCountBucket == '6-10') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerOrEqualValue(6) & db.masterKanjis.strokeCount.isSmallerOrEqualValue(10));
      } else if (strokeCountBucket == '11-15') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerOrEqualValue(11) & db.masterKanjis.strokeCount.isSmallerOrEqualValue(15));
      } else if (strokeCountBucket == '16+') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerThanValue(15));
      }
    }

    // Radical filter
    if (radical != null && radical.isNotEmpty) {
      queryBuilder.where(db.masterKanjis.radicals.like('%$radical%'));
    }

    // Status filter
    if (isAdded != null) {
      if (isAdded) {
        queryBuilder.where(db.userKanjis.isAdded.equals(true));
      } else {
        queryBuilder.where(db.userKanjis.id.isNull() | db.userKanjis.isAdded.equals(false));
      }
    }

    // Keyword Search (Kanji, Meaning, Onyomi, Kunyomi, Radicals, Tags)
    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterKanjis.kanji.like(pattern) |
        db.masterKanjis.meaning.lower().like(pattern) |
        db.masterKanjis.onYomi.lower().like(pattern) |
        db.masterKanjis.kunYomi.lower().like(pattern) |
        db.masterKanjis.radicals.lower().like(pattern) |
        db.masterKanjis.tags.lower().like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'Meaning') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterKanjis.meaning)]);
    } else if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterKanjis.jlptLevel)]);
    } else if (sortBy == 'Stroke Count') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterKanjis.strokeCount)]);
    } else if (sortBy == 'Date Added') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterKanjis.createdAt)]);
    } else {
      // Default: Kanji (Alphabetical/Unicode value)
      queryBuilder.orderBy([OrderingTerm.asc(db.masterKanjis.kanji)]);
    }

    // Pagination
    queryBuilder.limit(limit, offset: offset);

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterKanjis);
      final u = row.readTableOrNull(db.userKanjis);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<List<KanjiModel>> getUserCollection({
    List<int>? jlpt,
    List<int>? grade,
    String? strokeCountBucket,
    String? query,
    String? radical,
    bool? favorite,
    bool? mastered,
    String? sortBy,
  }) async {
    // Only return rows where user has added the kanji
    final queryBuilder = db.select(db.masterKanjis).join([
      innerJoin(db.userKanjis, db.userKanjis.masterKanjiId.equalsExp(db.masterKanjis.id)),
    ]);

    queryBuilder.where(db.userKanjis.isAdded.equals(true));

    // Filters
    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterKanjis.jlptLevel.isIn(jlpt));
    }
    if (grade != null && grade.isNotEmpty) {
      queryBuilder.where(db.masterKanjis.gradeLevel.isIn(grade));
    }
    if (strokeCountBucket != null) {
      if (strokeCountBucket == '1-5') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerOrEqualValue(1) & db.masterKanjis.strokeCount.isSmallerOrEqualValue(5));
      } else if (strokeCountBucket == '6-10') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerOrEqualValue(6) & db.masterKanjis.strokeCount.isSmallerOrEqualValue(10));
      } else if (strokeCountBucket == '11-15') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerOrEqualValue(11) & db.masterKanjis.strokeCount.isSmallerOrEqualValue(15));
      } else if (strokeCountBucket == '16+') {
        queryBuilder.where(db.masterKanjis.strokeCount.isBiggerThanValue(15));
      }
    }
    if (radical != null && radical.isNotEmpty) {
      queryBuilder.where(db.masterKanjis.radicals.like('%$radical%'));
    }
    if (favorite != null) {
      queryBuilder.where(db.userKanjis.isFavorite.equals(favorite));
    }
    if (mastered != null) {
      queryBuilder.where(db.userKanjis.isLearned.equals(mastered));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterKanjis.kanji.like(pattern) |
        db.masterKanjis.meaning.lower().like(pattern) |
        db.masterKanjis.onYomi.lower().like(pattern) |
        db.masterKanjis.kunYomi.lower().like(pattern) |
        db.masterKanjis.radicals.lower().like(pattern) |
        db.masterKanjis.tags.lower().like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'Meaning') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterKanjis.meaning)]);
    } else if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterKanjis.jlptLevel)]);
    } else if (sortBy == 'Stroke Count') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterKanjis.strokeCount)]);
    } else if (sortBy == 'Date Added') {
      queryBuilder.orderBy([OrderingTerm.desc(db.userKanjis.createdAt)]);
    } else {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterKanjis.kanji)]);
    }

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterKanjis);
      final u = row.readTable(db.userKanjis);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<KanjiModel?> getKanjiDetails(String id) async {
    final queryBuilder = db.select(db.masterKanjis).join([
      leftOuterJoin(db.userKanjis, db.userKanjis.masterKanjiId.equalsExp(db.masterKanjis.id)),
    ]);
    queryBuilder.where(db.masterKanjis.id.equals(id));
    final row = await queryBuilder.getSingleOrNull();
    if (row == null) return null;
    return _mapRow(row.readTable(db.masterKanjis), row.readTableOrNull(db.userKanjis));
  }

  @override
  Future<void> addToCollection(String masterKanjiId) async {
    final existing = await (db.select(db.userKanjis)..where((t) => t.masterKanjiId.equals(masterKanjiId))).getSingleOrNull();
    if (existing == null) {
      await db.into(db.userKanjis).insert(
        UserKanjisCompanion.insert(
          id: masterKanjiId,
          masterKanjiId: masterKanjiId,
          isAdded: const Value(true),
          isLearned: const Value(false),
          isFavorite: const Value(false),
          reviewCount: const Value(0),
          easeFactor: const Value(2.5),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      await (db.update(db.userKanjis)..where((t) => t.masterKanjiId.equals(masterKanjiId))).write(
        UserKanjisCompanion(
          isAdded: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  @override
  Future<void> removeFromCollection(String masterKanjiId) async {
    await (db.update(db.userKanjis)..where((t) => t.masterKanjiId.equals(masterKanjiId))).write(
      UserKanjisCompanion(
        isAdded: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateFavoriteStatus(String masterKanjiId, bool favorite) async {
    await (db.update(db.userKanjis)..where((t) => t.masterKanjiId.equals(masterKanjiId))).write(
      UserKanjisCompanion(
        isFavorite: Value(favorite),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateMasteredStatus(String masterKanjiId, bool mastered) async {
    await (db.update(db.userKanjis)..where((t) => t.masterKanjiId.equals(masterKanjiId))).write(
      UserKanjisCompanion(
        isLearned: Value(mastered),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateNotes(String masterKanjiId, String notes) async {
    await (db.update(db.userKanjis)..where((t) => t.masterKanjiId.equals(masterKanjiId))).write(
      UserKanjisCompanion(
        customNotes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
