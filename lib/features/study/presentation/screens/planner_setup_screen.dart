import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
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
  Widget build(BuildContext context) {
    final planAsync = ref.watch(activePlanProvider);
    final kanjiAsync = ref.watch(kanjiListProvider);
    final vocabAsync = ref.watch(vocabListProvider);
    final grammarAsync = ref.watch(grammarListProvider);
    final readingAsync = ref.watch(readingListProvider);
    final listeningAsync = ref.watch(listeningListProvider);

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Pre-populate if plan exists
    planAsync.whenData((plan) {
      if (plan != null && !_initialized) {
        _startDate = plan.startDate;
        _targetDate = plan.targetDate;
        _availableHours = plan.availableHours;
        _initialized = true;
      }
    });

    // Calculate workload estimates
    int unlearnedCount = 0;
    double totalEstHours = 0.0;

    kanjiAsync.whenData((list) {
      final count = list.where((x) => x.status != StudyStatus.mastered).length;
      unlearnedCount += count;
      totalEstHours += count * 5 / 60.0;
    });
    vocabAsync.whenData((list) {
      final count = list.where((x) => x.status != StudyStatus.mastered).length;
      unlearnedCount += count;
      totalEstHours += count * 3 / 60.0;
    });
    grammarAsync.whenData((list) {
      final count = list.where((x) => x.status != StudyStatus.mastered).length;
      unlearnedCount += count;
      totalEstHours += count * 10 / 60.0;
    });
    readingAsync.whenData((list) {
      final count = list.where((x) => x.status != StudyStatus.mastered).length;
      unlearnedCount += count;
      totalEstHours += count * 15 / 60.0;
    });
    listeningAsync.whenData((list) {
      final count = list.where((x) => x.status != StudyStatus.mastered).length;
      unlearnedCount += count;
      totalEstHours += count * 15 / 60.0;
    });
    // Calculate non-Sunday study days
    int studyDays = 0;
    DateTime temp = _startDate;
    while (!temp.isAfter(_targetDate)) {
      if (temp.weekday != DateTime.sunday) {
        studyDays++;
      }
      temp = temp.add(const Duration(days: 1));
    }

    final double totalCapHours = studyDays * _availableHours;
    final bool isOverloaded = totalEstHours > totalCapHours;
    final double requiredHoursPerDay = studyDays <= 0 ? 0.0 : totalEstHours / studyDays;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Smart Study Planner', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configure Your Plan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              const SizedBox(height: 6),
              Text(
                'Shinka automatically schedules checkable daily tasks. Sundays are review days.',
                style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 13),
              ),
              const SizedBox(height: 24),

              // Setup Card
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: const TextStyle(fontWeight: FontWeight.bold, color: PremiumDesignSystem.primaryBlue),
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
              const SizedBox(height: 24),

              // Workload stats panel
              const Text(
                'Workload Calculation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GlassCard(
                child: Column(
                  children: [
                    _buildStatRow('Study Days Available', '$studyDays days (excluding Sundays)'),
                    const SizedBox(height: 12),
                    _buildStatRow('Unmastered Lessons', '$unlearnedCount items'),
                    const SizedBox(height: 12),
                    _buildStatRow('Total Estimated Hours', '${totalEstHours.toStringAsFixed(1)} hours'),
                    const SizedBox(height: 12),
                    _buildStatRow('Required Rate', '${requiredHoursPerDay.toStringAsFixed(1)} hours/day'),
                    const Divider(height: 24),
                    // Warning panel
                    if (isOverloaded)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '⚠️ Workload exceeds target available hours! You need at least ${requiredHoursPerDay.toStringAsFixed(1)} hours per day. Shinka will schedule high daily loads. We recommend extending your Target Date.',
                                style: const TextStyle(fontSize: 11.5, color: Colors.orange, height: 1.3),
                              ),
                            )
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: PremiumDesignSystem.forestEmerald.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: PremiumDesignSystem.forestEmerald.withValues(alpha: 0.2)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_circle_outline, color: PremiumDesignSystem.forestEmerald),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Your study schedule is fully balanced and fits your available daily hours! Sundays are empty for weekly reviews.',
                                style: TextStyle(fontSize: 11.5, color: PremiumDesignSystem.forestEmerald, height: 1.3),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Action button
              ElevatedButton(
                onPressed: () async {
                  if (studyDays <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Target date must be after start date!')),
                    );
                    return;
                  }

                  await ref.read(activePlanProvider.notifier).createPlan(
                    startDate: _startDate,
                    targetDate: _targetDate,
                    availableHours: _availableHours,
                  );

                  if (context.mounted) {
                    context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  planAsync.value != null ? 'Update Study Plan' : 'Generate Study Plan',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
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

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13.5, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
