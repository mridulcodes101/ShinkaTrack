import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/core/services/admin_service.dart';
import 'package:shinka_track_n3/features/settings/domain/repositories/settings_repository.dart';
import 'package:shinka_track_n3/features/settings/data/repositories/settings_repository_impl.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SettingsRepositoryImpl(sharedPrefs);
});

class SettingsNotifier extends StateNotifier<Map<String, dynamic>> {
  final SettingsRepository repository;

  SettingsNotifier(this.repository) : super({}) {
    _loadAll();
  }

  // Pre-seed all supported configurations
  Future<void> _loadAll() async {
    final Map<String, dynamic> config = {};
    // GENERAL
    config['settings_general_theme'] = await repository.getString('settings_general_theme', 'system');
    config['settings_general_color'] = await repository.getString('settings_general_color', 'indigo');
    config['settings_general_language'] = await repository.getString('settings_general_language', 'English');
    config['settings_general_animations'] = await repository.getString('settings_general_animations', 'Enabled');
    config['settings_general_fontSize'] = await repository.getString('settings_general_fontSize', 'Medium');

    // STUDY
    config['settings_study_goal_minutes'] = await repository.getInt('settings_study_goal_minutes', 15);
    config['settings_study_duration'] = await repository.getInt('settings_study_duration', 10);
    config['settings_study_preferred_time'] = await repository.getString('settings_study_preferred_time', '19:00');
    config['settings_study_preferred_modules'] = await repository.getStringList('settings_study_preferred_modules', ['Kanji', 'Vocabulary', 'Grammar']);
    config['settings_study_difficulty'] = await repository.getString('settings_study_difficulty', 'Normal');

    // REVIEW
    config['settings_review_limit'] = await repository.getInt('settings_review_limit', 50);
    config['settings_review_auto_start'] = await repository.getBool('settings_review_auto_start', false);
    config['settings_review_order'] = await repository.getString('settings_review_order', 'Due Date');
    config['settings_review_animation'] = await repository.getBool('settings_review_animation', true);

    // PLANNER
    config['settings_planner_exam_date'] = await repository.getString('settings_planner_exam_date', '2026-12-06');
    config['settings_planner_study_days'] = await repository.getStringList('settings_planner_study_days', ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']);
    config['settings_planner_available_time'] = await repository.getInt('settings_planner_available_time', 30);
    config['settings_planner_auto_redistribute'] = await repository.getBool('settings_planner_auto_redistribute', true);
    config['settings_planner_auto_recalculate'] = await repository.getBool('settings_planner_auto_recalculate', true);

    // READING
    config['settings_reading_fontSize'] = await repository.getDouble('settings_reading_fontSize', 14.0);
    config['settings_reading_lineHeight'] = await repository.getDouble('settings_reading_lineHeight', 1.5);
    config['settings_reading_theme'] = await repository.getString('settings_reading_theme', 'Light');
    config['settings_reading_furigana'] = await repository.getBool('settings_reading_furigana', true);
    config['settings_reading_translation'] = await repository.getBool('settings_reading_translation', true);
    config['settings_reading_highlight_vocab'] = await repository.getBool('settings_reading_highlight_vocab', true);
    config['settings_reading_highlight_grammar'] = await repository.getBool('settings_reading_highlight_grammar', true);
    config['settings_reading_highlight_kanji'] = await repository.getBool('settings_reading_highlight_kanji', true);

    // LISTENING
    config['settings_listening_speed'] = await repository.getDouble('settings_listening_speed', 1.0);
    config['settings_listening_autoScroll'] = await repository.getBool('settings_listening_autoScroll', true);
    config['settings_listening_repeatMode'] = await repository.getString('settings_listening_repeatMode', 'None');
    config['settings_listening_transcript'] = await repository.getBool('settings_listening_transcript', true);
    config['settings_listening_translation'] = await repository.getBool('settings_listening_translation', true);

    // DEVELOPER MODE
    config['settings_developer_enabled'] = await repository.getBool('settings_developer_enabled', false);

    state = config;
  }

  Future<void> updateSetting(String key, dynamic value) async {
    final updated = Map<String, dynamic>.from(state)..[key] = value;
    if (value is String) {
      await repository.setString(key, value);
    } else if (value is bool) {
      await repository.setBool(key, value);
    } else if (value is int) {
      await repository.setInt(key, value);
    } else if (value is double) {
      await repository.setDouble(key, value);
    } else if (value is List<String>) {
      await repository.setStringList(key, value);
    }
    state = updated;
  }

  Future<void> resetSection(String section) async {
    await repository.resetSection(section);
    await _loadAll();
  }

  Future<void> resetAll() async {
    await repository.resetAll();
    await _loadAll();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Map<String, dynamic>>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repo);
});
