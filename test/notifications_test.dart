import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/features/notifications/domain/models/notification_rule.dart';
import 'package:shinka_track_n3/features/notifications/domain/repositories/notification_repository.dart';
import 'package:shinka_track_n3/features/notifications/services/notification_engine.dart';

class InMemoryNotificationRepository implements NotificationRepository {
  final Map<String, dynamic> settings = {
    'quietHoursEnabled': false,
    'quietHoursStart': '22:00',
    'quietHoursEnd': '07:00',
    'studyEnabled': true,
    'reviewEnabled': true,
    'plannerEnabled': true,
    'achievementsEnabled': true,
  };
  final List<SmartNotification> pending = [];

  @override
  Future<Map<String, dynamic>> getNotificationSettings() async {
    return settings;
  }

  @override
  Future<void> saveNotificationSettings(Map<String, dynamic> updated) async {
    settings.addAll(updated);
  }

  @override
  Future<List<SmartNotification>> getPendingNotifications() async {
    return pending;
  }

  @override
  Future<void> addPendingNotification(SmartNotification notification) async {
    pending.removeWhere((n) => n.id == notification.id);
    pending.add(notification);
  }

  @override
  Future<void> clearPendingNotifications() async {
    pending.clear();
  }
}

void main() {
  late InMemoryNotificationRepository repository;
  late NotificationEngine engine;

  setUp(() {
    repository = InMemoryNotificationRepository();
    engine = NotificationEngine(repository);
  });

  group('SPEC-017: Smart Notification & Reminder System Tests', () {
    test('Quiet Hours boundaries evaluate correct time windows', () {
      // Standard daytime (outside quiet hours)
      final daytime = DateTime(2026, 7, 2, 14, 30); // 2:30 PM
      expect(engine.isQuietHours(daytime, '22:00', '07:00'), isFalse);

      // Nighttime (inside quiet hours spans midnight)
      final night = DateTime(2026, 7, 2, 23, 45); // 11:45 PM
      expect(engine.isQuietHours(night, '22:00', '07:00'), isTrue);

      // Early morning (inside quiet hours)
      final morning = DateTime(2026, 7, 2, 5, 15); // 5:15 AM
      expect(engine.isQuietHours(morning, '22:00', '07:00'), isTrue);
    });

    test('Quiet Hours postponing shifts scheduledTime correctly', () async {
      repository.settings['quietHoursEnabled'] = true;
      
      final target = DateTime(2026, 7, 2, 23, 0); // 11:00 PM (Quiet Hours)
      
      final notif = await engine.evaluateAndSchedule(
        id: 'n1',
        type: 'study',
        data: {'minutes': 30, 'topic': 'Kanji'},
        targetTime: target,
      );

      expect(notif, isNotNull);
      // End of quiet hours is 07:00, postponing adds 5 minutes = 7:05 AM
      expect(notif!.scheduledTime.hour, 7);
      expect(notif.scheduledTime.minute, 5);
    });

    test('Smart Study message formats correct minutes details', () async {
      final notif = await engine.evaluateAndSchedule(
        id: 'study1',
        type: 'study',
        data: {'minutes': 45, 'topic': 'Grammar'},
        targetTime: DateTime(2026, 7, 2, 12, 0),
      );

      expect(notif, isNotNull);
      expect(notif!.body.contains('45 minutes'), isTrue);
      expect(notif.body.contains('Grammar'), isTrue);
    });

    test('Smart Review message formats correct estimated duration', () async {
      final notif = await engine.evaluateAndSchedule(
        id: 'rev1',
        type: 'review',
        data: {'count': 18},
        targetTime: DateTime(2026, 7, 2, 12, 0),
      );

      expect(notif, isNotNull);
      expect(notif!.body.contains('18 reviews'), isTrue);
      expect(notif.body.contains('9 minutes'), isTrue); // 18 * 0.5 = 9
    });
  });
}
