import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/content/models/listening_spec.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';
import 'package:shinka_track_n3/features/listening/domain/repositories/listening_repository.dart';

class ListeningRepositoryImpl implements ListeningRepository {
  final AppDatabase db;

  ListeningRepositoryImpl(this.db);

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

  ListeningModel _mapRow(MasterListening m, UserListening? u) {
    final spec = ListeningSpec(
      id: m.id,
      title: m.title,
      jlpt: 3,
      difficulty: double.tryParse(m.difficulty ?? '1.0') ?? 1.0,
      transcript: m.transcript,
      translation: '',
      vocabularyReferences: _parseJsonList(m.vocabularyIds),
      grammarReferences: _parseJsonList(m.grammarIds),
      kanjiReferences: _parseJsonList(m.kanjiIds),
      duration: (m.length ?? 0).toDouble(),
      createdAt: m.createdAt,
      updatedAt: m.updatedAt,
      status: m.status ?? 'Published',
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: m.updatedAt,
      audio: m.audioPath,
    );

    return ListeningModel(
      spec: spec,
      isAdded: u?.isAdded ?? false,
      isFavorite: u?.isFavorite ?? false,
      status: u?.status ?? 'unlearned',
      customNotes: u?.customNotes ?? '',
    );
  }

  @override
  Future<List<ListeningModel>> getMasterLibrary({
    List<int>? jlpt,
    String? difficultyBucket,
    String? durationBucket,
    String? query,
    bool? isAdded,
    bool? bookmarked,
    int limit = 50,
    int offset = 0,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterListenings).join([
      leftOuterJoin(db.userListenings, db.userListenings.masterListeningId.equalsExp(db.masterListenings.id)),
    ]);

    // Active filters
    queryBuilder.where(db.masterListenings.status.isNotValue('Archived'));

    // Since listening level is not stored, default is 3
    if (jlpt != null && jlpt.isNotEmpty && !jlpt.contains(3)) {
      return [];
    }

    if (difficultyBucket != null) {
      queryBuilder.where(db.masterListenings.difficulty.equals(difficultyBucket));
    }

    if (durationBucket != null) {
      if (durationBucket == '0–2 minutes') {
        queryBuilder.where(db.masterListenings.length.isSmallerOrEqual(const Variable(120)));
      } else if (durationBucket == '2–5 minutes') {
        queryBuilder.where(
          db.masterListenings.length.isBiggerThan(const Variable(120)) &
          db.masterListenings.length.isSmallerOrEqual(const Variable(300))
        );
      } else if (durationBucket == '5–10 minutes') {
        queryBuilder.where(
          db.masterListenings.length.isBiggerThan(const Variable(300)) &
          db.masterListenings.length.isSmallerOrEqual(const Variable(600))
        );
      } else if (durationBucket == '10+ minutes') {
        queryBuilder.where(db.masterListenings.length.isBiggerThan(const Variable(600)));
      }
    }

    if (isAdded != null) {
      if (isAdded) {
        queryBuilder.where(db.userListenings.isAdded.equals(true));
      } else {
        queryBuilder.where(db.userListenings.id.isNull() | db.userListenings.isAdded.equals(false));
      }
    }

    if (bookmarked != null) {
      queryBuilder.where(db.userListenings.isFavorite.equals(bookmarked));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterListenings.title.like(pattern) |
        db.masterListenings.transcript.like(pattern) |
        db.masterListenings.difficulty.like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'Duration') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterListenings.length)]);
    } else if (sortBy == 'Difficulty') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterListenings.difficulty)]);
    } else {
      // Default: Newest
      queryBuilder.orderBy([OrderingTerm.desc(db.masterListenings.createdAt)]);
    }

    // Pagination
    queryBuilder.limit(limit, offset: offset);

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterListenings);
      final u = row.readTableOrNull(db.userListenings);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<List<ListeningModel>> getUserCollection({
    List<int>? jlpt,
    String? difficultyBucket,
    String? durationBucket,
    String? query,
    bool? favorite,
    String? status,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterListenings).join([
      innerJoin(db.userListenings, db.userListenings.masterListeningId.equalsExp(db.masterListenings.id)),
    ]);

    queryBuilder.where(db.userListenings.isAdded.equals(true));

    if (jlpt != null && jlpt.isNotEmpty && !jlpt.contains(3)) {
      return [];
    }

    if (difficultyBucket != null) {
      queryBuilder.where(db.masterListenings.difficulty.equals(difficultyBucket));
    }

    if (durationBucket != null) {
      if (durationBucket == '0–2 minutes') {
        queryBuilder.where(db.masterListenings.length.isSmallerOrEqual(const Variable(120)));
      } else if (durationBucket == '2–5 minutes') {
        queryBuilder.where(
          db.masterListenings.length.isBiggerThan(const Variable(120)) &
          db.masterListenings.length.isSmallerOrEqual(const Variable(300))
        );
      } else if (durationBucket == '5–10 minutes') {
        queryBuilder.where(
          db.masterListenings.length.isBiggerThan(const Variable(300)) &
          db.masterListenings.length.isSmallerOrEqual(const Variable(600))
        );
      } else if (durationBucket == '10+ minutes') {
        queryBuilder.where(db.masterListenings.length.isBiggerThan(const Variable(600)));
      }
    }

    if (favorite != null) {
      queryBuilder.where(db.userListenings.isFavorite.equals(favorite));
    }
    if (status != null) {
      queryBuilder.where(db.userListenings.status.equals(status));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterListenings.title.like(pattern) |
        db.masterListenings.transcript.like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'Duration') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterListenings.length)]);
    } else if (sortBy == 'Difficulty') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterListenings.difficulty)]);
    } else {
      queryBuilder.orderBy([OrderingTerm.desc(db.userListenings.createdAt)]);
    }

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterListenings);
      final u = row.readTable(db.userListenings);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<ListeningModel?> getListeningDetails(String id) async {
    final queryBuilder = db.select(db.masterListenings).join([
      leftOuterJoin(db.userListenings, db.userListenings.masterListeningId.equalsExp(db.masterListenings.id)),
    ]);
    queryBuilder.where(db.masterListenings.id.equals(id));
    final row = await queryBuilder.getSingleOrNull();
    if (row == null) return null;
    return _mapRow(row.readTable(db.masterListenings), row.readTableOrNull(db.userListenings));
  }

  @override
  Future<void> addToCollection(String masterListeningId) async {
    final existing = await (db.select(db.userListenings)..where((t) => t.masterListeningId.equals(masterListeningId))).getSingleOrNull();
    if (existing == null) {
      await db.into(db.userListenings).insert(
        UserListeningsCompanion.insert(
          id: masterListeningId,
          masterListeningId: masterListeningId,
          isAdded: const Value(true),
          isFavorite: const Value(false),
          status: const Value('unlearned'),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      await (db.update(db.userListenings)..where((t) => t.masterListeningId.equals(masterListeningId))).write(
        UserListeningsCompanion(
          isAdded: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  @override
  Future<void> removeFromCollection(String masterListeningId) async {
    await (db.update(db.userListenings)..where((t) => t.masterListeningId.equals(masterListeningId))).write(
      UserListeningsCompanion(
        isAdded: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateBookmarkStatus(String masterListeningId, bool bookmarked) async {
    // Implicitly add to collection if bookmarked
    await addToCollection(masterListeningId);
    
    await (db.update(db.userListenings)..where((t) => t.masterListeningId.equals(masterListeningId))).write(
      UserListeningsCompanion(
        isFavorite: Value(bookmarked),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateStudyStatus(String masterListeningId, String status) async {
    await (db.update(db.userListenings)..where((t) => t.masterListeningId.equals(masterListeningId))).write(
      UserListeningsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateNotes(String masterListeningId, String notes) async {
    await (db.update(db.userListenings)..where((t) => t.masterListeningId.equals(masterListeningId))).write(
      UserListeningsCompanion(
        customNotes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
