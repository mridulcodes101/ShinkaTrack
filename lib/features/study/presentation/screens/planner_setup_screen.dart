import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';
import 'package:shinka_track_n3/core/widgets/app_card.dart';
import 'package:shinka_track_n3/core/widgets/section_header.dart';
import 'package:shinka_track_n3/core/navigation/responsive_layout.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_planner_providers.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:intl/intl.dart';

class PlannerSetupScreen extends ConsumerStatefulWidget {
  const PlannerSetupScreen({super.key});

  @override
  ConsumerState<PlannerSetupScreen> createState() => _PlannerSetupScreenState();
}

class _PlannerSetupScreenState extends ConsumerState<PlannerSetupScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _targetDate = DateTime.now().add(const Duration(days: 30));
  double _availableHours = 2.0;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeFabProvider.notifier).state = FabConfig(
        label: 'Create Plan',
        icon: Icons.add,
        onPressed: _submitPlanForm,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(activeFabProvider)?.label == 'Create Plan') {
        ref.read(activeFabProvider.notifier).state = null;
      }
    });
    super.dispose();
  }

  void _submitPlanForm() async {
    final plan = ref.read(activePlanProvider).value;
    final studyDaysCount = _calculateStudyDays();
    if (studyDaysCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Target completion must be after start date!')),
      );
      return;
    }

    await ref.read(activePlanProvider.notifier).createPlan(
          startDate: _startDate,
          targetDate: _targetDate,
          availableHours: _availableHours,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(plan != null ? 'Study Plan Updated successfully!' : 'Study Plan Generated successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  int _calculateStudyDays() {
    int studyDays = 0;
    DateTime temp = _startDate;
    while (!temp.isAfter(_targetDate)) {
      if (temp.weekday != DateTime.sunday) {
        studyDays++;
      }
      temp = temp.add(const Duration(days: 1));
    }
    return studyDays;
  }

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(activePlanProvider);
    final kanjiAsync = ref.watch(kanjiListProvider);
    final vocabAsync = ref.watch(vocabListProvider);
    final grammarAsync = ref.watch(grammarListProvider);
    final readingAsync = ref.watch(readingListProvider);
    final listeningAsync = ref.watch(listeningListProvider);

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Pre-populate form state if active plan exists
    planAsync.whenData((plan) {
      if (plan != null && !_initialized) {
        _startDate = plan.startDate;
        _targetDate = plan.targetDate;
        _availableHours = plan.availableHours;
        _initialized = true;
      }
    });

    // Derive workload stats
    int unlearnedCount = 0;
    int masteredCount = 0;

    kanjiAsync.whenData((list) {
      unlearnedCount += list.where((x) => !x.isLearned).length;
      masteredCount += list.where((x) => x.isLearned).length;
    });
    vocabAsync.whenData((list) {
      unlearnedCount += list.where((x) => x.status != StudyStatus.mastered).length;
      masteredCount += list.where((x) => x.status == StudyStatus.mastered).length;
    });
    grammarAsync.whenData((list) {
      unlearnedCount += list.where((x) => x.status != StudyStatus.mastered).length;
      masteredCount += list.where((x) => x.status == StudyStatus.mastered).length;
    });
    readingAsync.whenData((list) {
      unlearnedCount += list.where((x) => x.status != StudyStatus.mastered).length;
      masteredCount += list.where((x) => x.status == StudyStatus.mastered).length;
    });
    listeningAsync.whenData((list) {
      unlearnedCount += list.where((x) => x.status != StudyStatus.mastered).length;
      masteredCount += list.where((x) => x.status == StudyStatus.mastered).length;
    });
    final daysRemaining = _targetDate.difference(DateTime.now()).inDays;
    final totalItems = unlearnedCount + masteredCount;
    final progressPercentage = totalItems == 0 ? 0.0 : (masteredCount / totalItems);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Study Planner', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            children: [
              // 1. TOP PLANNER CARD
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Target Completion Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              DateFormat('MMM dd, yyyy').format(_targetDate),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$daysRemaining Days Left',
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMetricCol('Current Progress', '${(progressPercentage * 100).toStringAsFixed(0)}%'),
                        _buildMetricCol('Today\'s Goal', '${_availableHours.toStringAsFixed(1)} hrs'),
                        _buildMetricCol('Pending items', '$unlearnedCount'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 2. MINI CALENDAR MONTH GRID
              const SectionHeader(title: 'Calendar Schedule'),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMMM yyyy').format(DateTime.now()),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 28,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) {
                        final dayNum = index + 1;
                        final isToday = dayNum == DateTime.now().day;
                        final isSunday = index % 7 == 6; // mock sundays

                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isToday
                                ? Theme.of(context).colorScheme.primary
                                : (isSunday ? Colors.orange.withValues(alpha: 0.12) : Colors.grey.withValues(alpha: 0.08)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$dayNum',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isToday
                                  ? Colors.white
                                  : (isSunday ? Colors.orange : (isDark ? Colors.white70 : Colors.black87)),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. UPCOMING LESSONS
              const SectionHeader(title: 'Upcoming Assignments'),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    _buildLessonRow('Kanji Study Session', '10 items', 'Tomorrow'),
                    const Divider(height: 1),
                    _buildLessonRow('Vocabulary Drill', '15 words', 'July 2nd'),
                    const Divider(height: 1),
                    _buildLessonRow('Grammar Structure 4 & 5', '2 forms', 'July 3rd'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 4. MISSED LESSONS
              const SectionHeader(title: 'Missed Lessons backlog'),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: unlearnedCount > 10
                    ? Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.orange),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Text(
                              'You have 4 past lessons pending completion due to active load skips.',
                              style: TextStyle(fontSize: 13, height: 1.3),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Reschedule'),
                          ),
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline, color: Colors.green),
                            SizedBox(width: AppSpacing.md),
                            Text('All past lessons are caught up!'),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 5. AUTO REDISTRIBUTION STATUS
              const SectionHeader(title: 'Load Redistribution'),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.sync, color: Colors.white),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Auto redistribution Active', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: AppSpacing.xxs),
                          Text(
                            'Missed study tasks are auto-rescheduled to remaining days.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 6. PLAN CONFIGURE FORM (DatePicker and hours slider)
              const SectionHeader(title: 'Configure Study Bounds'),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    // Start Date Picker
                    _buildDatePickerRow(
                      context: context,
                      label: 'Start Date',
                      date: _startDate,
                      onSelected: (date) {
                        setState(() {
                          _startDate = date;
                          if (_targetDate.isBefore(_startDate)) {
                            _targetDate = _startDate.add(const Duration(days: 7));
                          }
                        });
                      },
                    ),
                    const Divider(height: 32),

                    // Target Date Picker
                    _buildDatePickerRow(
                      context: context,
                      label: 'Target Completion',
                      date: _targetDate,
                      onSelected: (date) {
                        if (date.isBefore(_startDate)) return;
                        setState(() {
                          _targetDate = date;
                        });
                      },
                    ),
                    const Divider(height: 32),

                    // Available Hours Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Available Study Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(
                          '${_availableHours.toStringAsFixed(1)} hr/day',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Slider(
                      value: _availableHours,
                      min: 0.5,
                      max: 6.0,
                      divisions: 11,
                      label: '${_availableHours.toStringAsFixed(1)} hrs',
                      onChanged: (val) {
                        setState(() {
                          _availableHours = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerRow({
    required BuildContext context,
    required String label,
    required DateTime date,
    required ValueChanged<DateTime> onSelected,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(
              DateFormat('EEE, MMM d, yyyy').format(date),
              style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 13),
            ),
          ],
        ),
        IconButton.filledTonal(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
            );
            if (picked != null) {
              onSelected(picked);
            }
          },
          icon: const Icon(Icons.calendar_month, size: 20),
        ),
      ],
    );
  }

  Widget _buildMetricCol(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF2196F3))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLessonRow(String title, String subtitle, String trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: AppSpacing.xxs),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Text(trailing, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}


