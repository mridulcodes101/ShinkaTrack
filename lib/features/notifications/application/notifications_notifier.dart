import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/notifications/domain/models/notification_rule.dart';
import 'package:shinka_track_n3/features/notifications/domain/repositories/notification_repository.dart';
import 'package:shinka_track_n3/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:shinka_track_n3/features/notifications/services/notification_engine.dart';
import 'package:shinka_track_n3/core/services/admin_service.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return NotificationRepositoryImpl(sharedPrefs);
});

final notificationEngineProvider = Provider<NotificationEngine>((ref) {
  final repo = ref.watch(notificationRepositoryProvider);
  return NotificationEngine(repo);
});

final pendingNotificationsProvider = FutureProvider.autoDispose<List<SmartNotification>>((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getPendingNotifications();
});

class NotificationSettingsNotifier extends StateNotifier<Map<String, dynamic>> {
  final NotificationRepository repository;

  NotificationSettingsNotifier(this.repository) : super({}) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final s = await repository.getNotificationSettings();
    state = s;
  }

  Future<void> updateSetting(String key, dynamic value) async {
    final updated = Map<String, dynamic>.from(state)..[key] = value;
    await repository.saveNotificationSettings(updated);
    state = updated;
  }
}

final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, Map<String, dynamic>>((ref) {
  final repo = ref.watch(notificationRepositoryProvider);
  return NotificationSettingsNotifier(repo);
});
