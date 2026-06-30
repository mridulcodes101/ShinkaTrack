import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/add_edit_kanji_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/kanji_manager_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/cms_dashboard_screen.dart';

class KanjiDetailScreen extends ConsumerWidget {
  final KanjiSpec spec;
  const KanjiDetailScreen({super.key, required this.spec});

  void _duplicate(BuildContext context, WidgetRef ref) {
    // Generates a duplicate with suffix '-copy' in ID and same data
    final copy = KanjiSpec(
      id: '${spec.id}-copy',
      character: spec.character,
      unicode: spec.unicode,
      meaning: '${spec.meaning} (Copy)',
      onyomi: List.from(spec.onyomi),
      kunyomi: List.from(spec.kunyomi),
      jlptLevel: spec.jlptLevel,
      gradeLevel: spec.gradeLevel,
      strokeCount: spec.strokeCount,
      radicals: spec.radicals,
      primaryRadical: spec.primaryRadical,
      frequencyRank: spec.frequencyRank,
      joyoStatus: spec.joyoStatus,
      exampleWords: List.from(spec.exampleWords),
      exampleSentences: List.from(spec.exampleSentences),
      relatedKanji: List.from(spec.relatedKanji),
      tags: List.from(spec.tags),
      difficulty: spec.difficulty,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: 'Draft',
      schemaVersion: spec.schemaVersion,
      contentVersion: spec.contentVersion,
      lastUpdated: DateTime.now(),
      mnemonic: spec.mnemonic,
      personalNotes: spec.personalNotes,
      image: spec.image,
      svgStrokeOrder: spec.svgStrokeOrder,
      animatedStrokeData: spec.animatedStrokeData,
      audio: spec.audio,
      pitchAccentExamples: spec.pitchAccentExamples,
      writingPracticeData: spec.writingPracticeData,
      handwritingRecognitionData: spec.handwritingRecognitionData,
      aiExplanation: spec.aiExplanation,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditKanjiScreen(initialSpec: copy),
      ),
    );
  }

  void _archive(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(cmsKanjisProvider.notifier);
    await notifier.archiveKanji(spec.id);
    ref.invalidate(cmsStatsProvider);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kanji "${spec.character}" archived successfully.')),
    );
  }

  void _delete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Permanent Delete'),
        content: Text('Are you sure you want to permanently delete Kanji "${spec.character}" from the database? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              final notifier = ref.read(cmsKanjisProvider.notifier);
              await notifier.deleteKanjiPermanently(spec.id);
              ref.invalidate(cmsStatsProvider);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Text('Kanji Detail: ${spec.character}', style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEditKanjiScreen(initialSpec: spec)),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == 'duplicate') _duplicate(context, ref);
              if (val == 'archive') _archive(context, ref);
              if (val == 'delete') _delete(context, ref);
              if (val == 'export') {
                final json = jsonEncode(spec.toJson());
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Export JSON'),
                    content: SingleChildScrollView(
                      child: SelectableText(json),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Done')),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'duplicate', child: Text('Duplicate (as Draft)')),
              const PopupMenuItem(value: 'archive', child: Text('Soft Delete (Archive)')),
              const PopupMenuItem(value: 'export', child: Text('Export Single Record')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Permanently', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character Card
            _buildCharacterHeroCard(context),
            const SizedBox(height: 20),
            // Basic details
            _buildSectionHeader('Basic Information'),
            _buildInfoGrid(context),
            const SizedBox(height: 20),
            // Readings
            _buildSectionHeader('Readings'),
            _buildReadingsCard(context),
            const SizedBox(height: 20),
            // Examples
            _buildSectionHeader('Examples'),
            _buildExamplesCard(context),
            const SizedBox(height: 20),
            // Developer Notes
            if (spec.personalNotes != null && spec.personalNotes!.isNotEmpty) ...[
              _buildSectionHeader('Developer Notes'),
              _buildNotesCard(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterHeroCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(spec.character, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(spec.meaning, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('JLPT N${spec.jlptLevel}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(spec.status, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget buildRow(String k, String v) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Text(k, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const Spacer(),
            Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          buildRow('Unicode', spec.unicode),
          const Divider(),
          buildRow('Grade Level', spec.gradeLevel.toString()),
          const Divider(),
          buildRow('Frequency Rank', spec.frequencyRank > 0 ? '#${spec.frequencyRank}' : 'Unranked'),
          const Divider(),
          buildRow('Stroke Count', spec.strokeCount.toString()),
          const Divider(),
          buildRow('Radicals', spec.radicals.isEmpty ? 'None' : spec.radicals),
        ],
      ),
    );
  }

  Widget _buildReadingsCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Onyomi (Chinese readings)', style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            spec.onyomi.isEmpty ? 'None' : spec.onyomi.join(', '),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PremiumDesignSystem.secondaryPink),
          ),
          const Divider(height: 20),
          const Text('Kunyomi (Japanese readings)', style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            spec.kunyomi.isEmpty ? 'None' : spec.kunyomi.join(', '),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PremiumDesignSystem.forestEmerald),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Example Words', style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 6),
          if (spec.exampleWords.isEmpty)
            const Text('No example words stored')
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: spec.exampleWords.map((w) {
                return Chip(
                  label: Text(w),
                  backgroundColor: isDark ? Colors.white10 : Colors.black12,
                );
              }).toList(),
            ),
          const Divider(height: 24),
          const Text('Example Sentences', style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 6),
          if (spec.exampleSentences.isEmpty)
            const Text('No example sentences stored')
          else
            ...spec.exampleSentences.map((s) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.play_arrow, size: 14, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(s, style: const TextStyle(fontSize: 14, height: 1.4)),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Text(
        spec.personalNotes ?? '',
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }
}
