import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';
import 'package:shinka_track_n3/core/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AppDatabase db;

  AnalyticsRepositoryImpl(this.db);

  AnalyticsEvent _mapEvent(AnalyticsEventData d) {
    Map<String, dynamic> decodeMetadata(String? val) {
      if (val == null || val.isEmpty) return {};
      try {
        final decoded = jsonDecode(val);
        if (decoded is Map) return decoded.cast<String, dynamic>();
      } catch (_) {}
      return {};
    }

    return AnalyticsEvent(
      id: d.id,
      eventType: d.eventType,
      contentType: d.contentType,
      contentId: d.contentId,
      timestamp: d.timestamp,
      durationSeconds: d.durationSeconds ?? 0,
      result: d.result ?? '',
      metadata: decodeMetadata(d.metadata),
    );
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    await db.into(db.analyticsEvents).insertOnConflictUpdate(
      AnalyticsEventsCompanion.insert(
        id: event.id,
        eventType: event.eventType,
        contentType: Value(event.contentType),
        contentId: Value(event.contentId),
        timestamp: event.timestamp,
        durationSeconds: Value(event.durationSeconds),
        result: Value(event.result),
        metadata: Value(jsonEncode(event.metadata)),
      ),
    );
  }

  @override
  Future<List<AnalyticsEvent>> getEvents(DateTime start, DateTime end) async {
    final query = db.select(db.analyticsEvents)
      ..where((tbl) => tbl.timestamp.isBetweenValues(start, end));
    final rows = await query.get();
    return rows.map(_mapEvent).toList();
  }

  @override
  Future<List<AnalyticsEvent>> getEventsByType(String eventType) async {
    final query = db.select(db.analyticsEvents)
      ..where((tbl) => tbl.eventType.equals(eventType));
    final rows = await query.get();
    return rows.map(_mapEvent).toList();
  }

  @override
  Future<int> getStudyTimeSeconds(DateTime start, DateTime end) async {
    final query = db.select(db.analyticsEvents)
      ..where((tbl) => 
        tbl.timestamp.isBetweenValues(start, end) & 
        (tbl.eventType.equals('STUDY_FINISHED') | tbl.eventType.equals('REVIEW_FINISHED'))
      );
    final rows = await query.get();
    return rows.fold(0, (sum, event) => sum + (event.durationSeconds ?? 0));
  }

  @override
  Future<int> getReviewCount(DateTime start, DateTime end) async {
    final query = db.select(db.analyticsEvents)
      ..where((tbl) => 
        tbl.timestamp.isBetweenValues(start, end) & 
        tbl.eventType.equals('REVIEW_FINISHED')
      );
    final rows = await query.get();
    return rows.length;
  }

  @override
  Future<double> getAccuracyRatio(DateTime start, DateTime end) async {
    final query = db.select(db.analyticsEvents)
      ..where((tbl) => 
        tbl.timestamp.isBetweenValues(start, end) & 
        tbl.eventType.equals('REVIEW_FINISHED')
      );
    final rows = await query.get();
    if (rows.isEmpty) return 0.0;
    
    int correct = 0;
    for (var r in rows) {
      if (r.result == 'correct' || r.result == 'Good' || r.result == 'Easy') {
        correct++;
      }
    }
    return correct / rows.length;
  }

  @override
  Future<int> getLearnedCount(String contentType) async {
    if (contentType == 'kanji') {
      final query = db.select(db.userKanjis)..where((tbl) => tbl.isLearned.equals(true));
      final rows = await query.get();
      return rows.length;
    } else if (contentType == 'vocab') {
      final query = db.select(db.userVocabularies)..where((tbl) => tbl.status.equals('mastered') | tbl.status.equals('learning'));
      final rows = await query.get();
      return rows.length;
    } else if (contentType == 'grammar') {
      final query = db.select(db.userGrammars)..where((tbl) => tbl.status.equals('mastered') | tbl.status.equals('learning'));
      final rows = await query.get();
      return rows.length;
    }
    return 0;
  }

  @override
  Future<int> getCompletedCount(String contentType) async {
    if (contentType == 'reading') {
      final query = db.select(db.userReadings)..where((tbl) => tbl.status.equals('completed'));
      final rows = await query.get();
      return rows.length;
    } else if (contentType == 'listening') {
      final query = db.select(db.userListenings)..where((tbl) => tbl.status.equals('completed'));
      final rows = await query.get();
      return rows.length;
    }
    return 0;
  }
}
