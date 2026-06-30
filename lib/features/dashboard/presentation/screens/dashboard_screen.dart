import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_planner_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/review_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_planner_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/review_providers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/gamification_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/widgets/confetti_overlay.dart';
import 'package:shinka_track_n3/features/study/domain/entities/gamification_entities.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _activeReviewTab = 0; // 0 = Due Today, 1 = Missed, 2 = Upcoming

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overallProgressAsync = ref.watch(overallProgressProvider);
    final streakAsync = ref.watch(streakProvider);
    final sessionsAsync = ref.watch(studySessionsProvider);
    final goalAsync = ref.watch(dailyGoalProvider);
    final planAsync = ref.watch(activePlanProvider);

    final statsAsync = ref.watch(userStatsProvider);
    final weeklyGoalAsync = ref.watch(weeklyGoalProvider);
    final achievementsAsync = ref.watch(achievementsProvider);

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculate today's study minutes dynamically from SQLite session logs
    double todayMinutes = 0.0;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayStr = formatter.format(DateTime.now());

    sessionsAsync.whenData((sessions) {
      final todaySessions = sessions.where((s) => formatter.format(s.date) == todayStr);
      final int totalSec = todaySessions.fold(0, (sum, s) => sum + s.durationSeconds);
      todayMinutes = totalSec / 60.0;
    });

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text(
          '進化 SHINKA',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            fontSize: 20,
          ),
        ),
      ),
      body: ConfettiOverlay(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'こんにちは!',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your path to JLPT N3 mastery.',
                        style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 14),
                      ),
                    ],
                  ),
                  // Gamification HUD Cluster
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Streak Pill
                      streakAsync.maybeWhen(
                        data: (streak) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.orange.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '$streak d',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        orElse: () => const SizedBox(),
                      ),
                      const SizedBox(width: 6),
                      // Coins & Level HUD
                      statsAsync.maybeWhen(
                        data: (stats) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.amber.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${stats.coins}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: PremiumDesignSystem.primaryBlue.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: PremiumDesignSystem.primaryBlue.withOpacity(0.2)),
                              ),
                              child: Text(
                                'Lvl ${stats.level}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: PremiumDesignSystem.primaryBlue),
                              ),
                            ),
                          ],
                        ),
                        orElse: () => const SizedBox(),
                      ),
                    ],
                  )
                ],
              ),
              // XP Progress Bar
              statsAsync.maybeWhen(
                data: (stats) => Padding(
                  padding: const EdgeInsets.only(top: 14.0, bottom: 4.0),
                  child: Row(
                    children: [
                      const Text(
                        'Level Progress',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: stats.xpInLevel / stats.xpNeededForNextLevel,
                            minHeight: 6,
                            backgroundColor: isDark ? Colors.white10 : Colors.black12,
                            valueColor: AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${stats.xpInLevel}/${stats.xpNeededForNextLevel} XP',
                        style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                orElse: () => const SizedBox(),
              ),
              const SizedBox(height: 28),

              // Smart Study Planner Config / Overview Widget
              _buildPlannerOverviewCard(context, planAsync),
              const SizedBox(height: 28),

              // Today's Study Plan Tasks
              if (planAsync.value != null) ...[
                const Text(
                  "Today's Plan Tasks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.2),
                ),
                const SizedBox(height: 14),
                _buildTodayTasksWidget(context),
                const SizedBox(height: 28),
              ],

              // Spaced Repetition Revision Engine Tabbed Widget
              const Text(
                'Spaced Repetition Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.2),
              ),
              const SizedBox(height: 14),
              _buildReviewEngineWidget(context),
              const SizedBox(height: 28),

              // Overall Completion Gauge (Duolingo style)
              _buildOverallCompletionGauge(context, overallProgressAsync, todayMinutes),
              const SizedBox(height: 28),

              // Daily Goal Section
              _buildDailyGoalProgress(context, goalAsync),
              const SizedBox(height: 28),

              // Weekly Goal Section
              _buildWeeklyGoalCard(context, weeklyGoalAsync),
              const SizedBox(height: 28),

              // Calendar Heatmap (GitHub style)
              _buildCalendarHeatmap(context, sessionsAsync.value ?? []),
              const SizedBox(height: 28),

              // Achievements Section
              _buildAchievementsSection(context, achievementsAsync),
              const SizedBox(height: 28),

              // 5 Progress Cards (Kanji, Vocab, Grammar, Reading, Listening)
              const Text(
                'Study Modules Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.2),
              ),
              const SizedBox(height: 14),
              _buildProgressCardsList(context, overallProgressAsync),
              const SizedBox(height: 36),
            ],
            ),
          ),
        ),
      ),
    );
  }

  // --- REVISION ENGINE TABBED VIEW ---

  Widget _buildReviewEngineWidget(BuildContext context) {
    final dueAsync = ref.watch(dueReviewsProvider);
    final missedAsync = ref.watch(missedReviewsProvider);
    final upcomingAsync = ref.watch(upcomingReviewsProvider);

    // Get lengths dynamically
    final int dueCount = dueAsync.value?.length ?? 0;
    final int missedCount = missedAsync.value?.length ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Selector Row
        Row(
          children: [
            _buildReviewTabHeader(0, 'Due Today ($dueCount)', dueCount > 0 ? Colors.orange : null),
            const SizedBox(width: 8),
            _buildReviewTabHeader(1, 'Missed ($missedCount)', missedCount > 0 ? Colors.red : null),
            const SizedBox(width: 8),
            _buildReviewTabHeader(2, 'Upcoming', null),
          ],
        ),
        const SizedBox(height: 12),

        // List builder based on active tab
        if (_activeReviewTab == 0)
          _buildDueReviewsList(dueAsync)
        else if (_activeReviewTab == 1)
          _buildMissedReviewsList(missedAsync)
        else
          _buildUpcomingReviewsList(upcomingAsync),
      ],
    );
  }

  Widget _buildReviewTabHeader(int tabIndex, String label, Color? highlightColor) {
    final bool isSelected = _activeReviewTab == tabIndex;
    final Color color = highlightColor ?? PremiumDesignSystem.primaryBlue;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeReviewTab = tabIndex;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color.withOpacity(0.3) : Colors.grey.withOpacity(0.15),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? color : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDueReviewsList(AsyncValue<List<ReviewItemEntity>> dueAsync) {
    return dueAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error loading reviews'),
      data: (list) {
        if (list.isEmpty) {
          return GlassCard(
            padding: const EdgeInsets.all(20.0),
            child: const Row(
              children: [
                Icon(Icons.check_circle_outline, color: PremiumDesignSystem.forestEmerald, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    '🎉 All caught up on due reviews! Shinka tracks your revision schedule automatically.',
                    style: TextStyle(fontSize: 13, height: 1.3),
                  ),
                )
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final r = list[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(r.details, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 6),
                          _buildIntervalBadge(r.stage),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () async {
                        HapticFeedback.mediumImpact();
                        await ref.read(dueReviewsProvider.notifier).completeReview(r.id);
                        ref.read(confettiTriggerProvider.notifier).state++;
                        ref.read(userStatsProvider.notifier).load();
                        ref.read(weeklyGoalProvider.notifier).load();
                      },
                      icon: const Icon(Icons.check, size: 20),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMissedReviewsList(AsyncValue<List<ReviewItemEntity>> missedAsync) {
    return missedAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error loading missed reviews'),
      data: (list) {
        if (list.isEmpty) {
          return GlassCard(
            padding: const EdgeInsets.all(20.0),
            child: const Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined, color: Colors.green, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'You have zero missed/overdue reviews. You are on track with your schedule!',
                    style: TextStyle(fontSize: 13, height: 1.3),
                  ),
                )
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final r = list[index];
            final int overdueDays = DateTime.now().difference(r.nextReviewDate).inDays;
            final overdueText = overdueDays <= 0 ? 'Overdue' : '$overdueDays days overdue';

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(r.details, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              _buildIntervalBadge(r.stage),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  overdueText,
                                  style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () async {
                        HapticFeedback.mediumImpact();
                        await ref.read(missedReviewsProvider.notifier).completeReview(r.id);
                        ref.read(confettiTriggerProvider.notifier).state++;
                        ref.read(userStatsProvider.notifier).load();
                        ref.read(weeklyGoalProvider.notifier).load();
                      },
                      icon: const Icon(Icons.check, size: 20),
                      style: IconButton.styleFrom(backgroundColor: Colors.red),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUpcomingReviewsList(AsyncValue<List<ReviewItemEntity>> upcomingAsync) {
    return upcomingAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error loading upcoming reviews'),
      data: (list) {
        if (list.isEmpty) {
          return GlassCard(
            padding: const EdgeInsets.all(20.0),
            child: const Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'No upcoming reviews scheduled. Complete more lessons to schedule them!',
                    style: TextStyle(fontSize: 13, height: 1.3),
                  ),
                )
              ],
            ),
          );
        }

        // Sort upcoming lists by nearest dates
        final sortedList = List<ReviewItemEntity>.from(list)
          ..sort((a, b) => a.nextReviewDate.compareTo(b.nextReviewDate));

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: min(sortedList.length, 5), // Limit to top 5
          itemBuilder: (context, index) {
            final r = sortedList[index];
            final String dateStr = DateFormat('MMM d, yyyy').format(r.nextReviewDate);

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(r.details, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          dateStr,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue),
                        ),
                        const SizedBox(height: 4),
                        _buildIntervalBadge(r.stage),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIntervalBadge(int stage) {
    final intervals = ['1d', '3d', '7d', '14d', '30d', '90d', 'Finished'];
    final stageText = stage >= 6 ? 'Mastered' : 'Interval: ${intervals[stage]}';
    final Color badgeColor = stage >= 6 ? PremiumDesignSystem.forestEmerald : PremiumDesignSystem.primaryBlue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        stageText,
        style: TextStyle(fontSize: 10, color: badgeColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  // --- SMART PLANNER CONFIG/OVERVIEW WIDGET ---

  Widget _buildPlannerOverviewCard(BuildContext context, AsyncValue<StudyPlanEntity?> planAsync) {
    return planAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error loading study plan'),
      data: (plan) {
        if (plan == null) {
          return InkWell(
            onTap: () => context.push('/planner'),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: PremiumDesignSystem.sakuraGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: PremiumDesignSystem.secondaryPink.withOpacity(0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Generate N3 Study Plan',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Input your timeline and available hours. Shinka automatically schedules balanced study and review tasks.',
                          style: TextStyle(fontSize: 12.5, color: Colors.white.withOpacity(0.9), height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  const CircleAvatar(
                    backgroundColor: Colors.white30,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              ),
            ),
          );
        }

        final int totalDays = plan.targetDate.difference(DateTime.now()).inDays;
        final remainingDays = totalDays < 0 ? 0 : totalDays + 1;

        return GlassCard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Study Plan',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Target Date: ${DateFormat('MMM d, yyyy').format(plan.targetDate)}',
                        style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/planner'),
                    icon: const Icon(Icons.edit, size: 14),
                    label: const Text('Edit Plan', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      minimumSize: Size.zero,
                    ),
                  ),
                ],
              ),
              const Divider(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPlanSummaryCol('Remaining', '$remainingDays days'),
                  _buildPlanSummaryCol('Daily Target', '${plan.availableHours.toStringAsFixed(1)} hrs'),
                  _buildPlanSummaryCol('Status', remainingDays > 0 ? 'ON TRACK' : 'COMPLETED', color: remainingDays > 0 ? Colors.green : Colors.blue),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlanSummaryCol(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.5,
            color: color,
          ),
        ),
      ],
    );
  }

  // --- TODAY'S PLANNER TASKS LIST ---

  Widget _buildTodayTasksWidget(BuildContext context) {
    final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final tasksAsync = ref.watch(dailyTasksProvider(today));

    return tasksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error loading today\'s tasks'),
      data: (tasks) {
        if (tasks.isEmpty) {
          final isSunday = DateTime.now().weekday == DateTime.sunday;
          return GlassCard(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  isSunday ? Icons.spa_outlined : Icons.celebration,
                  color: isSunday ? PremiumDesignSystem.forestEmerald : Colors.amber,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isSunday
                        ? '🍀 Sunday Review Day: No new lessons today. Take some time to review this week\'s learned materials.'
                        : '🎉 No tasks scheduled for today! Enjoy your rest or add new goals in the planner.',
                    style: const TextStyle(fontSize: 13, height: 1.3),
                  ),
                )
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                borderRadius: 16,
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (val) async {
                        if (val != null) {
                          HapticFeedback.mediumImpact();
                          await ref.read(dailyTasksProvider(today).notifier).toggleTask(task.id, val);
                          if (val) {
                            ref.read(confettiTriggerProvider.notifier).state++;
                          }
                          ref.read(userStatsProvider.notifier).load();
                          ref.read(weeklyGoalProvider.notifier).load();
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => _navigateToTaskTab(context, task),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.5,
                                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                color: task.isCompleted ? Colors.grey : null,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              task.details,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!task.isReview)
                      const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _navigateToTaskTab(BuildContext context, PlannerTaskEntity task) {
    if (task.isReview) return;

    int tabIndex = 0;
    if (task.itemType == 'kanji') tabIndex = 0;
    if (task.itemType == 'vocab') tabIndex = 1;
    if (task.itemType == 'grammar') tabIndex = 2;
    if (task.itemType == 'reading') tabIndex = 3;
    if (task.itemType == 'listening') tabIndex = 4;

    ref.read(studyTabProvider.notifier).state = tabIndex;
    context.go('/study');
  }

  // --- OVERALL COMPLETION GAUGE ---

  Widget _buildOverallCompletionGauge(
    BuildContext context,
    AsyncValue<ProgressStats> progressAsync,
    double todayMinutes,
  ) {
    return GlassCard(
      child: progressAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Text('Error loading progress stats'),
        data: (stats) {
          final percentage = (stats.overall * 100).toInt();

          return Row(
            children: [
              // Circular progress gauge
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: stats.overall,
                      strokeWidth: 9,
                      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      color: PremiumDesignSystem.primaryBlue,
                      strokeCap: StrokeCap.round,
                    ),
                    Text(
                      '$percentage%',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -1),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overall N3 Completion',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.3),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You studied ${todayMinutes.toStringAsFixed(1)} minutes today.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Small level label
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getLevelName(stats.kanjiMastered + stats.vocabMastered + stats.grammarMastered + stats.readingMastered + stats.listeningMastered),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getLevelName(int masteredCount) {
    if (masteredCount >= 35) return 'N3 Master (達人)';
    if (masteredCount >= 18) return 'N3 Warrior (武士)';
    if (masteredCount >= 8) return 'Chrysalis (さなぎ)';
    if (masteredCount >= 2) return 'Larva (青虫)';
    return 'Shinka Egg (たまご)';
  }

  // --- DAILY GOAL CARD ---

  Widget _buildDailyGoalProgress(BuildContext context, AsyncValue<DailyGoalEntity> goalAsync) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daily Goal Progress",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.spa_outlined,
                color: PremiumDesignSystem.forestEmerald,
                size: 20,
              )
            ],
          ),
          const SizedBox(height: 18),
          goalAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading goal'),
            data: (goal) {
              final double timeRatio = (goal.completedSeconds / goal.targetSeconds).clamp(0.0, 1.0);
              final double itemRatio = (goal.completedItems / goal.targetItems).clamp(0.0, 1.0);

              final int minStudied = goal.completedSeconds ~/ 60;
              final int targetMin = goal.targetSeconds ~/ 60;

              return Column(
                children: [
                  _buildLinearGoalBar(
                    context,
                    'Focus Study Duration',
                    '$minStudied / $targetMin min',
                    timeRatio,
                    PremiumDesignSystem.primaryBlue,
                  ),
                  const SizedBox(height: 14),
                  _buildLinearGoalBar(
                    context,
                    'Checkable Items Mastered',
                    '${goal.completedItems} / ${goal.targetItems}',
                    itemRatio,
                    PremiumDesignSystem.secondaryPink,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLinearGoalBar(
    BuildContext context,
    String label,
    String value,
    double ratio,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 8,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // --- CALENDAR HEATMAP ---

  Widget _buildCalendarHeatmap(BuildContext context, List<StudySessionEntity> sessions) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final Map<String, int> dailySeconds = {};

    final List<DateTime> last28Days = List.generate(
      28,
      (index) => DateTime.now().subtract(Duration(days: 27 - index)),
    );

    for (var date in last28Days) {
      dailySeconds[formatter.format(date)] = 0;
    }

    for (var session in sessions) {
      final dateKey = formatter.format(session.date);
      if (dailySeconds.containsKey(dateKey)) {
        dailySeconds[dateKey] = dailySeconds[dateKey]! + session.durationSeconds;
      }
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Focus Heatmap (28 Days)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.grid_on, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 14),
          // Heatmap grid (4 columns/weeks, 7 rows/days)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 7 days in a row
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1.0,
            ),
            itemCount: 28,
            itemBuilder: (context, index) {
              final date = last28Days[index];
              final key = formatter.format(date);
              final seconds = dailySeconds[key] ?? 0;
              final minutes = seconds ~/ 60;

              Color cellColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
              if (minutes > 15) {
                cellColor = const Color(0xFF047857); // Deep Green
              } else if (minutes > 5) {
                cellColor = const Color(0xFF10B981); // Medium Green
              } else if (minutes > 0) {
                cellColor = const Color(0xFF6EE7B7); // Light Green
              }

              return Tooltip(
                message: '${DateFormat('MMM d').format(date)}: $minutes mins studied',
                child: Container(
                  decoration: BoxDecoration(
                    color: cellColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Less', style: TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(width: 4),
              _buildSmallLegendBox(isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
              _buildSmallLegendBox(const Color(0xFF6EE7B7)),
              _buildSmallLegendBox(const Color(0xFF10B981)),
              _buildSmallLegendBox(const Color(0xFF047857)),
              const SizedBox(width: 4),
              const Text('More', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSmallLegendBox(Color color) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // --- 5 MODULE PROGRESS CARDS ---

  Widget _buildProgressCardsList(BuildContext context, AsyncValue<ProgressStats> statsAsync) {
    return statsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error loading progress stats'),
      data: (stats) {
        return Column(
          children: [
            _buildModuleProgressCard(
              context,
              title: 'Kanji (漢字)',
              mastered: stats.kanjiMastered,
              total: stats.kanjiTotal,
              color: PremiumDesignSystem.primaryBlue,
              tabIndex: 0,
            ),
            const SizedBox(height: 12),
            _buildModuleProgressCard(
              context,
              title: 'Vocabulary (語彙)',
              mastered: stats.vocabMastered,
              total: stats.vocabTotal,
              color: PremiumDesignSystem.secondaryPink,
              tabIndex: 1,
            ),
            const SizedBox(height: 12),
            _buildModuleProgressCard(
              context,
              title: 'Grammar (文法)',
              mastered: stats.grammarMastered,
              total: stats.grammarTotal,
              color: PremiumDesignSystem.amberGold,
              tabIndex: 2,
            ),
            const SizedBox(height: 12),
            _buildModuleProgressCard(
              context,
              title: 'Reading (読解)',
              mastered: stats.readingMastered,
              total: stats.readingTotal,
              color: Colors.teal,
              tabIndex: 3,
            ),
            const SizedBox(height: 12),
            _buildModuleProgressCard(
              context,
              title: 'Listening (聴解)',
              mastered: stats.listeningMastered,
              total: stats.listeningTotal,
              color: Colors.purple,
              tabIndex: 4,
            ),
          ],
        );
      },
    );
  }

  Widget _buildModuleProgressCard(
    BuildContext context, {
    required String title,
    required int mastered,
    required int total,
    required Color color,
    required int tabIndex,
  }) {
    final double ratio = total == 0 ? 0.0 : (mastered / total);

    return InkWell(
      onTap: () {
        // Set active tab reactively in provider and navigate
        ref.read(studyTabProvider.notifier).state = tabIndex;
        context.go('/study');
      },
      borderRadius: BorderRadius.circular(20),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              width: 12,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 6,
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '$mastered / $total',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // --- GAMIFICATION WIDGETS ---

  Widget _buildWeeklyGoalCard(BuildContext context, AsyncValue<WeeklyGoalEntity> weeklyGoalAsync) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return weeklyGoalAsync.maybeWhen(
      data: (goal) {
        final double minutesCompleted = goal.completedSeconds / 60.0;
        final double minutesTarget = goal.targetSeconds / 60.0;

        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Weekly Study Challenge',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.emoji_events,
                    color: (minutesCompleted >= minutesTarget && goal.completedItems >= goal.targetItems)
                        ? Colors.amber
                        : Colors.grey,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Study 90 minutes and complete 50 lessons this week to claim bonus rewards.',
                style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Weekly Focus Time', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(
                    '${minutesCompleted.toStringAsFixed(0)} / ${minutesTarget.toStringAsFixed(0)} min',
                    style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: goal.timeRatio,
                  minHeight: 8,
                  backgroundColor: isDark ? Colors.white10 : Colors.black12,
                  valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Lessons Completed', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(
                    '${goal.completedItems} / ${goal.targetItems}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: goal.itemRatio,
                  minHeight: 8,
                  backgroundColor: isDark ? Colors.white10 : Colors.black12,
                  valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.secondaryPink),
                ),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox(),
    );
  }

  Widget _buildAchievementsSection(BuildContext context, AsyncValue<List<AchievementEntity>> achievementsAsync) {
    return achievementsAsync.maybeWhen(
      data: (achievements) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Achievements & Badges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.2),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final ach = achievements[index];
                  final bool unlocked = ach.isUnlocked;

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Row(
                            children: [
                              Icon(
                                unlocked ? Icons.verified : Icons.lock_outline,
                                color: unlocked ? Colors.green : Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(ach.title)),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ach.description,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Chip(
                                    label: Text('+${ach.xpReward} XP'),
                                    backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.12),
                                  ),
                                  const SizedBox(width: 8),
                                  Chip(
                                    label: Text('+${ach.coinReward} Coins'),
                                    backgroundColor: Colors.amber.withValues(alpha: 0.12),
                                  ),
                                ],
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Nice!'),
                            )
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: unlocked
                                      ? PremiumDesignSystem.sakuraGradient
                                      : const LinearGradient(colors: [Colors.grey, Colors.blueGrey]),
                                  boxShadow: unlocked
                                      ? [
                                          BoxShadow(
                                            color: PremiumDesignSystem.secondaryPink.withValues(alpha: 0.25),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Icon(
                                  unlocked ? Icons.emoji_events : Icons.lock,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                              if (unlocked)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ach.title,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
      orElse: () => const SizedBox(),
    );
  }
}
