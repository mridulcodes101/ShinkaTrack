import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';

abstract class AnalyticsRepository {
  Future<void> logEvent(AnalyticsEvent event);
  Future<List<AnalyticsEvent>> getEvents(DateTime start, DateTime end);
  Future<List<AnalyticsEvent>> getEventsByType(String eventType);
  Future<int> getStudyTimeSeconds(DateTime start, DateTime end);
  Future<int> getReviewCount(DateTime start, DateTime end);
  Future<double> getAccuracyRatio(DateTime start, DateTime end);
  Future<int> getLearnedCount(String contentType);
  Future<int> getCompletedCount(String contentType);
}
