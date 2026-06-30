import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/core/content/models/vocabulary_spec.dart';
import 'package:shinka_track_n3/core/content/models/grammar_spec.dart';
import 'package:shinka_track_n3/core/content/models/reading_spec.dart';
import 'package:shinka_track_n3/core/content/models/listening_spec.dart';
import 'package:shinka_track_n3/core/content/validation/content_validator.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/cms_dashboard_screen.dart';

class ImportCenterScreen extends ConsumerStatefulWidget {
  const ImportCenterScreen({super.key});

  @override
  ConsumerState<ImportCenterScreen> createState() => _ImportCenterScreenState();
}

class _ImportCenterScreenState extends ConsumerState<ImportCenterScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _pathController = TextEditingController();
  
  String _format = 'JSON'; // JSON, CSV
  String _itemType = 'Kanji'; // Kanji, Vocabulary, Grammar, Reading, Listening
  String _conflictStrategy = 'merge'; // merge, replace, skip
  
  // Logs of actions
  final List<String> _logs = [];

  @override
  void dispose() {
    _textController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  void _log(String msg) {
    setState(() {
      _logs.add('[${DateTime.now().toLocal().toString().split(' ')[1].substring(0, 8)}] $msg');
    });
  }

  Future<void> _processImport() async {
    String data = _textController.text.trim();
    
    if (_pathController.text.trim().isNotEmpty) {
      final file = File(_pathController.text.trim());
      if (await file.exists()) {
        try {
          data = await file.readAsString();
          _log('Loaded file from ${file.path}');
        } catch (e) {
          _log('Error reading file: $e');
          return;
        }
      } else {
        _log('Error: File path does not exist');
        return;
      }
    }

    if (data.isEmpty) {
      _log('Error: No text input or empty file content.');
      return;
    }

    _log('Processing $_itemType import (Format: $_format)...');

    try {
      List<KanjiSpec> kanjis = [];
      List<VocabularySpec> vocabs = [];
      List<GrammarSpec> grammars = [];
      List<ReadingSpec> readings = [];
      List<ListeningSpec> listenings = [];

      if (_format == 'JSON') {
        final decoded = jsonDecode(data);
        if (decoded is List) {
          _log('Parsed JSON list containing ${decoded.length} elements.');
          
          for (var item in decoded) {
            final map = Map<String, dynamic>.from(item);
            if (_itemType == 'Kanji') kanjis.add(KanjiSpec.fromJson(map));
            if (_itemType == 'Vocabulary') vocabs.add(VocabularySpec.fromJson(map));
            if (_itemType == 'Grammar') grammars.add(GrammarSpec.fromJson(map));
            if (_itemType == 'Reading') readings.add(ReadingSpec.fromJson(map));
            if (_itemType == 'Listening') listenings.add(ListeningSpec.fromJson(map));
          }
        } else if (decoded is Map) {
          // single element
          final map = Map<String, dynamic>.from(decoded);
          if (_itemType == 'Kanji') kanjis.add(KanjiSpec.fromJson(map));
          if (_itemType == 'Vocabulary') vocabs.add(VocabularySpec.fromJson(map));
          if (_itemType == 'Grammar') grammars.add(GrammarSpec.fromJson(map));
          if (_itemType == 'Reading') readings.add(ReadingSpec.fromJson(map));
          if (_itemType == 'Listening') listenings.add(ListeningSpec.fromJson(map));
          _log('Parsed single JSON object.');
        }
      } else {
        // CSV parser
        final lines = data.split('\n').where((l) => l.trim().isNotEmpty).toList();
        if (lines.length < 2) {
          _log('Error: CSV must contain a header row and at least one data row.');
          return;
        }
        final headers = lines[0].split(',').map((h) => h.trim()).toList();
        final Map<String, int> mapping = {};
        for (int i = 0; i < headers.length; i++) {
          mapping[headers[i]] = i;
        }

        _log('Parsed CSV headers: ${headers.join(", ")}');

        for (int i = 1; i < lines.length; i++) {
          final row = lines[i].split(',').map((r) => r.trim()).toList();
          if (_itemType == 'Kanji') kanjis.add(KanjiSpec.fromCsv(row, mapping));
          if (_itemType == 'Vocabulary') vocabs.add(VocabularySpec.fromCsv(row, mapping));
          if (_itemType == 'Grammar') grammars.add(GrammarSpec.fromCsv(row, mapping));
          if (_itemType == 'Reading') readings.add(ReadingSpec.fromCsv(row, mapping));
          if (_itemType == 'Listening') listenings.add(ListeningSpec.fromCsv(row, mapping));
        }
        _log('Parsed CSV containing ${lines.length - 1} rows.');
      }

      // Run validator
      final validation = ContentValidator.validate(
        kanjis: kanjis,
        vocabularies: vocabs,
        grammars: grammars,
        readings: readings,
        listenings: listenings,
      );

      if (validation.errors.isNotEmpty) {
        _log('Validation Warnings/Errors found: ${validation.errors.length} issues.');
        for (var err in validation.errors.take(3)) {
          _log('Warning: $err');
        }
        if (validation.errors.length > 3) {
          _log('... and ${validation.errors.length - 3} more validation errors.');
        }
      }

      // Show Import Preview Dialog
      _showImportPreviewDialog(
        kanjis: kanjis,
        vocabs: vocabs,
        grammars: grammars,
        readings: readings,
        listenings: listenings,
      );

    } catch (e) {
      _log('Import Error: $e');
    }
  }

  void _showImportPreviewDialog({
    required List<KanjiSpec> kanjis,
    required List<VocabularySpec> vocabs,
    required List<GrammarSpec> grammars,
    required List<ReadingSpec> readings,
    required List<ListeningSpec> listenings,
  }) {
    final count = kanjis.length + vocabs.length + grammars.length + readings.length + listenings.length;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Import Preview & Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total items to import: $count'),
            const SizedBox(height: 8),
            Text('Conflict resolution strategy: $_conflictStrategy'),
            const SizedBox(height: 12),
            const Text('Click confirm to write into the offline Master Database.'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = ref.read(repositoryProvider);
              await repo.bulkImportMaster(
                kanjis: kanjis,
                vocabularies: vocabs,
                grammars: grammars,
                readings: readings,
                listenings: listenings,
                conflictStrategy: _conflictStrategy,
              );
              _log('Bulk import executed successfully.');
              ref.invalidate(cmsStatsProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Import completed successfully.')),
              );
            },
            child: const Text('Confirm Import'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('CMS Import Center', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Card
            _buildSettingsCard(isDark),
            const SizedBox(height: 16),
            // Paste content / file path inputs
            _buildInputsCard(isDark),
            const SizedBox(height: 16),
            // Actions
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PremiumDesignSystem.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Process Import', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: _processImport,
              ),
            ),
            const SizedBox(height: 20),
            // Action log console
            const Text('Action Log Console', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 8),
            _buildLogConsole(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(bool isDark) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: Text('Item Type', style: TextStyle(fontWeight: FontWeight.bold))),
                DropdownButton<String>(
                  value: _itemType,
                  items: ['Kanji', 'Vocabulary', 'Grammar', 'Reading', 'Listening'].map((t) {
                    return DropdownMenuItem(value: t, child: Text(t));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _itemType = val);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Format', style: TextStyle(fontWeight: FontWeight.bold))),
                DropdownButton<String>(
                  value: _format,
                  items: ['JSON', 'CSV'].map((f) {
                    return DropdownMenuItem(value: f, child: Text(f));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _format = val);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Conflict Resolution Strategy', style: TextStyle(fontWeight: FontWeight.bold))),
                DropdownButton<String>(
                  value: _conflictStrategy,
                  items: [
                    const DropdownMenuItem(value: 'merge', child: Text('Merge/Overwrite')),
                    const DropdownMenuItem(value: 'replace', child: Text('Replace/Overwrite')),
                    const DropdownMenuItem(value: 'skip', child: Text('Skip Duplicate')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _conflictStrategy = val);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputsCard(bool isDark) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Option 1: Paste Text Content', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue)),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: _format == 'JSON'
                    ? '[\n  {\n    "id": "k101",\n    "character": "書", ...\n  }\n]'
                    : 'id,character,unicode,meaning...\nk101,書,U+66F8,write...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Option 2: Import from Local File Path', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue)),
            const SizedBox(height: 8),
            TextField(
              controller: _pathController,
              decoration: InputDecoration(
                hintText: '/sdcard/Download/kanjis.json',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogConsole(bool isDark) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.black26 : Colors.black87,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: _logs.isEmpty
          ? const Center(
              child: Text(
                'No actions logged yet.',
                style: TextStyle(color: Colors.white30, fontFamily: 'monospace', fontSize: 13),
              ),
            )
          : ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return Text(
                  _logs[index],
                  style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 12, height: 1.4),
                );
              },
            ),
    );
  }
}
