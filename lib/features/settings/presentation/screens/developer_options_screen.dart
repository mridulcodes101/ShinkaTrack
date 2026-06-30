import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/services/admin_service.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class DeveloperOptionsScreen extends ConsumerStatefulWidget {
  const DeveloperOptionsScreen({super.key});

  @override
  ConsumerState<DeveloperOptionsScreen> createState() => _DeveloperOptionsScreenState();
}

class _DeveloperOptionsScreenState extends ConsumerState<DeveloperOptionsScreen> {
  final _setupFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _importTextController = TextEditingController();
  final _importPathController = TextEditingController();

  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _loginPasswordController.dispose();
    _importTextController.dispose();
    _importPathController.dispose();
    super.dispose();
  }

  // Action: Setup Admin Password
  void _setupPassword() async {
    if (_setupFormKey.currentState!.validate()) {
      final messenger = ScaffoldMessenger.of(context);
      final service = ref.read(adminServiceProvider);
      await service.createPassword(_passwordController.text);
      ref.read(adminModeProvider.notifier).state = true;
      setState(() {
        _passwordController.clear();
        _confirmPasswordController.clear();
      });
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Admin password created successfully! Admin session unlocked.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // Action: Log in
  void _loginAdmin() {
    if (_loginFormKey.currentState!.validate()) {
      final service = ref.read(adminServiceProvider);
      final isCorrect = service.verifyPassword(_loginPasswordController.text);
      if (isCorrect) {
        ref.read(adminModeProvider.notifier).state = true;
        setState(() {
          _loginPasswordController.clear();
          _errorMessage = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Welcome, Administrator. Admin session active.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid password. Please try again.';
        });
      }
    }
  }

  // Action: Log out
  void _logoutAdmin() {
    ref.read(adminModeProvider.notifier).state = false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Administrator session closed.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Action: Reset Database
  void _resetMasterDatabase() async {
    final messenger = ScaffoldMessenger.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          title: const Text('Reset Master Database?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
          content: const Text(
            'WARNING: This will completely delete all master database records (Kanjis, Vocabularies, Grammars, Readings, Listenings) and seed default mock items from scratch. This action is irreversible.',
            style: TextStyle(height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Reset Master DB'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await ref.read(repositoryProvider).resetMasterDatabase();
        // Reload providers
        await ref.read(kanjiListProvider.notifier).loadKanjis();
        await ref.read(vocabListProvider.notifier).loadVocabularies();
        await ref.read(grammarListProvider.notifier).loadGrammars();
        await ref.read(readingListProvider.notifier).loadReadings();
        await ref.read(listeningListProvider.notifier).loadListenings();

        _logoutAdmin();
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Database reset and re-seeded successfully! Admin session closed.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text('Reset failed: $e')));
      }
    }
  }

  // Action: Reset user collection progress only
  void _resetProgress() async {
    final messenger = ScaffoldMessenger.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          title: const Text('Reset Collection Progress?'),
          content: const Text('This will delete your user collection joins, reviews, statistics, and weekly goals. Master dictionary data will NOT be touched.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Reset Progress'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await ref.read(repositoryProvider).resetAllProgress();
        // Reload all lists
        await ref.read(kanjiListProvider.notifier).loadKanjis();
        messenger.showSnackBar(const SnackBar(content: Text('User collection progress successfully reset!')));
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text('Reset failed: $e')));
      }
    }
  }

  // Import Dialog
  void _showImportDialog(String format) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          title: Text('Import Master Kanji ($format)', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Option 1: Paste raw text content below', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _importTextController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: format == 'JSON'
                        ? '[\n  {\n    "kanji": "漢", ...\n  }\n]'
                        : 'kanji,meaning,kunYomi,onYomi...\n漢,Sino-Japanese,おとこ,カン...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: isDark ? Colors.white10 : Colors.black12,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Option 2: Import from local file path', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _importPathController,
                  decoration: InputDecoration(
                    hintText: '/sdcard/Download/kanjis.json',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: isDark ? Colors.white10 : Colors.black12,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                String importData = _importTextController.text.trim();

                if (_importPathController.text.trim().isNotEmpty) {
                  try {
                    final file = File(_importPathController.text.trim());
                    if (await file.exists()) {
                      importData = await file.readAsString();
                    } else {
                      messenger.showSnackBar(const SnackBar(content: Text('File path does not exist.')));
                      return;
                    }
                  } catch (e) {
                    messenger.showSnackBar(SnackBar(content: Text('Error reading file: $e')));
                    return;
                  }
                }

                if (importData.isEmpty) {
                  messenger.showSnackBar(const SnackBar(content: Text('No import data provided.')));
                  return;
                }

                try {
                  int importedCount = 0;
                  if (format == 'JSON') {
                    final List<dynamic> parsed = jsonDecode(importData);
                    for (var item in parsed) {
                      final kanji = item['kanji'] as String;
                      final meaning = item['meaning'] as String? ?? '';
                      final kunList = List<String>.from(item['kunYomi'] ?? []);
                      final onList = List<String>.from(item['onYomi'] ?? []);
                      final strokeCount = item['strokeCount'] as int? ?? 0;
                      final radicals = item['radicals'] as String? ?? '';
                      final jlpt = item['jlptLevel'] as int? ?? 3;
                      final grade = item['gradeLevel'] as int?;
                      final unicode = item['unicode'] as String? ?? '';
                      final notes = item['notes'] as String? ?? '';
                      final examples = List<String>.from(item['exampleWords'] ?? []);
                      final sentences = List<String>.from(item['exampleSentences'] ?? []);
                      final tags = List<String>.from(item['tags'] ?? []);

                      final entity = KanjiEntity(
                        id: item['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString() + importedCount.toString(),
                        kanji: kanji,
                        meaning: meaning,
                        kunYomi: kunList,
                        onYomi: onList,
                        strokeCount: strokeCount,
                        radicals: radicals,
                        jlptLevel: jlpt,
                        gradeLevel: grade,
                        unicode: unicode,
                        notes: notes,
                        examples: examples,
                        exampleSentences: sentences,
                        tags: tags,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      await ref.read(kanjiListProvider.notifier).addKanji(entity);
                      importedCount++;
                    }
                  } else {
                    final lines = importData.split('\n');
                    if (lines.length > 1) {
                      for (int i = 1; i < lines.length; i++) {
                        if (lines[i].trim().isEmpty) continue;
                        final fields = lines[i].split(',');
                        final kanji = fields[0];
                        final meaning = fields.length > 1 ? fields[1] : '';
                        final kunYomi = fields.length > 2 ? fields[2].split(' ') : <String>[];
                        final onYomi = fields.length > 3 ? fields[3].split(' ') : <String>[];
                        final strokeCount = fields.length > 4 ? (int.tryParse(fields[4]) ?? 0) : 0;
                        final radicals = fields.length > 5 ? fields[5] : '';
                        final jlpt = fields.length > 6 ? (int.tryParse(fields[6]) ?? 3) : 3;
                        final grade = fields.length > 7 ? int.tryParse(fields[7]) : null;
                        final unicode = fields.length > 8 ? fields[8] : '';

                        final entity = KanjiEntity(
                          id: DateTime.now().millisecondsSinceEpoch.toString() + importedCount.toString(),
                          kanji: kanji,
                          meaning: meaning,
                          kunYomi: kunYomi,
                          onYomi: onYomi,
                          strokeCount: strokeCount,
                          radicals: radicals,
                          jlptLevel: jlpt,
                          gradeLevel: grade,
                          unicode: unicode,
                          notes: '',
                          examples: const [],
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        await ref.read(kanjiListProvider.notifier).addKanji(entity);
                        importedCount++;
                      }
                    }
                  }

                  _importTextController.clear();
                  _importPathController.clear();
                  if (context.mounted) Navigator.pop(context);
                  messenger.showSnackBar(SnackBar(content: Text('Successfully imported $importedCount Kanji entries!')));
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text('Failed to parse and import data: $e')));
                }
              },
              child: const Text('Import'),
            ),
          ],
        );
      },
    );
  }

  // Export DB content as JSON
  void _exportJSON() {
    ref.read(kanjiListProvider).whenData((list) async {
      final messenger = ScaffoldMessenger.of(context);
      try {
        final List<Map<String, dynamic>> maps = list.map((k) => {
          'id': k.id,
          'kanji': k.kanji,
          'unicode': k.unicode,
          'jlptLevel': k.jlptLevel,
          'gradeLevel': k.gradeLevel,
          'meaning': k.meaning,
          'kunYomi': k.kunYomi,
          'onYomi': k.onYomi,
          'strokeCount': k.strokeCount,
          'radicals': k.radicals,
          'strokeOrderDiagramPath': k.strokeOrderDiagramPath,
          'exampleWords': k.examples,
          'exampleSentences': k.exampleSentences,
          'notes': k.notes,
          'tags': k.tags,
        }).toList();
        final jsonStr = const JsonEncoder.withIndent('  ').convert(maps);
        await Clipboard.setData(ClipboardData(text: jsonStr));
        messenger.showSnackBar(const SnackBar(content: Text('Master Kanji database copied to clipboard!')));
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    });
  }

  // Full user progress backup
  void _backupDatabase() async {
    final repo = ref.read(repositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final jsonBackup = await repo.exportBackupJson();
      await Clipboard.setData(ClipboardData(text: jsonBackup));
      messenger.showSnackBar(const SnackBar(content: Text('Full database progress backup copied to clipboard!')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Backup failed: $e')));
    }
  }

  // Full user progress restore
  void _restoreDatabase() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final controller = TextEditingController();
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          title: const Text('Restore Backup', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Paste full backup payload below to restore database progress:', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Paste backup JSON here...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: isDark ? Colors.white10 : Colors.black12,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                if (controller.text.trim().isEmpty) return;
                try {
                  final repo = ref.read(repositoryProvider);
                  await repo.importBackupJson(controller.text.trim());
                  await ref.read(kanjiListProvider.notifier).loadKanjis();
                  if (context.mounted) Navigator.pop(context);
                  messenger.showSnackBar(const SnackBar(content: Text('Database successfully restored from backup!')));
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text('Restore failed: $e')));
                }
              },
              child: const Text('Restore'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUnlocked = ref.watch(developerModeUnlockedProvider);
    final isAdmin = ref.watch(adminModeProvider);
    final service = ref.watch(adminServiceProvider);

    // Security Gate 1: Check if Developer Mode is Unlocked
    if (!isUnlocked) {
      return Scaffold(
        backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
        appBar: AppBar(title: const Text('Access Denied')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 72, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('This portal is restricted to developers.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Unlock by tapping version number 7 times in Settings.', style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    // Gate 2: If unlocked but not authenticated as Admin
    if (!isAdmin) {
      final isSetup = !service.isPasswordCreated();

      return Scaffold(
        backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
        appBar: AppBar(
          title: Text(isSetup ? 'Setup Administrator' : 'Developer Access Gate'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28.0),
            child: Card(
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: isSetup ? _buildPasswordSetupForm() : _buildLoginForm(),
              ),
            ),
          ),
        ),
      );
    }

    // Gate 3: Authenticated Admin -> Show rich options
    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('DEVELOPER OPTIONS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout Admin',
            onPressed: _logoutAdmin,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Database Statistics Panel
            _buildSectionHeader('Database Statistics', Icons.analytics),
            const SizedBox(height: 12),
            _buildStatsCard(isDark),
            const SizedBox(height: 28),

            // Master Databases Section
            _buildSectionHeader('Master Databases', Icons.storage),
            const SizedBox(height: 12),
            _buildDatabaseOptionRow(
              title: 'Kanji Database',
              subtitle: 'Manage master dictionary & custom entries',
              icon: Icons.font_download_outlined,
              color: Colors.indigo,
              onTap: () => context.push('/admin'),
            ),
            const SizedBox(height: 12),
            _buildDatabaseOptionRow(
              title: 'Vocabulary Database',
              subtitle: 'Static vocabulary dictionary records',
              icon: Icons.translate,
              color: Colors.orange,
              onTap: () => _showReadOnlyInfo('Vocabulary'),
            ),
            const SizedBox(height: 12),
            _buildDatabaseOptionRow(
              title: 'Grammar Database',
              subtitle: 'Static grammar points and explanation rules',
              icon: Icons.menu_book,
              color: Colors.teal,
              onTap: () => _showReadOnlyInfo('Grammar'),
            ),
            const SizedBox(height: 12),
            _buildDatabaseOptionRow(
              title: 'Reading Database',
              subtitle: 'Static reading passages and assessments',
              icon: Icons.import_contacts,
              color: Colors.pink,
              onTap: () => _showReadOnlyInfo('Reading'),
            ),
            const SizedBox(height: 12),
            _buildDatabaseOptionRow(
              title: 'Listening Database',
              subtitle: 'Static audio transcripts and options',
              icon: Icons.hearing,
              color: Colors.blue,
              onTap: () => _showReadOnlyInfo('Listening'),
            ),
            const SizedBox(height: 28),

            // Database Imports/Exports Section
            _buildSectionHeader('Data Operations', Icons.settings_backup_restore),
            const SizedBox(height: 12),
            Card(
              color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.download, color: Colors.blue),
                    title: const Text('Import JSON'),
                    subtitle: const Text('Batch insert Master Kanjis from raw JSON'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showImportDialog('JSON'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.download_for_offline, color: Colors.blue),
                    title: const Text('Import CSV'),
                    subtitle: const Text('Batch insert Master Kanjis from raw CSV'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showImportDialog('CSV'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.upload, color: Colors.blue),
                    title: const Text('Export JSON'),
                    subtitle: const Text('Copy full master catalog to clipboard'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _exportJSON,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.backup, color: Colors.green),
                    title: const Text('Backup Database'),
                    subtitle: const Text('Export user progress configuration backup'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _backupDatabase,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings_backup_restore_outlined, color: Colors.green),
                    title: const Text('Restore Database'),
                    subtitle: const Text('Import user progress configuration backup'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _restoreDatabase,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Danger Zone
            _buildSectionHeader('Danger Zone', Icons.warning_amber_rounded, color: Colors.redAccent),
            const SizedBox(height: 12),
            Card(
              color: Colors.redAccent.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.redAccent, width: 1.5),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                    title: const Text('Reset Master Database', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                    subtitle: const Text('Deletes all master data and seeds default items'),
                    onTap: _resetMasterDatabase,
                  ),
                  const Divider(height: 1, color: Colors.redAccent),
                  ListTile(
                    leading: const Icon(Icons.cleaning_services, color: Colors.orange),
                    title: const Text('Reset User Collection Progress', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                    subtitle: const Text('Clears user collections, schedules, and analytics only'),
                    onTap: _resetProgress,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper Form widget: First launch password setup
  Widget _buildPasswordSetupForm() {
    return Form(
      key: _setupFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.admin_panel_settings, size: 56, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Create Admin Passcode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'First launch detected. Setup an Administrator password. Only you will be able to access database modifications and developer tools.',
            style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'New Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Password cannot be empty';
              if (val.trim().length < 4) return 'Password must be at least 4 characters';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: (val) {
              if (val != _passwordController.text) return 'Passwords do not match';
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PremiumDesignSystem.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _setupPassword,
            child: const Text('Save & Authenticate', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Helper Form widget: Login form
  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.lock_outline, size: 56, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Administrator Verification',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Please input your passcode to unlock your session settings and database overrides.',
            style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _loginPasswordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'Enter Passcode',
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Please input passcode';
              return null;
            },
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PremiumDesignSystem.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _loginAdmin,
            child: const Text('Unlock Admin Session', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Helper Stats card widget
  Widget _buildStatsCard(bool isDark) {
    final kanjis = ref.watch(kanjiListProvider).value ?? [];
    final vocabs = ref.watch(vocabListProvider).value ?? [];
    final grammars = ref.watch(grammarListProvider).value ?? [];
    final readings = ref.watch(readingListProvider).value ?? [];
    final listenings = ref.watch(listeningListProvider).value ?? [];

    final userAddedKanjis = kanjis.where((k) => k.isAdded).length;

    return Card(
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildStatSummaryRow('Master Kanjis Count', '${kanjis.length}', isDark),
            const Divider(),
            _buildStatSummaryRow('User Collection Kanjis', '$userAddedKanjis', isDark),
            const Divider(),
            _buildStatSummaryRow('Vocabularies Dictionary', '${vocabs.length}', isDark),
            const Divider(),
            _buildStatSummaryRow('Grammar Lessons Count', '${grammars.length}', isDark),
            const Divider(),
            _buildStatSummaryRow('Reading Passages Count', '${readings.length}', isDark),
            const Divider(),
            _buildStatSummaryRow('Listening Tracks Count', '${listenings.length}', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildStatSummaryRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color ?? PremiumDesignSystem.primaryBlue),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color, letterSpacing: -0.2),
        ),
      ],
    );
  }

  Widget _buildDatabaseOptionRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: onTap,
      ),
    );
  }

  void _showReadOnlyInfo(String module) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          title: Text('$module Catalog'),
          content: Text('The $module database table contains read-only production master records. Modification operations are restricted to future updates or custom imports.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
