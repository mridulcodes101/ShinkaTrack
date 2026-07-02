abstract class SettingsRepository {
  Future<String> getString(String key, String defaultValue);
  Future<void> setString(String key, String value);
  Future<bool> getBool(String key, bool defaultValue);
  Future<void> setBool(String key, bool value);
  Future<int> getInt(String key, int defaultValue);
  Future<void> setInt(String key, int value);
  Future<double> getDouble(String key, double defaultValue);
  Future<void> setDouble(String key, double value);
  Future<List<String>> getStringList(String key, List<String> defaultValue);
  Future<void> setStringList(String key, List<String> value);
  Future<void> resetSection(String section);
  Future<void> resetAll();
}
