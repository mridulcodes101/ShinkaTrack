import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/services/admin_service.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_planner_providers.dart';
import 'package:shinka_track_n3/core/services/notification_service.dart';
import 'package:shinka_track_n3/features/settings/application/settings_notifier.dart';
import 'package:shinka_track_n3/features/notifications/application/notifications_notifier.dart';
import 'package:shinka_track_n3/features/onboarding/application/onboarding_notifier.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _versionTapCount = 0;
  bool _devModeUnlocked = false;

  final Map<String, ExpansionTileController> _controllers = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Helper actions
  void _updateThemeMode(ThemeMode mode) async {
    ref.read(themeModeProvider.notifier).state = mode;
    await ref.read(settingsProvider.notifier).updateSetting('settings_general_theme', mode.name);
  }

  void _updateThemeColor(String colorKey) async {
    ref.read(themeColorProvider.notifier).state = colorKey;
    await ref.read(settingsProvider.notifier).updateSetting('settings_general_color', colorKey);
  }

  void _updateFontSize(String sizeLabel) async {
    double scale = 1.0;
    if (sizeLabel == 'Small') scale = 0.85;
    if (sizeLabel == 'Large') scale = 1.15;
    if (sizeLabel == 'Extra Large') scale = 1.3;

    ref.read(fontSizeProvider.notifier).state = scale;
    await ref.read(settingsProvider.notifier).updateSetting('settings_general_fontSize', sizeLabel);
  }

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

  void _confirmReset(String type) {
    final messenger = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Reset $type Settings?'),
          content: const Text(
            'This action will reset your chosen settings preferences in this section back to defaults. This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                if (type == 'All') {
                  final repo = ref.read(repositoryProvider);
                  await repo.resetAllProgress();

                  ref.invalidate(kanjiListProvider);
                  ref.invalidate(vocabListProvider);
                  ref.invalidate(grammarListProvider);
                  ref.invalidate(dailyGoalProvider);
                  ref.invalidate(studySessionsProvider);
                  ref.invalidate(activePlanProvider);
                  await ref.read(settingsProvider.notifier).resetAll();
                } else if (type == 'Onboarding') {
                  await ref.read(onboardingProvider.notifier).resetOnboarding();
                  ref.read(onboardingCompletedProvider.notifier).state = false;
                  if (mounted) {
                    context.go('/onboarding');
                  }
                } else {
                  await ref.read(settingsProvider.notifier).resetSection(type.toLowerCase());
                }
                messenger.showSnackBar(
                  SnackBar(content: Text('$type settings has been reset.')),
                );
              },
              child: const Text('Reset', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _buildSettingsItems(Map<String, dynamic> settings) {
    return [
      // 1. GENERAL
      {
        'section': 'General',
        'key': 'settings_general_theme',
        'title': 'App Theme',
        'description': 'Configure Light, Dark, or System mode matching system preferences.',
        'widget': DropdownButtonFormField<String>(
          value: settings['settings_general_theme'] ?? 'system',
          decoration: const InputDecoration(labelText: 'Theme Mode'),
          items: ['light', 'dark', 'system'].map((t) {
            return DropdownMenuItem(value: t, child: Text(t.toUpperCase()));
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              ThemeMode m = ThemeMode.system;
              if (val == 'light') m = ThemeMode.light;
              if (val == 'dark') m = ThemeMode.dark;
              _updateThemeMode(m);
            }
          },
        ),
      },
      {
        'section': 'General',
        'key': 'settings_general_color',
        'title': 'Accent Color Theme',
        'description': 'Customize the primary accent color theme.',
        'widget': DropdownButtonFormField<String>(
          value: settings['settings_general_color'] ?? 'indigo',
          decoration: const InputDecoration(labelText: 'Accent Theme'),
          items: ['indigo', 'pink', 'teal', 'amber'].map((c) {
            return DropdownMenuItem(value: c, child: Text(c.toUpperCase()));
          }).toList(),
          onChanged: (val) {
            if (val != null) _updateThemeColor(val);
          },
        ),
      },
      {
        'section': 'General',
        'key': 'settings_general_fontSize',
        'title': 'General Font Size Scale',
        'description': 'Change size scale for user interface typography.',
        'widget': DropdownButtonFormField<String>(
          value: settings['settings_general_fontSize'] ?? 'Medium',
          decoration: const InputDecoration(labelText: 'Font Size'),
          items: ['Small', 'Medium', 'Large', 'Extra Large'].map((s) {
            return DropdownMenuItem(value: s, child: Text(s));
          }).toList(),
          onChanged: (val) {
            if (val != null) _updateFontSize(val);
          },
        ),
      },

      // 2. STUDY
      {
        'section': 'Study',
        'key': 'settings_study_goal_minutes',
        'title': 'Daily Study Goal (Minutes)',
        'description': 'Target minutes planned for daily lessons.',
        'widget': Slider(
          value: (settings['settings_study_goal_minutes'] as int? ?? 15).toDouble(),
          min: 5,
          max: 120,
          divisions: 23,
          label: '${settings['settings_study_goal_minutes']} mins',
          onChanged: (val) {
            ref.read(settingsProvider.notifier).updateSetting('settings_study_goal_minutes', val.round());
            ref.invalidate(dailyGoalProvider);
          },
        ),
      },
      {
        'section': 'Study',
        'key': 'settings_study_difficulty',
        'title': 'Study Difficulty level',
        'description': 'Select preferred material difficulty targets.',
        'widget': DropdownButtonFormField<String>(
          value: settings['settings_study_difficulty'] ?? 'Normal',
          decoration: const InputDecoration(labelText: 'Difficulty'),
          items: ['Easy', 'Normal', 'Hard'].map((d) {
            return DropdownMenuItem(value: d, child: Text(d));
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              ref.read(settingsProvider.notifier).updateSetting('settings_study_difficulty', val);
            }
          },
        ),
      },

      // 3. REVIEW
      {
        'section': 'Review',
        'key': 'settings_review_limit',
        'title': 'Daily Review Cards Limit',
        'description': 'Maximum review cards presented in one day.',
        'widget': DropdownButtonFormField<int>(
          value: settings['settings_review_limit'] ?? 50,
          decoration: const InputDecoration(labelText: 'Review Limit'),
          items: [10, 25, 50, 100, 200].map((l) {
            return DropdownMenuItem(value: l, child: Text('$l Cards'));
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              ref.read(settingsProvider.notifier).updateSetting('settings_review_limit', val);
            }
          },
        ),
      },

      // 4. PLANNER
      {
        'section': 'Planner',
        'key': 'settings_planner_auto_redistribute',
        'title': 'Automatic Redistribution',
        'description': 'Automatically shift skipped weekday items to tomorrow study plan.',
        'widget': SwitchListTile(
          title: const Text('Auto Shift Missed Tasks'),
          value: settings['settings_planner_auto_redistribute'] ?? true,
          onChanged: (val) {
            ref.read(settingsProvider.notifier).updateSetting('settings_planner_auto_redistribute', val);
          },
        ),
      },

      // 5. READING
      {
        'section': 'Reading',
        'key': 'settings_reading_furigana',
        'title': 'Show Furigana help tags',
        'description': 'Enable Furigana tags above Kanji components inside passages.',
        'widget': SwitchListTile(
          title: const Text('Furigana Tags'),
          value: settings['settings_reading_furigana'] ?? true,
          onChanged: (val) {
            ref.read(settingsProvider.notifier).updateSetting('settings_reading_furigana', val);
          },
        ),
      },
      {
        'section': 'Reading',
        'key': 'settings_reading_translation',
        'title': 'Show English Translations',
        'description': 'Expose hidden translation boxes for Reading lessons.',
        'widget': SwitchListTile(
          title: const Text('Passage Translation'),
          value: settings['settings_reading_translation'] ?? true,
          onChanged: (val) {
            ref.read(settingsProvider.notifier).updateSetting('settings_reading_translation', val);
          },
        ),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allItems = _buildSettingsItems(settings);

    // Filter items based on search query
    final filteredItems = allItems.where((item) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      final titleMatch = item['title'].toString().toLowerCase().contains(q);
      final descMatch = item['description'].toString().toLowerCase().contains(q);
      final sectionMatch = item['section'].toString().toLowerCase().contains(q);
      return titleMatch || descMatch || sectionMatch;
    }).toList();

    // Group filtered items by section
    final Map<String, List<Map<String, dynamic>>> sectionsGroup = {};
    for (var item in filteredItems) {
      final sec = item['section'] as String;
      sectionsGroup.putIfAbsent(sec, () => []).add(item);
    }

    // Auto-expand sections that have search queries matches
    if (_searchQuery.isNotEmpty) {
      for (var sec in sectionsGroup.keys) {
        _controllers.putIfAbsent(sec, () => ExpansionTileController());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controllers[sec]?.expand();
        });
      }
    }

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Control Center Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input Header
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search control settings...',
                prefixIcon: const Icon(Icons.search, color: PremiumDesignSystem.primaryBlue),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim();
                });
              },
            ),
            const SizedBox(height: 24),

            // Render all matching settings sections
            if (sectionsGroup.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text('No matching settings parameters found.', style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              ...sectionsGroup.entries.map((entry) {
                final secName = entry.key;
                final items = entry.value;
                _controllers.putIfAbsent(secName, () => ExpansionTileController());

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      controller: _controllers[secName],
                      title: Text(
                        secName.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: PremiumDesignSystem.primaryBlue),
                      ),
                      leading: Icon(
                        secName == 'General'
                            ? Icons.settings
                            : secName == 'Study'
                                ? Icons.school
                                : secName == 'Review'
                                    ? Icons.rate_review
                                    : secName == 'Planner'
                                        ? Icons.calendar_today
                                        : Icons.chrome_reader_mode,
                        color: PremiumDesignSystem.primaryBlue,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            children: items.map((i) {
                              final highlight = _searchQuery.isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: highlight 
                                      ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.05) 
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: highlight 
                                      ? Border.all(color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3), width: 1.5)
                                      : null,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(i['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text(
                                      i['description'],
                                      style: TextStyle(fontSize: 12, color: Colors.grey[500], height: 1.3),
                                    ),
                                    const SizedBox(height: 12),
                                    i['widget'],
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 24),

            // Backup & Data Actions Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('DATA STORAGE & MANAGEMENT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PremiumDesignSystem.primaryBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: const Icon(Icons.download),
                            label: const Text('Export JSON'),
                            onPressed: _exportJson,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PremiumDesignSystem.secondaryPink,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: const Icon(Icons.upload),
                            label: const Text('Import JSON'),
                            onPressed: _importJson,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.refresh, color: Colors.red),
                      title: const Text('Reset All Settings', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Reset theme, goals, study progress metadata back to zero.'),
                      onTap: () => _confirmReset('All'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.flight_takeoff, color: PremiumDesignSystem.primaryBlue),
                      title: const Text('Reset Onboarding Wizard', style: TextStyle(color: PremiumDesignSystem.primaryBlue, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Restart the first-launch onboarding tutorial experience.'),
                      onTap: () => _confirmReset('Onboarding'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Version info footer
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _versionTapCount++;
                    if (_versionTapCount >= 7) {
                      _devModeUnlocked = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Developer Mode enabled! validation panel unlocked.')),
                      );
                    }
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'ShinkaTrack N3 v1.0.0',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Database Version: 6',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),

            // Developer options if unlocked
            if (_devModeUnlocked) ...[
              const SizedBox(height: 24),
              Card(
                color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('DEVELOPER CONTROLS', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        child: const Text('Reseed Database Content'),
                        onPressed: () async {
                          final repo = ref.read(repositoryProvider);
                          await repo.resetAllProgress();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Master database records seeded successfully!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
