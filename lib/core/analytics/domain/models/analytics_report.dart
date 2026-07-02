import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';

class AnalyticsReport {
  final DateTime startDate;
  final DateTime endDate;
  final String reportType; // daily, weekly, monthly, yearly, custom
  final int totalStudyTime; // seconds
  final int totalSessions;
  final double averageAccuracy;
  final Map<String, int> completedCountByModule; // e.g. {'kanji': 5, 'vocab': 12}
  final List<AnalyticsEvent> events;

  const AnalyticsReport({
    required this.startDate,
    required this.endDate,
    required this.reportType,
    required this.totalStudyTime,
    required this.totalSessions,
    required this.averageAccuracy,
    required this.completedCountByModule,
    required this.events,
  });
}
