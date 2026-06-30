import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  static const String _devModeUnlockedKey = 'shinka_dev_mode_unlocked';
  static const String _adminPasswordHashKey = 'shinka_admin_password_hash';
  static const String _adminSaltKey = 'shinka_admin_salt';

  final SharedPreferences _prefs;

  AdminService(this._prefs);

  // Checks if the developer mode has been unlocked by tapping 7 times
  bool isDeveloperModeUnlocked() {
    return _prefs.getBool(_devModeUnlockedKey) ?? false;
  }

  // Unlocks developer mode
  Future<void> unlockDeveloperMode() async {
    await _prefs.setBool(_devModeUnlockedKey, true);
  }

  // Checks if an admin password has been set up yet
  bool isPasswordCreated() {
    return _prefs.getString(_adminPasswordHashKey) != null;
  }

  // Creates the admin password securely
  Future<void> createPassword(String password) async {
    // Generate a simple deterministic salt based on microsecond timestamp
    final salt = DateTime.now().microsecondsSinceEpoch.toString();
    final hash = _hashPassword(password, salt);

    await _prefs.setString(_adminSaltKey, salt);
    await _prefs.setString(_adminPasswordHashKey, hash);
  }

  // Verifies the entered password
  bool verifyPassword(String password) {
    final salt = _prefs.getString(_adminSaltKey);
    final storedHash = _prefs.getString(_adminPasswordHashKey);
    if (salt == null || storedHash == null) return false;

    final inputHash = _hashPassword(password, salt);
    return storedHash == inputHash;
  }

  // FNV-1a 64-bit deterministic hash function for password security
  String _hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    var hash = 0xcbf29ce484222325; // FNV-1a basis
    for (var b in bytes) {
      hash ^= b;
      hash = (hash * 0x100000001b3) & 0xffffffffffffffff;
    }
    return hash.toRadixString(16);
  }
}

// Providers for Riverpod integration
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in ProviderScope');
});

final adminServiceProvider = Provider<AdminService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AdminService(prefs);
});

final developerModeUnlockedProvider = StateProvider<bool>((ref) {
  final service = ref.watch(adminServiceProvider);
  return service.isDeveloperModeUnlocked();
});
