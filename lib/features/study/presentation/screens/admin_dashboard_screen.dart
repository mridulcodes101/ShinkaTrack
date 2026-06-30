import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/cms_dashboard_screen.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final TextEditingController _importTextController = TextEditingController();
  final TextEditingController _importPathController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _importTextController.dispose();
    _importPathController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: format == 'JSON' ? '[\n  {\n    "kanji": "漢", ...\n  }\n]' : 'kanji,meaning,kunYomi,onYomi...\n漢,Sino-Japanese,おとこ,カン...',
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

                // If path is specified, try loading from file
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
                    // CSV Parser
                    final lines = importData.split('\n');
                    if (lines.length > 1) {
                      for (int i = 1; i < lines.length; i++) {
                        if (lines[i].trim().isEmpty) continue;
                        final fields = lines[i].split(',');
                        // simple mapping
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

  void _exportDatabase(String format) {
    ref.read(kanjiListProvider).whenData((list) async {
      final messenger = ScaffoldMessenger.of(context);
      try {
        String data = '';
        if (format == 'JSON') {
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
            'isAdded': k.isAdded,
            'isLearned': k.isLearned,
            'isFavorite': k.isFavorite,
            'reviewCount': k.reviewCount,
            'easeFactor': k.easeFactor,
            'customNotes': k.customNotes,
          }).toList();
          data = const JsonEncoder.withIndent('  ').convert(maps);
        } else {
          // CSV Format
          final buffer = StringBuffer();
          buffer.writeln('id,kanji,meaning,kunYomi,onYomi,strokeCount,radicals,jlptLevel,unicode,notes');
          for (var k in list) {
            buffer.writeln('${k.id},${k.kanji},${k.meaning},${k.kunYomi.join(' ')},${k.onYomi.join(' ')},${k.strokeCount},${k.radicals},${k.jlptLevel},${k.unicode},${k.notes}');
          }
          data = buffer.toString();
        }

        await Clipboard.setData(ClipboardData(text: data));
        messenger.showSnackBar(SnackBar(content: Text('Master database exported to clipboard in $format format!')));
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text('Failed to export: $e')));
      }
    });
  }

  void _exportBackup() async {
    final repo = ref.read(repositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final jsonBackup = await repo.exportBackupJson();
      await Clipboard.setData(ClipboardData(text: jsonBackup));
      messenger.showSnackBar(const SnackBar(content: Text('Full database Backup exported to Clipboard!')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Backup failed: $e')));
    }
  }

  void _restoreBackup() {
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
              const Text('Paste full backup payload below to restore database:', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 6,
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
    final kanjiAsync = ref.watch(kanjiListProvider);
    final isAdmin = ref.watch(adminModeProvider);

    if (!isAdmin) {
      return Scaffold(
        backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
        appBar: AppBar(title: const Text('Restricted Access')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security, size: 72, color: Colors.redAccent),
                const SizedBox(height: 16),
                const Text(
                  'This portal is restricted to administrators.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const CmsDashboardScreen();
  }
}
