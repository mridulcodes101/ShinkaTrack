import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/content/models/grammar_spec.dart';
import 'package:shinka_track_n3/features/grammar/domain/models/grammar_model.dart';
import 'package:shinka_track_n3/features/grammar/domain/repositories/grammar_repository.dart';

class GrammarRepositoryImpl implements GrammarRepository {
  final AppDatabase db;

  GrammarRepositoryImpl(this.db);

  List<GrammarExampleSpec> _parseGrammarExamples(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is List) {
        return decoded.map((e) => GrammarExampleSpec.fromJson(Map<String, dynamic>.from(e))).toList();
      }
    } catch (_) {}
    return [];
  }

  List<GrammarMistakeSpec> _parseGrammarMistakes(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is List) {
        return decoded.map((e) => GrammarMistakeSpec.fromJson(Map<String, dynamic>.from(e))).toList();
      }
    } catch (_) {}
    return [];
  }

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

  GrammarModel _mapRow(MasterGrammar m, UserGrammar? u) {
    final jlpt = m.jlptLevel ?? 3;
    
    // Compute dynamic difficulty proxy
    double computedDifficulty = 5.0;
    if (jlpt == 5 || jlpt == 4) {
      computedDifficulty = 2.0; // Easy
    } else if (jlpt == 3) {
      computedDifficulty = 5.0; // Medium
    } else if (jlpt == 2 || jlpt == 1) {
      computedDifficulty = 8.0; // Hard
    }

    final spec = GrammarSpec(
      id: m.id,
      grammarPattern: m.pattern,
      meaning: m.meaning,
      formation: m.formation ?? '',
      usage: m.usage ?? '',
      nuance: m.notes ?? '',
      formalLevel: '',
      jlpt: jlpt,
      examples: _parseGrammarExamples(m.examples),
      commonMistakes: _parseGrammarMistakes(m.commonMistakes),
      relatedGrammar: _parseJsonList(m.relatedGrammar),
      relatedVocabulary: const [],
      relatedKanji: const [],
      difficulty: computedDifficulty,
      tags: _parseJsonList(m.tags),
      createdAt: m.createdAt,
      updatedAt: m.updatedAt,
      status: m.status ?? 'Published',
      schemaVersion: 1,
      contentVersion: 1,
      lastUpdated: m.updatedAt,
      memoryTips: m.notes,
    );

    return GrammarModel(
      spec: spec,
      isAdded: u?.isAdded ?? false,
      isFavorite: u?.isFavorite ?? false,
      status: u?.status ?? 'unlearned',
      customNotes: u?.customNotes ?? '',
    );
  }

  @override
  Future<List<GrammarModel>> getMasterLibrary({
    List<int>? jlpt,
    String? difficultyBucket,
    String? query,
    bool? isAdded,
    int limit = 50,
    int offset = 0,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterGrammars).join([
      leftOuterJoin(db.userGrammars, db.userGrammars.masterGrammarId.equalsExp(db.masterGrammars.id)),
    ]);

    // Active filters
    queryBuilder.where(db.masterGrammars.status.isNotValue('Archived'));

    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterGrammars.jlptLevel.isIn(jlpt));
    }

    if (difficultyBucket != null) {
      if (difficultyBucket == 'Easy') {
        queryBuilder.where(db.masterGrammars.jlptLevel.isIn([5, 4]));
      } else if (difficultyBucket == 'Medium') {
        queryBuilder.where(db.masterGrammars.jlptLevel.equals(3));
      } else if (difficultyBucket == 'Hard') {
        queryBuilder.where(db.masterGrammars.jlptLevel.isIn([2, 1]));
      }
    }

    if (isAdded != null) {
      if (isAdded) {
        queryBuilder.where(db.userGrammars.isAdded.equals(true));
      } else {
        queryBuilder.where(db.userGrammars.id.isNull() | db.userGrammars.isAdded.equals(false));
      }
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterGrammars.pattern.like(pattern) |
        db.masterGrammars.meaning.lower().like(pattern) |
        db.masterGrammars.formation.lower().like(pattern) |
        db.masterGrammars.usage.lower().like(pattern) |
        db.masterGrammars.tags.lower().like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterGrammars.jlptLevel)]);
    } else if (sortBy == 'Difficulty') {
      // Difficulty correlates directly with JLPTLevel inverted (smaller JLPT level is harder)
      queryBuilder.orderBy([OrderingTerm.asc(db.masterGrammars.jlptLevel)]);
    } else if (sortBy == 'Recently Added') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterGrammars.createdAt)]);
    } else {
      // Default: Alphabetical by pattern
      queryBuilder.orderBy([OrderingTerm.asc(db.masterGrammars.pattern)]);
    }

    // Pagination
    queryBuilder.limit(limit, offset: offset);

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterGrammars);
      final u = row.readTableOrNull(db.userGrammars);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<List<GrammarModel>> getUserCollection({
    List<int>? jlpt,
    String? difficultyBucket,
    String? query,
    bool? favorite,
    String? status,
    String? sortBy,
  }) async {
    final queryBuilder = db.select(db.masterGrammars).join([
      innerJoin(db.userGrammars, db.userGrammars.masterGrammarId.equalsExp(db.masterGrammars.id)),
    ]);

    queryBuilder.where(db.userGrammars.isAdded.equals(true));

    if (jlpt != null && jlpt.isNotEmpty) {
      queryBuilder.where(db.masterGrammars.jlptLevel.isIn(jlpt));
    }
    if (difficultyBucket != null) {
      if (difficultyBucket == 'Easy') {
        queryBuilder.where(db.masterGrammars.jlptLevel.isIn([5, 4]));
      } else if (difficultyBucket == 'Medium') {
        queryBuilder.where(db.masterGrammars.jlptLevel.equals(3));
      } else if (difficultyBucket == 'Hard') {
        queryBuilder.where(db.masterGrammars.jlptLevel.isIn([2, 1]));
      }
    }
    if (favorite != null) {
      queryBuilder.where(db.userGrammars.isFavorite.equals(favorite));
    }
    if (status != null) {
      queryBuilder.where(db.userGrammars.status.equals(status));
    }

    if (query != null && query.isNotEmpty) {
      final pattern = '%${query.toLowerCase()}%';
      queryBuilder.where(
        db.masterGrammars.pattern.like(pattern) |
        db.masterGrammars.meaning.lower().like(pattern) |
        db.masterGrammars.formation.lower().like(pattern) |
        db.masterGrammars.usage.lower().like(pattern) |
        db.masterGrammars.tags.lower().like(pattern)
      );
    }

    // Sorting
    if (sortBy == 'JLPT') {
      queryBuilder.orderBy([OrderingTerm.desc(db.masterGrammars.jlptLevel)]);
    } else if (sortBy == 'Difficulty') {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterGrammars.jlptLevel)]);
    } else if (sortBy == 'Recently Added') {
      queryBuilder.orderBy([OrderingTerm.desc(db.userGrammars.createdAt)]);
    } else {
      queryBuilder.orderBy([OrderingTerm.asc(db.masterGrammars.pattern)]);
    }

    final rows = await queryBuilder.get();
    return rows.map((row) {
      final m = row.readTable(db.masterGrammars);
      final u = row.readTable(db.userGrammars);
      return _mapRow(m, u);
    }).toList();
  }

  @override
  Future<GrammarModel?> getGrammarDetails(String id) async {
    final queryBuilder = db.select(db.masterGrammars).join([
      leftOuterJoin(db.userGrammars, db.userGrammars.masterGrammarId.equalsExp(db.masterGrammars.id)),
    ]);
    queryBuilder.where(db.masterGrammars.id.equals(id));
    final row = await queryBuilder.getSingleOrNull();
    if (row == null) return null;
    return _mapRow(row.readTable(db.masterGrammars), row.readTableOrNull(db.userGrammars));
  }

  @override
  Future<void> addToCollection(String masterGrammarId) async {
    final existing = await (db.select(db.userGrammars)..where((t) => t.masterGrammarId.equals(masterGrammarId))).getSingleOrNull();
    if (existing == null) {
      await db.into(db.userGrammars).insert(
        UserGrammarsCompanion.insert(
          id: masterGrammarId,
          masterGrammarId: masterGrammarId,
          isAdded: const Value(true),
          isFavorite: const Value(false),
          status: const Value('unlearned'),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      await (db.update(db.userGrammars)..where((t) => t.masterGrammarId.equals(masterGrammarId))).write(
        UserGrammarsCompanion(
          isAdded: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  @override
  Future<void> removeFromCollection(String masterGrammarId) async {
    await (db.update(db.userGrammars)..where((t) => t.masterGrammarId.equals(masterGrammarId))).write(
      UserGrammarsCompanion(
        isAdded: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateFavoriteStatus(String masterGrammarId, bool favorite) async {
    await (db.update(db.userGrammars)..where((t) => t.masterGrammarId.equals(masterGrammarId))).write(
      UserGrammarsCompanion(
        isFavorite: Value(favorite),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateStudyStatus(String masterGrammarId, String status) async {
    await (db.update(db.userGrammars)..where((t) => t.masterGrammarId.equals(masterGrammarId))).write(
      UserGrammarsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateNotes(String masterGrammarId, String notes) async {
    await (db.update(db.userGrammars)..where((t) => t.masterGrammarId.equals(masterGrammarId))).write(
      UserGrammarsCompanion(
        customNotes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
