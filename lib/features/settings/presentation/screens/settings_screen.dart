import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_planner_providers.dart';
import 'package:shinka_track_n3/core/services/notification_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Notifications state
  int _studyHour = 19;
  int _studyMinute = 0;
  bool _morningEnabled = true;
  bool _studyEnabled = true;
  bool _reviewEnabled = true;
  bool _missedEnabled = true;
  bool _weeklyEnabled = true;

  // Custom Preferences state
  int _dailyGoalMinutes = 15;
  int _dailyGoalItems = 10;
  double _plannerHours = 1.0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final config = await NotificationService.getConfig();
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _studyHour = config['studyHour'] as int;
      _studyMinute = config['studyMinute'] as int;
      _morningEnabled = config['morningEnabled'] as bool;
      _studyEnabled = config['studyEnabled'] as bool;
      _reviewEnabled = config['reviewEnabled'] as bool;
      _missedEnabled = config['missedEnabled'] as bool;
      _weeklyEnabled = config['weeklyEnabled'] as bool;

      _dailyGoalMinutes = prefs.getInt('settings_daily_goal_minutes') ?? 15;
      _dailyGoalItems = prefs.getInt('settings_daily_goal_items') ?? 10;
      _plannerHours = prefs.getDouble('settings_study_hours') ?? 1.0;
    });
  }

  // --- ACTIONS ---

  void _updateThemeMode(ThemeMode mode) async {
    ref.read(themeModeProvider.notifier).state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
  }

  void _updateThemeColor(String colorKey) async {
    ref.read(themeColorProvider.notifier).state = colorKey;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_color', colorKey);
  }

  void _updateFontSize(double scale) async {
    ref.read(fontSizeProvider.notifier).state = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size_scale', scale);
  }

  void _toggleReminder(String type, bool value) async {
    if (value) {
      await NotificationService.requestPermissions();
    }
    await NotificationService.setToggle(type, value);
    _loadSettings();
  }

  void _selectStudyTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _studyHour, minute: _studyMinute),
    );
    if (picked != null) {
      await NotificationService.requestPermissions();
      await NotificationService.saveStudyTime(picked.hour, picked.minute);
      _loadSettings();
    }
  }

  void _updateDailyGoalMinutes(int mins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('settings_daily_goal_minutes', mins);
    _loadSettings();
    ref.invalidate(dailyGoalProvider);
  }

  void _updateDailyGoalItems(int items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('settings_daily_goal_items', items);
    _loadSettings();
    ref.invalidate(dailyGoalProvider);
  }

  void _updatePlannerHours(double hours) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('settings_study_hours', hours);
    final repo = ref.read(repositoryProvider);
    await repo.updateActivePlanHours(hours);
    _loadSettings();
    ref.invalidate(activePlanProvider);
  }

  // --- DATA MANAGEMENT ---

  void _exportJson() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final repo = ref.read(repositoryProvider);
      final jsonStr = await repo.exportBackupJson();
      await Clipboard.setData(ClipboardData(text: jsonStr));

      messenger.showSnackBar(
        const SnackBar(content: Text('Backup JSON copied to clipboard! Save it somewhere safe.')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to export: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _importJson() {
    final messenger = ScaffoldMessenger.of(context);
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Import Backup JSON'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Paste your backup JSON content below to restore all progress:'),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '{"kanjis": [...], ...}',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final text = controller.text.trim();
                if (text.isEmpty) return;

                Navigator.pop(dialogContext);
                try {
                  final repo = ref.read(repositoryProvider);
                  await repo.importBackupJson(text);

                  // Reload all state providers
                  ref.invalidate(kanjiListProvider);
                  ref.invalidate(vocabListProvider);
                  ref.invalidate(grammarListProvider);
                  ref.invalidate(dailyGoalProvider);
                  ref.invalidate(studySessionsProvider);
                  ref.invalidate(activePlanProvider);

                  messenger.showSnackBar(
                    const SnackBar(content: Text('Data backup imported successfully!')),
                  );
                } catch (e) {
                  messenger.showSnackBar(
                    SnackBar(content: Text('Import failed: $e'), backgroundColor: Colors.red),
                  );
                }
              },
              child: const Text('Import Data'),
            ),
          ],
        );
      },
    );
  }

  void _backupDatabase() async {
    final messenger = ScaffoldMessenger.of(context);
    if (kIsWeb) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Database backup file copies are only supported on native platforms. Please use Export JSON on web.')),
      );
      return;
    }

    try {
      final docFolder = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(docFolder.path, 'shinka_track_n3.db'));
      final backupFile = File(p.join(docFolder.path, 'shinka_track_n3_backup.db'));

      if (await dbFile.exists()) {
        await dbFile.copy(backupFile.path);
        messenger.showSnackBar(
          const SnackBar(content: Text('Database binary file backup successful!')),
        );
      } else {
        throw Exception('Source database file not found.');
      }
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Backup failed: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _restoreDatabase() async {
    final messenger = ScaffoldMessenger.of(context);
    if (kIsWeb) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Database restore file copies are only supported on native platforms. Please use Import JSON on web.')),
      );
      return;
    }

    try {
      final docFolder = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(docFolder.path, 'shinka_track_n3.db'));
      final backupFile = File(p.join(docFolder.path, 'shinka_track_n3_backup.db'));

      if (await backupFile.exists()) {
        // Safe copy
        await backupFile.copy(dbFile.path);

        // Invalidate providers
        ref.invalidate(kanjiListProvider);
        ref.invalidate(vocabListProvider);
        ref.invalidate(grammarListProvider);
        ref.invalidate(dailyGoalProvider);
        ref.invalidate(studySessionsProvider);
        ref.invalidate(activePlanProvider);

        messenger.showSnackBar(
          const SnackBar(content: Text('Database binary file restored successfully!')),
        );
      } else {
        throw Exception('Backup database file does not exist.');
      }
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Restore failed: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _confirmReset(BuildContext parentContext, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(parentContext);
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset All Progress?'),
          content: const Text(
            'This action will reset all your learned Kanji, Vocabulary, and Grammar points to "Unlearned", and delete your entire study session and quiz history.\n\nThis cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                final repo = ref.read(repositoryProvider);
                await repo.resetAllProgress();

                // Reload the providers to sync state
                ref.invalidate(kanjiListProvider);
                ref.invalidate(vocabListProvider);
                ref.invalidate(grammarListProvider);
                ref.invalidate(dailyGoalProvider);
                ref.invalidate(studySessionsProvider);
                ref.invalidate(activePlanProvider);

                messenger.showSnackBar(
                  const SnackBar(content: Text('All progress and study records have been reset.')),
                );
              },
              child: const Text(
                'Reset Progress',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- BUILD METHOD ---

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              // 1. APPEARANCE & THEME
              const Text(
                'Appearance & Theme',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      // Dark Mode settings
                      RadioListTile<ThemeMode>(
                        title: const Text('System Default Theme'),
                        value: ThemeMode.system,
                        groupValue: themeMode,
                        onChanged: (mode) => _updateThemeMode(mode!),
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Light Mode'),
                        value: ThemeMode.light,
                        groupValue: themeMode,
                        onChanged: (mode) => _updateThemeMode(mode!),
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Dark Mode'),
                        value: ThemeMode.dark,
                        groupValue: themeMode,
                        onChanged: (mode) => _updateThemeMode(mode!),
                      ),
                      const Divider(height: 24),
                      // Theme Color selection
                      ListTile(
                        title: const Text('App Color Theme'),
                        subtitle: Text('Selected: ${themeColor.substring(0, 1).toUpperCase()}${themeColor.substring(1)}'),
                        trailing: DropdownButton<String>(
                          value: themeColor,
                          underline: const SizedBox(),
                          onChanged: (val) => _updateThemeColor(val!),
                          items: const [
                            DropdownMenuItem(value: 'indigo', child: Text('Samurai Indigo')),
                            DropdownMenuItem(value: 'pink', child: Text('Sakura Pink')),
                            DropdownMenuItem(value: 'gold', child: Text('Kinpaku Gold')),
                            DropdownMenuItem(value: 'green', child: Text('Forest Green')),
                            DropdownMenuItem(value: 'violet', child: Text('Royal Violet')),
                          ],
                        ),
                      ),
                      const Divider(height: 24),
                      // Font size scaler selection
                      ListTile(
                        title: const Text('App Text Scale'),
                        subtitle: Text('Current: ${fontSize == 0.8 ? "Small" : fontSize == 1.0 ? "Medium" : fontSize == 1.2 ? "Large" : "Extra Large"}'),
                        trailing: DropdownButton<double>(
                          value: fontSize,
                          underline: const SizedBox(),
                          onChanged: (val) => _updateFontSize(val!),
                          items: const [
                            DropdownMenuItem(value: 0.8, child: Text('Small (80%)')),
                            DropdownMenuItem(value: 1.0, child: Text('Medium (100%)')),
                            DropdownMenuItem(value: 1.2, child: Text('Large (120%)')),
                            DropdownMenuItem(value: 1.4, child: Text('Extra Large (140%)')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. STUDY GOALS & PLANNER CONFIG
              const Text(
                'Daily Targets & Study Hours',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Daily Target Study Time'),
                        trailing: DropdownButton<int>(
                          value: _dailyGoalMinutes,
                          underline: const SizedBox(),
                          onChanged: (val) => _updateDailyGoalMinutes(val!),
                          items: const [
                            DropdownMenuItem(value: 10, child: Text('10 minutes')),
                            DropdownMenuItem(value: 15, child: Text('15 minutes')),
                            DropdownMenuItem(value: 30, child: Text('30 minutes')),
                            DropdownMenuItem(value: 45, child: Text('45 minutes')),
                            DropdownMenuItem(value: 60, child: Text('60 minutes')),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text('Daily Target Mastered Items'),
                        trailing: DropdownButton<int>(
                          value: _dailyGoalItems,
                          underline: const SizedBox(),
                          onChanged: (val) => _updateDailyGoalItems(val!),
                          items: const [
                            DropdownMenuItem(value: 5, child: Text('5 items')),
                            DropdownMenuItem(value: 10, child: Text('10 items')),
                            DropdownMenuItem(value: 15, child: Text('15 items')),
                            DropdownMenuItem(value: 20, child: Text('20 items')),
                            DropdownMenuItem(value: 30, child: Text('30 items')),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text('Planner Daily Study Hours'),
                        trailing: DropdownButton<double>(
                          value: _plannerHours,
                          underline: const SizedBox(),
                          onChanged: (val) => _updatePlannerHours(val!),
                          items: const [
                            DropdownMenuItem(value: 0.5, child: Text('0.5 hours')),
                            DropdownMenuItem(value: 1.0, child: Text('1.0 hours')),
                            DropdownMenuItem(value: 1.5, child: Text('1.5 hours')),
                            DropdownMenuItem(value: 2.0, child: Text('2.0 hours')),
                            DropdownMenuItem(value: 3.0, child: Text('3.0 hours')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. REMINDERS & NOTIFICATIONS
              const Text(
                'Reminders & Notifications',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Morning Reminder'),
                        subtitle: const Text('Start learning early at 8:00 AM'),
                        value: _morningEnabled,
                        onChanged: (val) => _toggleReminder('morning', val),
                      ),
                      SwitchListTile(
                        title: const Text('Daily Study Time Reminder'),
                        subtitle: const Text('Get notified to complete daily hours'),
                        value: _studyEnabled,
                        onChanged: (val) => _toggleReminder('study', val),
                      ),
                      ListTile(
                        enabled: _studyEnabled,
                        title: const Text('Daily Study Time'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _studyEnabled ? Theme.of(context).primaryColor.withValues(alpha: 0.12) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_studyHour.toString().padLeft(2, '0')}:${_studyMinute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _studyEnabled ? Theme.of(context).primaryColor : Colors.grey,
                            ),
                          ),
                        ),
                        onTap: _studyEnabled ? _selectStudyTime : null,
                      ),
                      SwitchListTile(
                        title: const Text('Spaced Repetition Review Alerts'),
                        subtitle: const Text('Notify when review sessions are due'),
                        value: _reviewEnabled,
                        onChanged: (val) => _toggleReminder('review', val),
                      ),
                      SwitchListTile(
                        title: const Text('Inactivity & Streak Reminder'),
                        subtitle: const Text('Alert 36 hours after your last session'),
                        value: _missedEnabled,
                        onChanged: (val) => _toggleReminder('missed', val),
                      ),
                      SwitchListTile(
                        title: const Text('Weekly Sunday Review Reminder'),
                        subtitle: const Text('Sunday reminder at 9:00 AM for weekly reviews'),
                        value: _weeklyEnabled,
                        onChanged: (val) => _toggleReminder('weekly', val),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 4. DATA BACKUP & DATABASE MANAGEMENT
              const Text(
                'Data Import, Export & Backups',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Export JSON Data'),
                        subtitle: const Text('Serialize and copy study data string'),
                        onTap: _exportJson,
                      ),
                      ListTile(
                        leading: const Icon(Icons.download),
                        title: const Text('Import JSON Data'),
                        subtitle: const Text('Paste backup text to restore progress'),
                        onTap: _importJson,
                      ),
                      const Divider(height: 16),
                      ListTile(
                        leading: const Icon(Icons.backup),
                        title: const Text('Backup DB Binary File'),
                        subtitle: const Text('Backup local SQLite db file (Native only)'),
                        onTap: _backupDatabase,
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings_backup_restore),
                        title: const Text('Restore DB Binary File'),
                        subtitle: const Text('Restore local SQLite db file (Native only)'),
                        onTap: _restoreDatabase,
                      ),
                      const Divider(height: 16),
                      ListTile(
                        leading: const Icon(Icons.delete_forever, color: Colors.red),
                        title: const Text('Reset All Progress', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                        subtitle: const Text('Clear all saved progress and histories'),
                        onTap: () => _confirmReset(context, ref),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 5. ABOUT APP & LICENSES
              const Text(
                'About ShinkaTrack',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Version', style: TextStyle(fontWeight: FontWeight.w600)),
                          Text('1.0.0 (Production Stable)', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Divider(height: 24),
                      const Text(
                        'ShinkaTrack N3 is a production-quality, offline-first study companion designed to help you organize and assess your JLPT N3 progress.',
                        style: TextStyle(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Built using Clean Architecture and Flutter Riverpod.',
                        style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      const Divider(height: 24),
                      ListTile(
                        leading: const Icon(Icons.verified),
                        title: const Text('View Software Licenses'),
                        subtitle: const Text('Check open-source package licenses'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => showLicensePage(context: context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
