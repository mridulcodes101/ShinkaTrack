import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/review/domain/models/review_item.dart';
import 'package:shinka_track_n3/features/review/application/review_notifier.dart';

class ReviewHomeScreen extends ConsumerWidget {
  const ReviewHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(reviewStatsProvider);
    final dueAsync = ref.watch(dueReviewsProvider);
    final upcomingAsync = ref.watch(upcomingReviewsProvider);
    final weakAsync = ref.watch(weakItemsProvider);
    final failedAsync = ref.watch(recentlyFailedReviewsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Review Hub', style: TextStyle(fontWeight: FontWeight.bold)),
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
            // Statistics Card block
            statsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const Text('Error loading stats'),
              data: (stats) => _buildStatsPanel(context, stats),
            ),
            const SizedBox(height: 24),

            // Queue categories list
            const Text(
              'REVIEW QUEUES',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
            ),
            const SizedBox(height: 10),

            dueAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (err, stack) => const SizedBox.shrink(),
              data: (dueList) => _buildQueueCard(
                context,
                title: "Today's Reviews",
                count: dueList.length,
                icon: Icons.today_rounded,
                color: PremiumDesignSystem.primaryBlue,
                onTap: () => _startSession(context, ref, dueList),
              ),
            ),

            failedAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (err, stack) => const SizedBox.shrink(),
              data: (failedList) => failedList.isEmpty
                  ? const SizedBox.shrink()
                  : _buildQueueCard(
                      context,
                      title: "Recently Failed",
                      count: failedList.length,
                      icon: Icons.dangerous_rounded,
                      color: PremiumDesignSystem.secondaryPink,
                      onTap: () => _startSession(context, ref, failedList),
                    ),
            ),

            upcomingAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (err, stack) => const SizedBox.shrink(),
              data: (upcomingList) => _buildQueueCard(
                context,
                title: "Upcoming Reviews",
                count: upcomingList.length,
                icon: Icons.upcoming_rounded,
                color: Colors.amber,
                onTap: () => _startSession(context, ref, upcomingList),
              ),
            ),

            const SizedBox(height: 24),

            // Weak items section
            const Text(
              'WEAK ITEMS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
            ),
            const SizedBox(height: 10),

            weakAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const Text('Error loading weak items'),
              data: (weakList) {
                if (weakList.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No weak items detected yet! You are doing great.', style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: weakList.length.clamp(0, 5),
                  itemBuilder: (context, index) {
                    final item = weakList[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      trailing: Text(item.contentType.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 100), // padding for FAB
          ],
        ),
      ),
      floatingActionButton: dueAsync.maybeWhen(
        data: (dueList) => dueList.isEmpty
            ? null
            : FloatingActionButton.extended(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                label: const Text('Start Review Session', style: TextStyle(fontWeight: FontWeight.bold)),
                icon: const Icon(Icons.psychology_rounded),
                onPressed: () => _startSession(context, ref, dueList),
              ),
        orElse: () => null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _startSession(BuildContext context, WidgetRef ref, List<ReviewItem> items) {
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No items to review!')),
      );
      return;
    }
    ref.read(reviewSessionNotifierProvider.notifier).startSession(items);
    context.push('/review/session');
  }

  Widget _buildStatsPanel(BuildContext context, Map<String, dynamic> stats) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Review Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatMetric('Total Reviewed', '${stats['totalReviews']}', Icons.history),
              _buildStatMetric('Accuracy', '${(stats['accuracy'] as double).toStringAsFixed(1)}%', Icons.check_circle_outline),
              _buildStatMetric('Streak', '${stats['currentStreak']} days', Icons.local_fire_department),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: PremiumDesignSystem.primaryBlue, size: 24),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  Widget _buildQueueCard(
    BuildContext context, {
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('$count items pending', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
