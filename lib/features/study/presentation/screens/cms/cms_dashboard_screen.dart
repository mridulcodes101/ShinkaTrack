import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/kanji_manager_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/import_center_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/export_center_screen.dart';
import 'package:shinka_track_n3/features/study/presentation/screens/cms/database_statistics_screen.dart';

// Riverpod Provider for database stats
final cmsStatsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repo = ref.watch(repositoryProvider);
  return repo.getDatabaseStatistics();
});

class CmsDashboardScreen extends ConsumerWidget {
  const CmsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(cmsStatsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Developer CMS Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(cmsStatsProvider),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(adminModeProvider.notifier).state = false;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Admin session closed.')),
              );
              context.go('/');
            },
          ),
        ],
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
              const SizedBox(height: 16),
              Text('Error loading statistics: $err', style: const TextStyle(color: Colors.redAccent)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(cmsStatsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (stats) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSystemStatusBanner(context, stats, isDark),
                const SizedBox(height: 24),
                const Text(
                  'Content Managers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  children: [
                    _buildCategoryCard(
                      context,
                      title: 'KANJI',
                      icon: Icons.translate,
                      color: PremiumDesignSystem.primaryBlue,
                      stats: stats['kanji'],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KanjiManagerScreen()),
                      ),
                    ),
                    _buildCategoryCard(
                      context,
                      title: 'VOCABULARY',
                      icon: Icons.menu_book,
                      color: PremiumDesignSystem.secondaryPink,
                      stats: stats['vocabulary'],
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vocabulary Manager is locked under Schema spec standard.')),
                        );
                      },
                    ),
                    _buildCategoryCard(
                      context,
                      title: 'GRAMMAR',
                      icon: Icons.g_translate,
                      color: PremiumDesignSystem.forestEmerald,
                      stats: stats['grammar'],
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Grammar Manager is locked under Schema spec standard.')),
                        );
                      },
                    ),
                    _buildCategoryCard(
                      context,
                      title: 'READING',
                      icon: Icons.chrome_reader_mode,
                      color: Colors.orange,
                      stats: stats['reading'],
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reading Manager is locked under Schema spec standard.')),
                        );
                      },
                    ),
                    _buildCategoryCard(
                      context,
                      title: 'LISTENING',
                      icon: Icons.headset,
                      color: Colors.pink,
                      stats: stats['listening'],
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Listening Manager is locked under Schema spec standard.')),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tools & Centers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                const SizedBox(height: 12),
                _buildToolButtonsGrid(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSystemStatusBanner(BuildContext context, Map<String, dynamic> stats, bool isDark) {
    final completeness = stats['averageCompleteness'] as double? ?? 100.0;
    final broken = stats['brokenReferences'] as int? ?? 0;
    final duplicates = stats['duplicateRecords'] as int? ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.security, color: Colors.green, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Master Database Offline Mode Active',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusIndicator('Completeness', '${completeness.toStringAsFixed(1)}%', Colors.blue),
              _buildStatusIndicator('Broken Refs', '$broken', broken > 0 ? Colors.red : Colors.green),
              _buildStatusIndicator('Duplicates', '$duplicates', duplicates > 0 ? Colors.orange : Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Map<String, dynamic>? stats,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = stats?['total'] ?? 0;
    final published = stats?['Published'] ?? 0;
    final draft = stats?['Draft'] ?? 0;
    final archived = stats?['Archived'] ?? 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color, letterSpacing: 1.1),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('$total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const Divider(height: 12),
            _buildStatRow('Published', '$published', Colors.green),
            _buildStatRow('Draft', '$draft', Colors.orange),
            _buildStatRow('Archived', '$archived', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: bulletColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildToolButtonsGrid(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget buildBtn(String label, IconData icon, Color color, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        buildBtn(
          'Import Center',
          Icons.cloud_upload,
          PremiumDesignSystem.primaryBlue,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ImportCenterScreen()),
          ),
        ),
        const SizedBox(height: 12),
        buildBtn(
          'Export Center',
          Icons.cloud_download,
          PremiumDesignSystem.secondaryPink,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExportCenterScreen()),
          ),
        ),
        const SizedBox(height: 12),
        buildBtn(
          'Database Statistics',
          Icons.bar_chart,
          PremiumDesignSystem.forestEmerald,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DatabaseStatisticsScreen()),
          ),
        ),
      ],
    );
  }
}
