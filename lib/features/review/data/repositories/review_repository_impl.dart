import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart' hide ReviewItem;
import 'package:shinka_track_n3/core/database/database.dart' as db_class show ReviewItem;
import 'package:shinka_track_n3/features/review/domain/models/review_item.dart';
import 'package:shinka_track_n3/features/review/domain/models/review_history.dart';
import 'package:shinka_track_n3/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final AppDatabase db;

  ReviewRepositoryImpl(this.db);

  // Sync active user items to ReviewItems table
  Future<void> _syncReviewItems() async {
    // 1. Kanji
    final activeKanjis = await (db.select(db.userKanjis)
          ..where((u) => u.isAdded.equals(true) | u.reviewCount.isBiggerThan(const Variable(0))))
        .get();
    for (var u in activeKanjis) {
      final m = await (db.select(db.masterKanjis)..where((x) => x.id.equals(u.masterKanjiId))).getSingleOrNull();
      if (m != null) {
        await _upsertReviewItemRow(
          id: 'kanji_${m.id}',
          type: 'kanji',
          itemId: m.id,
          nextDate: u.nextReview ?? DateTime.now(),
          lastDate: u.lastReviewed ?? DateTime.now(),
        );
      }
    }

    // 2. Vocab
    final activeVocabs = await (db.select(db.userVocabularies)
          ..where((u) => u.isAdded.equals(true) | u.reviewCount.isBiggerThan(const Variable(0))))
        .get();
    for (var u in activeVocabs) {
      final m = await (db.select(db.masterVocabularies)..where((x) => x.id.equals(u.masterVocabId))).getSingleOrNull();
      if (m != null) {
        await _upsertReviewItemRow(
          id: 'vocab_${m.id}',
          type: 'vocab',
          itemId: m.id,
          nextDate: u.nextReview ?? DateTime.now(),
          lastDate: u.lastReviewed ?? DateTime.now(),
        );
      }
    }

    // 3. Grammar
    final activeGrammars = await (db.select(db.userGrammars)
          ..where((u) => u.isAdded.equals(true)))
        .get();
    for (var u in activeGrammars) {
      final m = await (db.select(db.masterGrammars)..where((x) => x.id.equals(u.masterGrammarId))).getSingleOrNull();
      if (m != null) {
        await _upsertReviewItemRow(
          id: 'grammar_${m.id}',
          type: 'grammar',
          itemId: m.id,
          nextDate: DateTime.now(),
          lastDate: DateTime.now(),
        );
      }
    }

    // 4. Reading
    final activeReadings = await (db.select(db.userReadings)..where((u) => u.isAdded.equals(true))).get();
    for (var u in activeReadings) {
      final m = await (db.select(db.masterReadings)..where((x) => x.id.equals(u.masterReadingId))).getSingleOrNull();
      if (m != null) {
        await _upsertReviewItemRow(
          id: 'reading_${m.id}',
          type: 'reading',
          itemId: m.id,
          nextDate: DateTime.now(), // always due if completed
          lastDate: DateTime.now(),
        );
      }
    }

    // 5. Listening
    final activeListenings = await (db.select(db.userListenings)..where((u) => u.isAdded.equals(true))).get();
    for (var u in activeListenings) {
      final m = await (db.select(db.masterListenings)..where((x) => x.id.equals(u.masterListeningId))).getSingleOrNull();
      if (m != null) {
        await _upsertReviewItemRow(
          id: 'listening_${m.id}',
          type: 'listening',
          itemId: m.id,
          nextDate: DateTime.now(),
          lastDate: DateTime.now(),
        );
      }
    }
  }

  Future<void> _upsertReviewItemRow({
    required String id,
    required String type,
    required String itemId,
    required DateTime nextDate,
    required DateTime lastDate,
  }) async {
    final existing = await (db.select(db.reviewItems)..where((x) => x.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      await db.into(db.reviewItems).insert(
        ReviewItemsCompanion.insert(
          id: id,
          itemType: type,
          itemId: itemId,
          nextReviewDate: nextDate,
          lastReviewDate: lastDate,
          stage: const Value(0),
        ),
      );
    }
  }

  Future<ReviewItem?> _mapDriftToDomain(db_class.ReviewItem d) async {
    String title = '';
    String subtitle = '';
    String preview = '';
    double difficulty = 1.0;
    String reviewState = 'learning';
    int reviewCount = 0;
    int correctCount = 0;
    int incorrectCount = 0;
    double easeFactor = 2.5;
    int interval = 0;

    if (d.itemType == 'kanji') {
      final m = await (db.select(db.masterKanjis)..where((x) => x.id.equals(d.itemId))).getSingleOrNull();
      final u = await (db.select(db.userKanjis)..where((x) => x.masterKanjiId.equals(d.itemId))).getSingleOrNull();
      if (m != null) {
        title = m.kanji;
        subtitle = m.meaning;
        preview = m.onYomi.isNotEmpty ? m.onYomi : (m.kunYomi.isNotEmpty ? m.kunYomi : '');
        reviewState = u?.isLearned == true ? 'mastered' : 'learning';
        reviewCount = u?.reviewCount ?? 0;
      }
    } else if (d.itemType == 'vocab') {
      final m = await (db.select(db.masterVocabularies)..where((x) => x.id.equals(d.itemId))).getSingleOrNull();
      final u = await (db.select(db.userVocabularies)..where((x) => x.masterVocabId.equals(d.itemId))).getSingleOrNull();
      if (m != null) {
        title = m.word;
        subtitle = m.meaning;
        preview = m.kana;
        reviewState = u?.status == 'mastered' ? 'mastered' : 'learning';
        reviewCount = u?.reviewCount ?? 0;
      }
    } else if (d.itemType == 'grammar') {
      final m = await (db.select(db.masterGrammars)..where((x) => x.id.equals(d.itemId))).getSingleOrNull();
      final u = await (db.select(db.userGrammars)..where((x) => x.masterGrammarId.equals(d.itemId))).getSingleOrNull();
      if (m != null) {
        title = m.pattern;
        subtitle = m.meaning;
        preview = m.formation ?? '';
        reviewState = u?.status == 'mastered' ? 'mastered' : 'learning';
        reviewCount = 0;
      }
    } else if (d.itemType == 'reading') {
      final m = await (db.select(db.masterReadings)..where((x) => x.id.equals(d.itemId))).getSingleOrNull();
      final u = await (db.select(db.userReadings)..where((x) => x.masterReadingId.equals(d.itemId))).getSingleOrNull();
      if (m != null) {
        title = m.title;
        subtitle = 'Reading Passage';
        preview = m.passage;
        reviewState = u?.status == 'completed' ? 'mastered' : 'learning';
      }
    } else if (d.itemType == 'listening') {
      final m = await (db.select(db.masterListenings)..where((x) => x.id.equals(d.itemId))).getSingleOrNull();
      final u = await (db.select(db.userListenings)..where((x) => x.masterListeningId.equals(d.itemId))).getSingleOrNull();
      if (m != null) {
        title = m.title;
        subtitle = 'Listening Lesson';
        preview = m.transcript;
        reviewState = u?.status == 'completed' ? 'mastered' : 'learning';
      }
    }

    return ReviewItem(
      id: d.id,
      contentType: d.itemType,
      masterContentId: d.itemId,
      userContentId: d.id,
      title: title,
      subtitle: subtitle,
      preview: preview,
      difficulty: difficulty,
      reviewState: reviewState,
      nextReview: d.nextReviewDate,
      lastReview: d.lastReviewDate,
      reviewCount: reviewCount,
      correctCount: correctCount,
      incorrectCount: incorrectCount,
      easeFactor: easeFactor,
      interval: interval,
      createdAt: d.lastReviewDate,
      updatedAt: d.nextReviewDate,
    );
  }

  @override
  Future<List<ReviewItem>> getDueReviewItems() async {
    await _syncReviewItems();
    final now = DateTime.now();
    final rows = await (db.select(db.reviewItems)
          ..where((x) => x.nextReviewDate.isSmallerOrEqualValue(now)))
        .get();

    final List<ReviewItem> list = [];
    for (var r in rows) {
      final mapped = await _mapDriftToDomain(r);
      if (mapped != null) list.add(mapped);
    }
    return list;
  }

  @override
  Future<List<ReviewItem>> getOverdueReviewItems() async {
    await _syncReviewItems();
    final cutoff = DateTime.now().subtract(const Duration(days: 1));
    final rows = await (db.select(db.reviewItems)
          ..where((x) => x.nextReviewDate.isSmallerOrEqualValue(cutoff)))
        .get();

    final List<ReviewItem> list = [];
    for (var r in rows) {
      final mapped = await _mapDriftToDomain(r);
      if (mapped != null) list.add(mapped);
    }
    return list;
  }

  @override
  Future<List<ReviewItem>> getUpcomingReviewItems({int limit = 50}) async {
    await _syncReviewItems();
    final now = DateTime.now();
    final rows = await (db.select(db.reviewItems)
          ..where((x) => x.nextReviewDate.isBiggerThanValue(now))
          ..orderBy([(x) => OrderingTerm.asc(x.nextReviewDate)])
          ..limit(limit))
        .get();

    final List<ReviewItem> list = [];
    for (var r in rows) {
      final mapped = await _mapDriftToDomain(r);
      if (mapped != null) list.add(mapped);
    }
    return list;
  }

  @override
  Future<List<ReviewItem>> getWeakItems({int limit = 10}) async {
    // Sort items by low stage or failed count in history
    final rows = await (db.select(db.reviewItems)
          ..orderBy([(x) => OrderingTerm.asc(x.stage)])
          ..limit(limit))
        .get();

    final List<ReviewItem> list = [];
    for (var r in rows) {
      final mapped = await _mapDriftToDomain(r);
      if (mapped != null) list.add(mapped);
    }
    return list;
  }

  @override
  Future<List<ReviewItem>> getRecentlyFailedItems({int limit = 10}) async {
    final recentHistory = await (db.select(db.reviewHistoryRecords)
          ..where((x) => x.result.equals('incorrect') | x.result.equals('Again'))
          ..orderBy([(x) => OrderingTerm.desc(x.timestamp)])
          ..limit(limit))
        .get();

    final List<ReviewItem> list = [];
    for (var h in recentHistory) {
      final rRow = await (db.select(db.reviewItems)..where((x) => x.itemId.equals(h.itemId))).getSingleOrNull();
      if (rRow != null) {
        final mapped = await _mapDriftToDomain(rRow);
        if (mapped != null) list.add(mapped);
      }
    }
    return list;
  }

  @override
  Future<List<ReviewHistory>> getReviewHistory({
    String? query,
    String? resultFilter,
    int limit = 50,
    int offset = 0,
  }) async {
    final queryBuilder = db.select(db.reviewHistoryRecords);

    if (resultFilter != null) {
      queryBuilder.where((x) => x.result.equals(resultFilter));
    }

    queryBuilder.orderBy([(x) => OrderingTerm.desc(x.timestamp)]);
    queryBuilder.limit(limit, offset: offset);

    final rows = await queryBuilder.get();
    return rows.map((r) => ReviewHistory(
          id: r.id,
          itemId: r.itemId,
          itemType: r.itemType,
          timestamp: r.timestamp,
          result: r.result,
          timeTakenSeconds: r.timeTakenSeconds,
          prevInterval: r.prevInterval,
          nextInterval: r.nextInterval,
        )).toList();
  }

  @override
  Future<Map<String, dynamic>> getReviewStatistics() async {
    final totalHistory = await db.select(db.reviewHistoryRecords).get();
    final correct = totalHistory.where((h) => h.result == 'correct' || h.result == 'Good' || h.result == 'Easy').length;
    final total = totalHistory.length;
    final accuracy = total > 0 ? (correct / total) * 100 : 100.0;

    final due = await getDueReviewItems();

    return {
      'totalReviews': total,
      'dueCount': due.length,
      'accuracy': accuracy,
      'currentStreak': 3, // mock streak
      'longestStreak': 7,
    };
  }

  @override
  Future<void> logReviewHistory(ReviewHistory history) async {
    await db.into(db.reviewHistoryRecords).insert(
      ReviewHistoryRecordsCompanion.insert(
        id: history.id,
        itemId: history.itemId,
        itemType: history.itemType,
        timestamp: history.timestamp,
        result: history.result,
        timeTakenSeconds: history.timeTakenSeconds,
        prevInterval: history.prevInterval,
        nextInterval: history.nextInterval,
      ),
    );
  }

  @override
  Future<void> updateReviewItemState({
    required String itemId,
    required String itemType,
    required String rating,
    required bool isCorrect,
    required int durationSeconds,
  }) async {
    final now = DateTime.now();
    
    // Generic review spacing math
    int nextIntervalDays = 1;
    if (rating == 'Easy') {
      nextIntervalDays = 7;
    } else if (rating == 'Good') {
      nextIntervalDays = 3;
    } else if (rating == 'Again') {
      nextIntervalDays = 1;
    }
    
    final nextDate = now.add(Duration(days: nextIntervalDays));

    // Update generic ReviewItems table
    final key = '${itemType}_$itemId';
    final existing = await (db.select(db.reviewItems)..where((x) => x.id.equals(key))).getSingleOrNull();
    if (existing != null) {
      final nextStage = isCorrect ? (existing.stage + 1).clamp(0, 6) : 0;
      await (db.update(db.reviewItems)..where((x) => x.id.equals(key))).write(
        ReviewItemsCompanion(
          stage: Value(nextStage),
          nextReviewDate: Value(nextDate),
          lastReviewDate: Value(now),
        ),
      );
    }

    // Update module-specific tables
    if (itemType == 'kanji') {
      final u = await (db.select(db.userKanjis)..where((x) => x.masterKanjiId.equals(itemId))).getSingleOrNull();
      if (u != null) {
        await (db.update(db.userKanjis)..where((x) => x.masterKanjiId.equals(itemId))).write(
          UserKanjisCompanion(
            reviewCount: Value(u.reviewCount + 1),
            nextReview: Value(nextDate),
            lastReviewed: Value(now),
            isLearned: Value(isCorrect),
          ),
        );
      }
    } else if (itemType == 'vocab') {
      final u = await (db.select(db.userVocabularies)..where((x) => x.masterVocabId.equals(itemId))).getSingleOrNull();
      if (u != null) {
        await (db.update(db.userVocabularies)..where((x) => x.masterVocabId.equals(itemId))).write(
          UserVocabulariesCompanion(
            reviewCount: Value(u.reviewCount + 1),
            nextReview: Value(nextDate),
            lastReviewed: Value(now),
            status: Value(isCorrect ? 'mastered' : 'learning'),
          ),
        );
      }
    } else if (itemType == 'grammar') {
      final u = await (db.select(db.userGrammars)..where((x) => x.masterGrammarId.equals(itemId))).getSingleOrNull();
      if (u != null) {
        await (db.update(db.userGrammars)..where((x) => x.masterGrammarId.equals(itemId))).write(
          UserGrammarsCompanion(
            status: Value(isCorrect ? 'mastered' : 'learning'),
          ),
        );
      }
    }
  }
}
