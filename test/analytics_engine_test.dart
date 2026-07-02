import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';
import 'package:shinka_track_n3/core/analytics/domain/repositories/analytics_repository.dart';
import 'package:shinka_track_n3/core/analytics/services/analytics_engine.dart';

class InMemoryAnalyticsRepository implements AnalyticsRepository {
  final List<AnalyticsEvent> events = [];

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    events.add(event);
  }

  @override
  Future<List<AnalyticsEvent>> getEvents(DateTime start, DateTime end) async {
    return events.where((e) => !e.timestamp.isBefore(start) && !e.timestamp.isAfter(end)).toList();
  }

  @override
  Future<List<AnalyticsEvent>> getEventsByType(String eventType) async {
    return events.where((e) => e.eventType == eventType).toList();
  }

  @override
  Future<int> getStudyTimeSeconds(DateTime start, DateTime end) async {
    return events
        .where((e) => !e.timestamp.isBefore(start) && !e.timestamp.isAfter(end))
        .fold<int>(0, (sum, e) => sum + e.durationSeconds);
  }

  @override
  Future<int> getReviewCount(DateTime start, DateTime end) async {
    return events
        .where((e) => !e.timestamp.isBefore(start) && !e.timestamp.isAfter(end) && e.eventType == 'REVIEW_FINISHED')
        .length;
  }

  @override
  Future<double> getAccuracyRatio(DateTime start, DateTime end) async {
    final matches = events
        .where((e) => !e.timestamp.isBefore(start) && !e.timestamp.isAfter(end) && e.eventType == 'REVIEW_FINISHED');
    if (matches.isEmpty) return 0.0;
    return matches.where((e) => e.result == 'correct').length / matches.length;
  }

  @override
  Future<int> getLearnedCount(String contentType) async {
    return 10; // Mocked count
  }

  @override
  Future<int> getCompletedCount(String contentType) async {
    return 5; // Mocked count
  }
}

void main() {
  late InMemoryAnalyticsRepository repository;
  late AnalyticsEngine engine;

  setUp(() {
    repository = InMemoryAnalyticsRepository();
    engine = AnalyticsEngine(repository);
  });

  group('SPEC-015: Analytics Engine Tests', () {
    test('Logs events and processes aggregate study durations', () async {
      final now = DateTime.now();
      await engine.logEvent(AnalyticsEvent(
        id: 'e1',
        eventType: 'STUDY_FINISHED',
        timestamp: now.subtract(const Duration(minutes: 5)),
        durationSeconds: 300,
        result: 'success',
      ));

      await engine.logEvent(AnalyticsEvent(
        id: 'e2',
        eventType: 'REVIEW_FINISHED',
        timestamp: now.subtract(const Duration(minutes: 2)),
        durationSeconds: 120,
        result: 'correct',
      ));

      final todayStats = await engine.getTodayStatistics();
      expect(todayStats['studyTimeMinutes'], 7); // (300 + 120) / 60
      expect(todayStats['reviewCount'], 1);
    });

    test('Streak calculation counts consecutive active study days', () async {
      final now = DateTime.now();
      // Log study events for today, yesterday, and 2 days ago
      await engine.logEvent(AnalyticsEvent(
        id: 's1',
        eventType: 'STUDY_FINISHED',
        timestamp: now,
      ));
      await engine.logEvent(AnalyticsEvent(
        id: 's2',
        eventType: 'STUDY_FINISHED',
        timestamp: now.subtract(const Duration(days: 1)),
      ));
      await engine.logEvent(AnalyticsEvent(
        id: 's3',
        eventType: 'STUDY_FINISHED',
        timestamp: now.subtract(const Duration(days: 2)),
      ));

      final metrics = await engine.getMetrics();
      expect(metrics.currentStreak, 3);
      expect(metrics.longestStreak, 3);
    });

    test('CSV and JSON exports format events correctly', () async {
      final now = DateTime.now();
      await engine.logEvent(AnalyticsEvent(
        id: 'exp1',
        eventType: 'STUDY_FINISHED',
        timestamp: now.subtract(const Duration(hours: 1)),
        durationSeconds: 600,
        result: 'success',
      ));

      final start = now.subtract(const Duration(hours: 2));
      final end = now.add(const Duration(hours: 1));

      final jsonStr = await engine.exportAsJson(start, end);
      expect(jsonStr.contains('exp1'), isTrue);

      final csvStr = await engine.exportAsCsv(start, end);
      expect(csvStr.contains('exp1'), isTrue);
      expect(csvStr.contains('STUDY_FINISHED'), isTrue);
    });
  });
}
