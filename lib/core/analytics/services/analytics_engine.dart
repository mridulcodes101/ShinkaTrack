import 'dart:convert';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_metrics.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_report.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/chart_data.dart';
import 'package:shinka_track_n3/core/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsEngine {
  final AnalyticsRepository repository;

  AnalyticsEngine(this.repository);

  // Log Event
  Future<void> logEvent(AnalyticsEvent event) async {
    await repository.logEvent(event);
  }

  // Calculate Streaks
  Future<Map<String, int>> _calculateStreaks() async {
    final events = await repository.getEvents(
      DateTime.now().subtract(const Duration(days: 365)),
      DateTime.now(),
    );

    if (events.isEmpty) {
      return {'current': 0, 'longest': 0};
    }

    // Extract unique study dates (yyyy-MM-dd format)
    final studyDates = events.map((e) {
      final t = e.timestamp;
      return DateTime(t.year, t.month, t.day);
    }).toSet().toList();

    studyDates.sort((a, b) => b.compareTo(a)); // Sort descending (newest first)

    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;

    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final yesterday = today.subtract(const Duration(days: 1));

    // Check if user studied today or yesterday to continue current streak
    if (studyDates.contains(today) || studyDates.contains(yesterday)) {
      DateTime checkDate = studyDates.contains(today) ? today : yesterday;
      while (studyDates.contains(checkDate)) {
        currentStreak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      }
    }

    // Calculate longest streak
    studyDates.sort((a, b) => a.compareTo(b)); // Sort ascending (oldest first)
    DateTime? prevDate;
    for (var date in studyDates) {
      if (prevDate == null) {
        tempStreak = 1;
      } else {
        final diff = date.difference(prevDate).inDays;
        if (diff == 1) {
          tempStreak++;
        } else if (diff > 1) {
          if (tempStreak > longestStreak) {
            longestStreak = tempStreak;
          }
          tempStreak = 1;
        }
      }
      prevDate = date;
    }

    if (tempStreak > longestStreak) {
      longestStreak = tempStreak;
    }

    return {
      'current': currentStreak,
      'longest': longestStreak > currentStreak ? longestStreak : currentStreak,
    };
  }

  // Compile full Metrics
  Future<AnalyticsMetrics> getMetrics() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekStart = now.subtract(const Duration(days: 7));
    final monthStart = now.subtract(const Duration(days: 30));
    final yearStart = now.subtract(const Duration(days: 365));

    final dailyStudy = await repository.getStudyTimeSeconds(todayStart, now);
    final weeklyStudy = await repository.getStudyTimeSeconds(weekStart, now);
    final monthlyStudy = await repository.getStudyTimeSeconds(monthStart, now);
    final yearlyStudy = await repository.getStudyTimeSeconds(yearStart, now);

    final reviews = await repository.getReviewCount(yearStart, now);
    final accuracy = await repository.getAccuracyRatio(yearStart, now);

    final streaks = await _calculateStreaks();

    final kanjiCount = await repository.getLearnedCount('kanji');
    final vocabCount = await repository.getLearnedCount('vocab');
    final grammarCount = await repository.getLearnedCount('grammar');

    return AnalyticsMetrics(
      dailyStudyTime: dailyStudy,
      weeklyStudyTime: weeklyStudy,
      monthlyStudyTime: monthlyStudy,
      yearlyStudyTime: yearlyStudy,
      currentStreak: streaks['current'] ?? 0,
      longestStreak: streaks['longest'] ?? 0,
      lessonsCompleted: kanjiCount + vocabCount + grammarCount,
      reviewsCompleted: reviews,
      accuracy: accuracy,
      averageSessionLength: dailyStudy > 0 ? dailyStudy / 2.0 : 0.0,
      averageReviewTime: 15.0,
      completionRate: 0.8,
      retentionRate: 0.85,
      learningVelocity: (kanjiCount + vocabCount + grammarCount) / 30.0,
    );
  }

  // Reports Generator
  Future<AnalyticsReport> generateReport(DateTime start, DateTime end, String type) async {
    final events = await repository.getEvents(start, end);
    final studyTime = await repository.getStudyTimeSeconds(start, end);
    final accuracy = await repository.getAccuracyRatio(start, end);

    final kanjiCount = await repository.getLearnedCount('kanji');
    final vocabCount = await repository.getLearnedCount('vocab');
    final grammarCount = await repository.getLearnedCount('grammar');

    return AnalyticsReport(
      startDate: start,
      endDate: end,
      reportType: type,
      totalStudyTime: studyTime,
      totalSessions: events.where((e) => e.eventType == 'STUDY_FINISHED').length,
      averageAccuracy: accuracy,
      completedCountByModule: {
        'kanji': kanjiCount,
        'vocab': vocabCount,
        'grammar': grammarCount,
      },
      events: events,
    );
  }

  // Heatmap Data (yyyy-MM-dd -> count)
  Future<Map<String, int>> getHeatmapData(DateTime start, DateTime end) async {
    final events = await repository.getEvents(start, end);
    final Map<String, int> heatmap = {};

    for (var e in events) {
      final dateStr = e.timestamp.toIso8601String().substring(0, 10);
      heatmap[dateStr] = (heatmap[dateStr] ?? 0) + 1;
    }
    return heatmap;
  }

  // Dashboard statistics
  Future<Map<String, dynamic>> getTodayStatistics() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final studyTime = await repository.getStudyTimeSeconds(todayStart, now);
    final reviews = await repository.getReviewCount(todayStart, now);
    final streaks = await _calculateStreaks();

    return {
      'studyTimeMinutes': (studyTime / 60.0).round(),
      'reviewCount': reviews,
      'currentStreak': streaks['current'] ?? 0,
      'completionPercentage': 0.75,
    };
  }

  // Generic Chart Data Trends
  Future<ChartData> getStudyTimeTrend(DateTime start, DateTime end) async {
    final events = await repository.getEvents(start, end);
    final points = <ChartPoint>[];

    // group study duration by date
    final dailyTotals = <String, int>{};
    for (var e in events) {
      final dateStr = e.timestamp.toIso8601String().substring(0, 10);
      dailyTotals[dateStr] = (dailyTotals[dateStr] ?? 0) + e.durationSeconds;
    }

    dailyTotals.forEach((date, duration) {
      points.add(ChartPoint(
        label: date,
        value: duration / 60.0, // minutes
      ));
    });

    return ChartData(
      title: 'Study Time Trend (Minutes)',
      chartType: 'line',
      points: points,
    );
  }

  // JSON Exporting
  Future<String> exportAsJson(DateTime start, DateTime end) async {
    final events = await repository.getEvents(start, end);
    final List<Map<String, dynamic>> jsonList = events.map((e) => {
      'id': e.id,
      'eventType': e.eventType,
      'contentType': e.contentType,
      'contentId': e.contentId,
      'timestamp': e.timestamp.toIso8601String(),
      'durationSeconds': e.durationSeconds,
      'result': e.result,
      'metadata': e.metadata,
    }).toList();

    return jsonEncode(jsonList);
  }

  // CSV Exporting
  Future<String> exportAsCsv(DateTime start, DateTime end) async {
    final events = await repository.getEvents(start, end);
    final buffer = StringBuffer();
    buffer.writeln('EventID,EventType,ContentType,ContentID,Timestamp,DurationSeconds,Result');

    for (var e in events) {
      buffer.writeln('${e.id},${e.eventType},${e.contentType ?? ""},${e.contentId ?? ""},${e.timestamp.toIso8601String()},${e.durationSeconds},${e.result}');
    }
    return buffer.toString();
  }
}
