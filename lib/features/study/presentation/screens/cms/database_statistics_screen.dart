import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/cms_dashboard_screen.dart';
import 'package:shinka_track_n3/core/content/validation/content_validator.dart';

final statisticsDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repo = ref.watch(repositoryProvider);
  final kanjis = await repo.getMasterKanjisSpec();
  final vocabs = await repo.getMasterVocabulariesSpec();
  final grammars = await repo.getMasterGrammarsSpec();
  final readings = await repo.getMasterReadingsSpec();
  final listenings = await repo.getMasterListeningsSpec();

  final validation = ContentValidator.validate(
    kanjis: kanjis,
    vocabularies: vocabs,
    grammars: grammars,
    readings: readings,
    listenings: listenings,
  );

  final stats = await repo.getDatabaseStatistics();

  return {
    'stats': stats,
    'validationErrors': validation.errors,
  };
});

class DatabaseStatisticsScreen extends ConsumerWidget {
  const DatabaseStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(statisticsDataProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Database Statistics', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading stats: $err')),
        data: (data) {
          final stats = data['stats'] as Map<String, dynamic>;
          final validationErrors = data['validationErrors'] as List<ValidationError>;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewStats(context, stats, isDark),
                const SizedBox(height: 20),
                _buildCategoryTable(context, stats, isDark),
                const SizedBox(height: 20),
                const Text(
                  'Database Health & Issues',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                _buildHealthCard(context, stats, validationErrors, isDark),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewStats(BuildContext context, Map<String, dynamic> stats, bool isDark) {
    final avgComp = stats['averageCompleteness'] as double? ?? 100.0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Completeness Quality Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('${avgComp.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: avgComp / 100.0,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTable(BuildContext context, Map<String, dynamic> stats, bool isDark) {
    TableRow buildRow(String title, Map<String, dynamic>? itemStats) {
      final total = itemStats?['total'] ?? 0;
      final pub = itemStats?['Published'] ?? 0;
      final dft = itemStats?['Draft'] ?? 0;
      final arc = itemStats?['Archived'] ?? 0;

      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text('$total', textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text('$pub', textAlign: TextAlign.center, style: const TextStyle(color: Colors.green)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text('$dft', textAlign: TextAlign.center, style: const TextStyle(color: Colors.orange)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text('$arc', textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
        },
        children: [
          const TableRow(
            children: [
              Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
              Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text('Total', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
              Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text('Pub', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
              Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text('Draft', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
              Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text('Arch', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
            ],
          ),
          buildRow('Kanji', stats['kanji']),
          buildRow('Vocabulary', stats['vocabulary']),
          buildRow('Grammar', stats['grammar']),
          buildRow('Reading', stats['reading']),
          buildRow('Listening', stats['listening']),
        ],
      ),
    );
  }

  Widget _buildHealthCard(BuildContext context, Map<String, dynamic> stats, List<ValidationError> validationErrors, bool isDark) {
    if (validationErrors.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'No database warnings or issues found! All relationships and presence specifications are fully intact.',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Detected ${validationErrors.length} Issues',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: validationErrors.length,
            itemBuilder: (context, index) {
              final err = validationErrors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('[${err.itemType.toUpperCase()}] ', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue)),
                    Expanded(
                      child: Text(
                        'ID:${err.itemId} | Field: "${err.field}" - ${err.message}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
