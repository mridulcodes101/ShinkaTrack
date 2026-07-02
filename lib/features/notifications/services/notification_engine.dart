import 'package:shinka_track_n3/features/notifications/domain/models/notification_rule.dart';
import 'package:shinka_track_n3/features/notifications/domain/repositories/notification_repository.dart';

class NotificationEngine {
  final NotificationRepository repository;

  NotificationEngine(this.repository);

  // Check if a given scheduled time falls within configured quiet hours
  bool isQuietHours(DateTime time, String quietStart, String quietEnd) {
    final partsStart = quietStart.split(':');
    final partsEnd = quietEnd.split(':');
    if (partsStart.length != 2 || partsEnd.length != 2) return false;

    final startHour = int.parse(partsStart[0]);
    final startMin = int.parse(partsStart[1]);
    final endHour = int.parse(partsEnd[0]);
    final endMin = int.parse(partsEnd[1]);

    final start = DateTime(time.year, time.month, time.day, startHour, startMin);
    var end = DateTime(time.year, time.month, time.day, endHour, endMin);

    if (end.isBefore(start)) {
      // Spans midnight
      final nextDayEnd = end.add(const Duration(days: 1));
      final prevDayStart = start.subtract(const Duration(days: 1));

      if (time.isAfter(start) && time.isBefore(nextDayEnd)) return true;
      if (time.isAfter(prevDayStart) && time.isBefore(end)) return true;
    } else {
      if (time.isAfter(start) && time.isBefore(end)) return true;
    }
    return false;
  }

  // Evaluate rules and schedule a notification if conditions are met
  Future<SmartNotification?> evaluateAndSchedule({
    required String id,
    required String type,
    required Map<String, dynamic> data,
    required DateTime targetTime,
  }) async {
    final settings = await repository.getNotificationSettings();

    // 1. Check if type toggle is enabled
    bool isEnabled = true;
    if (type == 'study') isEnabled = settings['studyEnabled'] as bool;
    if (type == 'review') isEnabled = settings['reviewEnabled'] as bool;
    if (type == 'planner') isEnabled = settings['plannerEnabled'] as bool;
    if (type == 'achievement') isEnabled = settings['achievementsEnabled'] as bool;

    if (!isEnabled) return null;

    // 2. Check Quiet Hours
    final bool quietEnabled = settings['quietHoursEnabled'] as bool;
    final String quietStart = settings['quietHoursStart'] as String;
    final String quietEnd = settings['quietHoursEnd'] as String;

    DateTime scheduled = targetTime;
    if (quietEnabled && isQuietHours(targetTime, quietStart, quietEnd)) {
      // Postpone notification to 5 minutes after Quiet Hours end
      final partsEnd = quietEnd.split(':');
      final endHour = int.parse(partsEnd[0]);
      final endMin = int.parse(partsEnd[1]);
      
      scheduled = DateTime(
        targetTime.year,
        targetTime.month,
        targetTime.day,
        endHour,
        endMin,
      ).add(const Duration(minutes: 5));

      if (scheduled.isBefore(targetTime)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }
    }

    // 3. Build Smart Messages
    String title = 'ShinkaTrack Alert';
    String body = 'Ready to continue your Japanese journey?';

    switch (type) {
      case 'study':
        final minutes = data['minutes'] as int? ?? 15;
        final topic = data['topic'] as String? ?? 'lessons';
        title = '📚 Smart Study Reminder';
        body = 'Good evening! You planned $minutes minutes of $topic today. Ready to continue?';
        break;

      case 'review':
        final count = data['count'] as int? ?? 0;
        final minutes = (count * 0.5).toStringAsFixed(0);
        title = '📝 Spaced Repetition Reviews';
        body = 'You have $count reviews waiting. Estimated time: $minutes minutes.';
        break;

      case 'achievement':
        final name = data['name'] as String? ?? 'N5 Kanji Master';
        final diff = data['diff'] as int? ?? 2;
        title = '🏆 Achievement Unlocked';
        body = 'You\'re only $diff Kanji away from unlocking "$name"! Keep going!';
        break;

      case 'planner':
        final topic = data['topic'] as String? ?? 'Reading';
        title = '📅 Planner Update';
        body = 'You skipped yesterday\'s $topic lesson. Today\'s study schedule has been updated.';
        break;
    }

    final notif = SmartNotification(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduled,
      type: type,
    );

    await repository.addPendingNotification(notif);
    return notif;
  }
}
