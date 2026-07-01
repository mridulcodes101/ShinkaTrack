import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/content/models/reading_spec.dart';
import 'package:shinka_track_n3/features/reading/domain/models/reading_model.dart';
import 'package:shinka_track_n3/features/reading/domain/repositories/reading_repository.dart';

class ReadingRepositoryImpl implements ReadingRepository {
  final AppDatabase db;

  ReadingRepositoryImpl(this.db);

  List<String> _parseJsonList(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is List) {
        return decoded.cast<String>();
      }
    } catch (_) {}
    return [];
  }

  List<ReadingQuestionSpec> _parseQuestions(String? qStr, String? ansStr, String? expStr) {
    List<ReadingQuestionSpec> questionsList = [];
    if (qStr != null && qStr.trim().isNotEmpty) {
      final trimmed = qStr.trim();
      if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
        try {
          final decoded = jsonDecode(trimmed);
          if (decoded is List) {
            questionsList = decoded.map((q) => ReadingQuestionSpec.fromJson(Map<String, dynamic>.from(q))).toList();
          } else if (decoded is Map) {
            questionsList = [ReadingQuestionSpec.fromJson(Map<String, dynamic>.from(decoded))];
          }
        } catch (_) {}
      }
      if (questionsList.isEmpty) {
        questionsList = [
          ReadingQuestionSpec(
            id: 'q1',
            questionText: qStr,
            options: const [],
            correctOptionIndex: int.tryParse(ansStr ?? '0') ?? 0,
            explanation: expStr ?? '',
          )
        ];
      }
    }
    return questionsList;
  }

  ReadingModel _mapRow(MasterReading m, UserReading? u) {
    final spec = ReadingSpec(
      id: m.id,
      title: m.title,
      jlpt: m.level ?? 3,
      difficulty: double.tryParse(m.difficulty ?? '1.0') ?? 1.0,
      estimatedReadingTime: m.estimatedReadingTime ?? 5,
      passage: m.passage,
      translation: m.translation ?? '',
      vocabularyReferences: _parseJsonList(m.vocabularyIds),
      grammarReferences: _parseJsonList(m.grammarIds),
      kanjiReferences: _parseJsonList(m.kanjiIds),
      questions: _parseQuestions(m.question, m.answer, m.explanation),
      answers: (m.answer ?? '0').split(';'),
      createdAt: m.createdAt,
      updatedAt: m.updatedAt,
      status: m.status ?? 'Published',
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: m.updatedAt,
      notes: m.explanation,
    );

    return ReadingModel(
      spec: spec,
      isAdded: u?.isAdded ?? false,
      isFavorite: u?.isFavorite ?? false,
      status: u?.status ?? 'unlearned',
      customNotes: u?.customNotes ?? '',
    );
  }

  @override
  Future<List<ReadingModel>> getMasterLibrary({
    List<int>? jlpt,
    String? difficultyBucket,
    String? timeBucket,
    String? query,
    bool? isAdded,
    bool? bookmarked,
    int limit = 50,
    int offset = 0,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterReadings).join([
      leftOuterJoin(db.userReadings, db.userReadings.masterReadingId.equalsExp(db.masterReadings.id)),
    ]);

    // Filters
    queryBuilder.where(db.masterReadings.status.isNotValue('Archived'));

    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterReadings.level.isIn(jlpt));
    }

    if (difficultyBucket != null) {
      queryBuilder.where(db.masterReadings.difficulty.equals(difficultyBucket));
    }

    if (timeBucket != null) {
      if (timeBucket == '<5 min') {
        queryBuilder.where(db.masterReadings.estimatedReadingTime.isSmallerThan(const Variable(5)));
      } else if (timeBucket == '5–10 min') {
        queryBuilder.where(
          db.masterReadings.estimatedReadingTime.isBiggerOrEqual(const Variable(5)) &
          db.masterReadings.estimatedReadingTime.isSmallerOrEqual(const Variable(10))
        );
      } else if (timeBucket == '10–20 min') {
        queryBuilder.where(
          db.masterReadings.estimatedReadingTime.isBiggerOrEqual(const Variable(10)) &
          db.masterReadings.estimatedReadingTime.isSmallerOrEqual(const Variable(20))
        );
      } else if (timeBucket == '20+ min') {
        queryBuilder.where(db.masterReadings.estimatedReadingTime.isBiggerThan(const Variable(20)));
      }
    }

    if (isAdded != null) {
      if (isAdded) {
        queryBuilder.where(db.userReadings.isAdded.equals(true));
      } else {
        queryBuilder.where(db.userReadings.id.isNull() | db.userReadings.isAdded.equals(false));
      }
    }

    if (bookmarked != null) {
      queryBuilder.where(db.userReadings.isFavorite.equals(bookmarked));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterReadings.title.like(pattern) |
        db.masterReadings.passage.like(pattern) |
        db.masterReadings.difficulty.like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterReadings.level)]);
    } else if (sortBy == 'Reading Time') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterReadings.estimatedReadingTime)]);
    } else if (sortBy == 'Difficulty') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterReadings.difficulty)]);
    } else {
      // Default: Newest
      queryBuilder.orderBy([OrderingTerm.desc(db.masterReadings.createdAt)]);
    }

    // Pagination
    queryBuilder.limit(limit, offset: offset);

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterReadings);
      final u = row.readTableOrNull(db.userReadings);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<List<ReadingModel>> getUserCollection({
    List<int>? jlpt,
    String? difficultyBucket,
    String? timeBucket,
    String? query,
    bool? favorite,
    String? status,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterReadings).join([
      innerJoin(db.userReadings, db.userReadings.masterReadingId.equalsExp(db.masterReadings.id)),
    ]);

    queryBuilder.where(db.userReadings.isAdded.equals(true));

    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterReadings.level.isIn(jlpt));
    }
    if (difficultyBucket != null) {
      queryBuilder.where(db.masterReadings.difficulty.equals(difficultyBucket));
    }
    if (timeBucket != null) {
      if (timeBucket == '<5 min') {
        queryBuilder.where(db.masterReadings.estimatedReadingTime.isSmallerThan(const Variable(5)));
      } else if (timeBucket == '5–10 min') {
        queryBuilder.where(
          db.masterReadings.estimatedReadingTime.isBiggerOrEqual(const Variable(5)) &
          db.masterReadings.estimatedReadingTime.isSmallerOrEqual(const Variable(10))
        );
      } else if (timeBucket == '10–20 min') {
        queryBuilder.where(
          db.masterReadings.estimatedReadingTime.isBiggerOrEqual(const Variable(10)) &
          db.masterReadings.estimatedReadingTime.isSmallerOrEqual(const Variable(20))
        );
      } else if (timeBucket == '20+ min') {
        queryBuilder.where(db.masterReadings.estimatedReadingTime.isBiggerThan(const Variable(20)));
      }
    }
    if (favorite != null) {
      queryBuilder.where(db.userReadings.isFavorite.equals(favorite));
    }
    if (status != null) {
      queryBuilder.where(db.userReadings.status.equals(status));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterReadings.title.like(pattern) |
        db.masterReadings.passage.like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterReadings.level)]);
    } else if (sortBy == 'Reading Time') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterReadings.estimatedReadingTime)]);
    } else if (sortBy == 'Difficulty') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterReadings.difficulty)]);
    } else {
      queryBuilder.orderBy([OrderingTerm.desc(db.userReadings.createdAt)]);
    }

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterReadings);
      final u = row.readTable(db.userReadings);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<ReadingModel?> getReadingDetails(String id) async {
    final queryBuilder = db.select(db.masterReadings).join([
      leftOuterJoin(db.userReadings, db.userReadings.masterReadingId.equalsExp(db.masterReadings.id)),
    ]);
    queryBuilder.where(db.masterReadings.id.equals(id));
    final row = await queryBuilder.getSingleOrNull();
    if (row == null) return null;
    return _mapRow(row.readTable(db.masterReadings), row.readTableOrNull(db.userReadings));
  }

  @override
  Future<void> addToCollection(String masterReadingId) async {
    final existing = await (db.select(db.userReadings)..where((t) => t.masterReadingId.equals(masterReadingId))).getSingleOrNull();
    if (existing == null) {
      await db.into(db.userReadings).insert(
        UserReadingsCompanion.insert(
          id: masterReadingId,
          masterReadingId: masterReadingId,
          isAdded: const Value(true),
          isFavorite: const Value(false),
          status: const Value('unlearned'),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      await (db.update(db.userReadings)..where((t) => t.masterReadingId.equals(masterReadingId))).write(
        UserReadingsCompanion(
          isAdded: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  @override
  Future<void> removeFromCollection(String masterReadingId) async {
    await (db.update(db.userReadings)..where((t) => t.masterReadingId.equals(masterReadingId))).write(
      UserReadingsCompanion(
        isAdded: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateBookmarkStatus(String masterReadingId, bool bookmarked) async {
    // Implicitly add to collection if bookmarked
    await addToCollection(masterReadingId);
    
    await (db.update(db.userReadings)..where((t) => t.masterReadingId.equals(masterReadingId))).write(
      UserReadingsCompanion(
        isFavorite: Value(bookmarked),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateStudyStatus(String masterReadingId, String status) async {
    await (db.update(db.userReadings)..where((t) => t.masterReadingId.equals(masterReadingId))).write(
      UserReadingsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateNotes(String masterReadingId, String notes) async {
    await (db.update(db.userReadings)..where((t) => t.masterReadingId.equals(masterReadingId))).write(
      UserReadingsCompanion(
        customNotes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
