import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';
import 'package:shinka_track_n3/core/widgets/app_card.dart';
import 'package:shinka_track_n3/core/widgets/section_header.dart';
import 'package:shinka_track_n3/core/navigation/responsive_layout.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/gamification_providers.dart';
import 'package:shinka_track_n3/features/achievements/application/achievements_notifier.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/progression_config.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/notifications/presentation/widgets/reminder_card.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeFabProvider.notifier).state = FabConfig(
        label: 'Start Study',
        icon: Icons.school,
        onPressed: () => context.go('/study'),
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (ref.read(activeFabProvider)?.label == 'Start Study') {
          ref.read(activeFabProvider.notifier).state = null;
        }
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    // Watch providers
    final streak = ref.watch(streakProvider).value ?? 0;
    final dailyGoal = ref.watch(dailyGoalProvider).value;
    final weeklyGoal = ref.watch(weeklyGoalProvider).value;
    final userXp = ref.watch(userXpProvider).value ?? 0;
    final userLevel = ProgressionConfig.calculateLevelFromXp(userXp);

    final kanjis = ref.watch(kanjiListProvider).value ?? [];
    final vocabs = ref.watch(vocabListProvider).value ?? [];
    final grammars = ref.watch(grammarListProvider).value ?? [];
    final readings = ref.watch(readingListProvider).value ?? [];
    final listenings = ref.watch(listeningListProvider).value ?? [];

    // Calculations
    final totalAdded = kanjis.where((k) => k.isAdded).length +
        vocabs.where((v) => v.status == StudyStatus.learning || v.status == StudyStatus.mastered).length;
    final totalLearned = kanjis.where((k) => k.isLearned).length +
        vocabs.where((v) => v.status == StudyStatus.mastered).length;
    final completionPct = totalAdded == 0 ? 0.0 : (totalLearned / totalAdded);

    final completedLessons = totalLearned;
    final studyTimeMinutes = dailyGoal?.completedSeconds != null
        ? (dailyGoal!.completedSeconds / 60.0).toStringAsFixed(1)
        : '0.0';

    final dueReviewsCount = kanjis.where((k) => k.isAdded && !k.isLearned).length;
    final estReviewMinutes = (dueReviewsCount * 0.5).toStringAsFixed(0);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Mridul',
              style: AppTypography.headlineLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ready to continue your Japanese journey?',
              style: AppTypography.bodyMedium.copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_rounded, color: PremiumDesignSystem.primaryBlue),
            tooltip: 'Level $userLevel ($userXp XP)',
            onPressed: () => context.push('/achievements'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: GestureDetector(
              onTap: () => context.push('/settings'),
              child: Hero(
                tag: 'profile_avatar_hero',
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Text(
                    'M',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            children: [
              // 1. TODAY'S PROGRESS CARD
              const SectionHeader(title: "Today's Progress"),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgressItem('Completed Lessons', '$completedLessons', isDark),
                        const VerticalDivider(),
                        _buildProgressItem('Study Time', '${studyTimeMinutes}m', isDark),
                        const VerticalDivider(),
                        _buildProgressItem('Completion', '${(completionPct * 100).toStringAsFixed(0)}%', isDark),
                      ],
                    ),
                    AppSpacing.gapMD,
                    ClipRRect(
                      borderRadius: AppRadius.radiusSM,
                      child: LinearProgressIndicator(
                        value: completionPct,
                        minHeight: 8,
                        backgroundColor: isDark ? Colors.white10 : Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 1.2 STUDY SESSION TRIGGER
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
                            child: const Icon(Icons.school, color: PremiumDesignSystem.primaryBlue),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Start Study Session', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                SizedBox(height: 4),
                                Text('Orchestrate tasks, reviews, and track study time.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PremiumDesignSystem.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            context.push('/study_session?type=guided&modules=Kanji,Vocabulary,Grammar');
                          },
                          child: const Text('Start Guided Study', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 1.5 SMART REMINDERS
              const SectionHeader(title: "Upcoming Smart Alerts"),
              const SizedBox(height: AppSpacing.sm),
              const ReminderCard(),
              const SizedBox(height: AppSpacing.lg),

              // 2. TODAY'S STUDY PLAN
              const SectionHeader(title: "Today's Study Plan"),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    _buildPlanRow('Today\'s Kanji', kanjis.isNotEmpty ? 'Pending' : 'Completed', isDark, () => context.go('/study')),
                    const Divider(height: 1),
                    _buildPlanRow('Today\'s Vocabulary', vocabs.isNotEmpty ? 'Pending' : 'Completed', isDark, () => context.go('/study')),
                    const Divider(height: 1),
                    _buildPlanRow('Today\'s Grammar', grammars.isNotEmpty ? 'Pending' : 'Completed', isDark, () => context.go('/study')),
                    const Divider(height: 1),
                    _buildPlanRow('Today\'s Reading', readings.isNotEmpty ? 'Pending' : 'Completed', isDark, () => context.go('/study')),
                    const Divider(height: 1),
                    _buildPlanRow('Today\'s Listening', listenings.isNotEmpty ? 'Pending' : 'Completed', isDark, () => context.go('/study')),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. UPCOMING REVIEWS
              const SectionHeader(title: "Upcoming Reviews"),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.psychology, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$dueReviewsCount reviews due today', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: AppSpacing.xxs),
                          Text('Estimated time: $estReviewMinutes minutes', style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontSize: 13)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => context.go('/review'),
                      child: const Text('Open Review'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 4. CURRENT STREAK
              const SectionHeader(title: "Current Streak"),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$streak Days',
                          style: AppTypography.headlineLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        const Text('Keep the streak burning!', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_fire_department, color: Colors.orange, size: 36),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 5. WEEKLY PROGRESS
              const SectionHeader(title: "Weekly Progress"),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Goal: ${weeklyGoal?.targetItems ?? 10} items',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Completed: ${weeklyGoal?.completedItems ?? 0}',
                          style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    AppSpacing.gapSM,
                    ClipRRect(
                      borderRadius: AppRadius.radiusSM,
                      child: LinearProgressIndicator(
                        value: (weeklyGoal?.targetItems ?? 10) == 0
                            ? 0.0
                            : ((weeklyGoal?.completedItems ?? 0) / (weeklyGoal?.targetItems ?? 10)),
                        minHeight: 8,
                        backgroundColor: isDark ? Colors.white10 : Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 6. STUDY HEATMAP (Placeholder)
              const SectionHeader(title: "Study Heatmap"),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Container(
                  height: 120,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grid_on_outlined, size: 36, color: theme.colorScheme.primary.withValues(alpha: 0.6)),
                      AppSpacing.gapSM,
                      const Text('Activity Heatmap Calendar', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: AppSpacing.xxs),
                      const Text('Your study frequency stats will map here', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 7. QUICK ACTIONS
              const SectionHeader(title: "Quick Actions"),
              const SizedBox(height: AppSpacing.sm),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.6,
                children: [
                  _buildQuickAction('Start Study', Icons.school, Colors.indigo, () => context.go('/study')),
                  _buildQuickAction('Review Now', Icons.psychology, Colors.purple, () => context.go('/review')),
                  _buildQuickAction('Planner', Icons.calendar_month, Colors.teal, () => context.go('/planner')),
                  _buildQuickAction('Statistics', Icons.insights, Colors.blue, () => context.go('/analytics')),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressItem(String label, String value, bool isDark) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w800, color: Colors.blue),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanRow(String title, String progress, bool isDark, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text(
                progress,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(width: AppSpacing.md),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: onTap,
                child: const Text('Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String label, IconData icon, Color color, VoidCallback onTap) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
