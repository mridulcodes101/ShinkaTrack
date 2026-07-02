import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/features/settings/domain/repositories/settings_repository.dart';
import 'package:shinka_track_n3/features/settings/application/settings_notifier.dart';

class InMemorySettingsRepository implements SettingsRepository {
  final Map<String, dynamic> store = {};

  @override
  Future<String> getString(String key, String defaultValue) async {
    return store[key] as String? ?? defaultValue;
  }

  @override
  Future<void> setString(String key, String value) async {
    store[key] = value;
  }

  @override
  Future<bool> getBool(String key, bool defaultValue) async {
    return store[key] as bool? ?? defaultValue;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    store[key] = value;
  }

  @override
  Future<int> getInt(String key, int defaultValue) async {
    return store[key] as int? ?? defaultValue;
  }

  @override
  Future<void> setInt(String key, int value) async {
    store[key] = value;
  }

  @override
  Future<double> getDouble(String key, double defaultValue) async {
    return store[key] as double? ?? defaultValue;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    store[key] = value;
  }

  @override
  Future<List<String>> getStringList(String key, List<String> defaultValue) async {
    return store[key] as List<String>? ?? defaultValue;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    store[key] = value;
  }

  @override
  Future<void> resetSection(String section) async {
    store.removeWhere((k, v) => k.startsWith('settings_${section}_'));
  }

  @override
  Future<void> resetAll() async {
    store.removeWhere((k, v) => k.startsWith('settings_'));
  }
}

void main() {
  late InMemorySettingsRepository repository;
  late SettingsNotifier notifier;

  setUp(() {
    repository = InMemorySettingsRepository();
    notifier = SettingsNotifier(repository);
  });

  group('SPEC-018: Settings & Personalization Center Tests', () {
    test('Settings save and update notifier state reactively', () async {
      await notifier.updateSetting('settings_general_theme', 'dark');
      expect(notifier.state['settings_general_theme'], 'dark');

      await notifier.updateSetting('settings_study_goal_minutes', 45);
      expect(notifier.state['settings_study_goal_minutes'], 45);
    });

    test('Reset section clears only matching subset keys', () async {
      await notifier.updateSetting('settings_general_theme', 'dark');
      await notifier.updateSetting('settings_study_goal_minutes', 45);

      await notifier.resetSection('general');
      expect(notifier.state['settings_general_theme'], 'system'); // Reset to default
      expect(notifier.state['settings_study_goal_minutes'], 45); // Left untouched
    });

    test('Reset all clears all settings keys', () async {
      await notifier.updateSetting('settings_general_theme', 'dark');
      await notifier.updateSetting('settings_study_goal_minutes', 45);

      await notifier.resetAll();
      expect(notifier.state['settings_general_theme'], 'system');
      expect(notifier.state['settings_study_goal_minutes'], 15); // Reset to default
    });
  });
}
