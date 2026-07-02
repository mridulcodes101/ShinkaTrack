import 'package:shinka_track_n3/features/notifications/domain/models/notification_rule.dart';

abstract class NotificationRepository {
  Future<Map<String, dynamic>> getNotificationSettings();
  Future<void> saveNotificationSettings(Map<String, dynamic> settings);
  Future<List<SmartNotification>> getPendingNotifications();
  Future<void> addPendingNotification(SmartNotification notification);
  Future<void> clearPendingNotifications();
}
