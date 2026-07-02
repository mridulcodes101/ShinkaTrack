import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/features/notifications/domain/models/notification_rule.dart';
import 'package:shinka_track_n3/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final SharedPreferences prefs;
  final List<SmartNotification> _inMemoryPending = [];

  NotificationRepositoryImpl(this.prefs);

  @override
  Future<Map<String, dynamic>> getNotificationSettings() async {
    return {
      'quietHoursEnabled': prefs.getBool('quiet_hours_enabled') ?? false,
      'quietHoursStart': prefs.getString('quiet_hours_start') ?? '22:00',
      'quietHoursEnd': prefs.getString('quiet_hours_end') ?? '07:00',
      'studyEnabled': prefs.getBool('reminders_study_enabled') ?? true,
      'reviewEnabled': prefs.getBool('reminders_review_enabled') ?? true,
      'plannerEnabled': prefs.getBool('reminders_planner_enabled') ?? true,
      'achievementsEnabled': prefs.getBool('reminders_achievements_enabled') ?? true,
    };
  }

  @override
  Future<void> saveNotificationSettings(Map<String, dynamic> settings) async {
    if (settings.containsKey('quietHoursEnabled')) {
      await prefs.setBool('quiet_hours_enabled', settings['quietHoursEnabled'] as bool);
    }
    if (settings.containsKey('quietHoursStart')) {
      await prefs.setString('quiet_hours_start', settings['quietHoursStart'] as String);
    }
    if (settings.containsKey('quietHoursEnd')) {
      await prefs.setString('quiet_hours_end', settings['quietHoursEnd'] as String);
    }
    if (settings.containsKey('studyEnabled')) {
      await prefs.setBool('reminders_study_enabled', settings['studyEnabled'] as bool);
    }
    if (settings.containsKey('reviewEnabled')) {
      await prefs.setBool('reminders_review_enabled', settings['reviewEnabled'] as bool);
    }
    if (settings.containsKey('plannerEnabled')) {
      await prefs.setBool('reminders_planner_enabled', settings['plannerEnabled'] as bool);
    }
    if (settings.containsKey('achievementsEnabled')) {
      await prefs.setBool('reminders_achievements_enabled', settings['achievementsEnabled'] as bool);
    }
  }

  @override
  Future<List<SmartNotification>> getPendingNotifications() async {
    // Return sorted pending notifications
    _inMemoryPending.removeWhere((n) => n.scheduledTime.isBefore(DateTime.now()));
    return List.from(_inMemoryPending);
  }

  @override
  Future<void> addPendingNotification(SmartNotification notification) async {
    _inMemoryPending.removeWhere((n) => n.id == notification.id);
    _inMemoryPending.add(notification);
  }

  @override
  Future<void> clearPendingNotifications() async {
    _inMemoryPending.clear();
  }
}
