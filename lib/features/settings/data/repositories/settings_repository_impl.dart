import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences prefs;

  SettingsRepositoryImpl(this.prefs);

  @override
  Future<String> getString(String key, String defaultValue) async {
    return prefs.getString(key) ?? defaultValue;
  }

  @override
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<bool> getBool(String key, bool defaultValue) async {
    return prefs.getBool(key) ?? defaultValue;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  @override
  Future<int> getInt(String key, int defaultValue) async {
    return prefs.getInt(key) ?? defaultValue;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  @override
  Future<double> getDouble(String key, double defaultValue) async {
    return prefs.getDouble(key) ?? defaultValue;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  @override
  Future<List<String>> getStringList(String key, List<String> defaultValue) async {
    return prefs.getStringList(key) ?? defaultValue;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  @override
  Future<void> resetSection(String section) async {
    final keysToRemove = prefs.getKeys().where((k) => k.startsWith('settings_${section}_'));
    for (var k in keysToRemove) {
      await prefs.remove(k);
    }
  }

  @override
  Future<void> resetAll() async {
    final keysToRemove = prefs.getKeys().where((k) => k.startsWith('settings_'));
    for (var k in keysToRemove) {
      await prefs.remove(k);
    }
  }
}
