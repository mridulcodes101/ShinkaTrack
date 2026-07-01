import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/planner/application/planner_notifier.dart';
import 'package:shinka_track_n3/features/planner/domain/models/planner_task.dart';

class PlannerDashboardScreen extends ConsumerStatefulWidget {
  const PlannerDashboardScreen({super.key});

  @override
  ConsumerState<PlannerDashboardScreen> createState() => _PlannerDashboardScreenState();
}

class _PlannerDashboardScreenState extends ConsumerState<PlannerDashboardScreen> {
  bool _showSettings = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(plannerNotifierProvider.notifier).loadActivePlan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final plannerState = ref.watch(plannerNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (plannerState.isLoading) {
      return Scaffold(
        backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final activePlan = plannerState.activePlan;
    if (activePlan == null) {
      return Scaffold(
        backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
        appBar: AppBar(
          title: const Text('Study Planner', style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: isDark ? Colors.white : Colors.black,
        ),
        body: _buildEmptyState(context),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Study Planner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(
              'Targeting ${activePlan.goal}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: Icon(_showSettings ? Icons.dashboard_rounded : Icons.settings_rounded),
            tooltip: _showSettings ? 'Dashboard' : 'Plan Settings',
            onPressed: () => setState(() => _showSettings = !_showSettings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showSettings) ...[
              _buildSettingsPanel(context, activePlan),
            ] else ...[
              // Progress summary card
              _buildProgressCard(context),
              const SizedBox(height: 20),

              // Calendar Days selector
              const Text(
                'WEEK VIEW',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
              ),
              const SizedBox(height: 10),
              _buildWeekSelector(context),
              const SizedBox(height: 24),

              // Tasks section
              _buildSelectedDayTasksSection(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.menu_book_rounded, size: 80, color: PremiumDesignSystem.primaryBlue),
            ),
            const SizedBox(height: 24),
            const Text(
              'Create Your Study Plan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Align your daily Japanese lessons, allocate resources, choose target exams, and track progress interactively.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 50,
              width: 220,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PremiumDesignSystem.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () => context.push('/planner/setup'),
                child: const Text('Start Setup', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    final progressAsync = ref.watch(plannerProgressStatsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return progressAsync.maybeWhen(
      data: (stats) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: PremiumDesignSystem.premiumShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Plan Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${stats['completedTasks']} / ${stats['totalTasks']} tasks completed', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniStat('Remaining', '${stats['remainingDays']} days'),
                      _buildMiniStat('Consistency', '92%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: (stats['completionPercent'] as double) / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.withValues(alpha: 0.15),
                    valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
                  ),
                ),
                Text(
                  '${(stats['completionPercent'] as double).toStringAsFixed(0)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildWeekSelector(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get 7 days centered on selected date
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final List<DateTime> weekDays = List.generate(7, (i) => startOfWeek.add(Duration(days: i)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDays.map((day) {
        final isSel = DateUtils.isSameDay(day, selectedDate);
        final isToday = DateUtils.isSameDay(day, DateTime.now());
        
        return GestureDetector(
          onTap: () => ref.read(selectedDateProvider.notifier).state = day,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: isSel 
                  ? PremiumDesignSystem.primaryBlue 
                  : (isToday ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1) : Colors.transparent),
              borderRadius: BorderRadius.circular(12),
              border: isToday && !isSel 
                  ? Border.all(color: PremiumDesignSystem.primaryBlue, width: 1.5) 
                  : null,
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('E').format(day).substring(0, 1),
                  style: TextStyle(
                    fontSize: 11, 
                    fontWeight: FontWeight.bold,
                    color: isSel ? Colors.white : (isDark ? Colors.white60 : Colors.black54),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.bold,
                    color: isSel ? Colors.white : (isDark ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSelectedDayTasksSection(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final tasksAsync = ref.watch(dailyTasksProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('EEEE, MMMM d').format(selectedDate),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Actions
            Row(
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.skip_next_rounded, size: 18),
                  label: const Text('Skip Day', style: TextStyle(fontSize: 12)),
                  onPressed: () async {
                    await ref.read(plannerNotifierProvider.notifier).skipDay();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Day skipped. Tasks rescheduled.')),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        tasksAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => const Text('Error loading tasks'),
          data: (tasks) {
            if (tasks.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.done_all_rounded, color: Colors.green, size: 48),
                    SizedBox(height: 12),
                    Text('No Tasks Scheduled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('Enjoy your rest day or adjust study days in Settings!', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              );
            }

            return Column(
              children: tasks.map((task) => _buildTaskItemTile(context, task)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTaskItemTile(BuildContext context, PlannerTask task) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: CheckboxListTile(
        activeColor: PremiumDesignSystem.primaryBlue,
        title: Text(
          task.isReview ? 'Weekly Review Session' : 'Learn ${task.itemType.toUpperCase()}',
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Duration: ${task.duration} mins | ID: ${task.itemId}',
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        value: task.isCompleted,
        onChanged: (val) {
          if (val != null) {
            ref.read(plannerNotifierProvider.notifier).toggleTask(task.id, val);
          }
        },
      ),
    );
  }

  Widget _buildSettingsPanel(BuildContext context, dynamic activePlan) {
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
          const Text('Plan Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildSettingsOptionRow(
            'Target Exam Date',
            DateFormat('MMMM d, yyyy').format(activePlan.targetDate),
            Icons.calendar_month,
          ),
          const Divider(),
          _buildSettingsOptionRow(
            'Daily Commit Time',
            '${activePlan.availableHours.toInt()} Minutes',
            Icons.timer,
          ),
          const Divider(),
          _buildSettingsOptionRow(
            'Goal Rank',
            '${activePlan.goal}',
            Icons.emoji_events,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                await ref.read(plannerNotifierProvider.notifier).recalculatePlan();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Plan rescheduled & updated successfully!')),
                  );
                }
              },
              child: const Text('Recalculate & Redistribute Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => context.push('/planner/setup'),
              child: const Text('Restart Plan Setup Wizard', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptionRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: PremiumDesignSystem.primaryBlue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
