import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/planner/application/planner_notifier.dart';

class PlannerSetupWizardScreen extends ConsumerStatefulWidget {
  const PlannerSetupWizardScreen({super.key});

  @override
  ConsumerState<PlannerSetupWizardScreen> createState() => _PlannerSetupWizardScreenState();
}

class _PlannerSetupWizardScreenState extends ConsumerState<PlannerSetupWizardScreen> {
  int _currentStep = 0;

  final List<String> _goals = ['JLPT N5', 'JLPT N4', 'JLPT N3', 'JLPT N2', 'JLPT N1', 'Custom Goal'];
  final List<String> _allWeekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  final List<Map<String, dynamic>> _durations = [
    {'label': '15 Minutes', 'val': 15.0},
    {'label': '30 Minutes', 'val': 30.0},
    {'label': '45 Minutes', 'val': 45.0},
    {'label': '60 Minutes', 'val': 60.0},
    {'label': '90 Minutes', 'val': 90.0},
    {'label': '120 Minutes', 'val': 120.0},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Plan Setup Wizard', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Column(
        children: [
          // Top horizontal step indicators
          _buildStepIndicators(),
          const SizedBox(height: 16),

          // Main Step Card viewport
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: _buildCurrentStepContent(context),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicators() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) {
          final isCurrent = index == _currentStep;
          final isCompleted = index < _currentStep;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isCurrent ? 24 : 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isCurrent 
                  ? PremiumDesignSystem.primaryBlue 
                  : (isCompleted ? Colors.teal : Colors.grey.withValues(alpha: 0.3)),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return _buildGoalStep();
      case 1:
        return _buildDateStep(context);
      case 2:
        return _buildDaysStep();
      case 3:
        return _buildDurationStep();
      case 4:
        return _buildResourcesStep();
      case 5:
        return _buildConfirmationStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildGoalStep() {
    final selectedGoal = ref.watch(wizardGoalProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Your Target Goal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Choose the JLPT certification rank or target level you wish to study for.', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 20),
        Column(
          children: _goals.map((g) {
            final isSel = g == selectedGoal;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              height: 52, // minimum touch targets 48dp+
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isSel ? PremiumDesignSystem.primaryBlue : Colors.grey.withValues(alpha: 0.3), width: isSel ? 2 : 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: isSel ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.08) : Colors.transparent,
                  foregroundColor: isSel ? PremiumDesignSystem.primaryBlue : Colors.grey,
                ),
                onPressed: () => ref.read(wizardGoalProvider.notifier).state = g,
                child: Text(g, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateStep(BuildContext context) {
    final targetDate = ref.watch(wizardTargetDateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Target Exam Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Specify the date when you intend to sit for the examination or finish the plan.', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 32),
        Center(
          child: Column(
            children: [
              const Icon(Icons.calendar_today_rounded, size: 64, color: PremiumDesignSystem.primaryBlue),
              const SizedBox(height: 20),
              Text(
                DateFormat('EEEE, MMMM d, yyyy').format(targetDate),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PremiumDesignSystem.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.edit_calendar_rounded),
                  label: const Text('Pick Date'),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: targetDate,
                      firstDate: DateTime.now().add(const Duration(days: 7)),
                      lastDate: DateTime.now().add(const Duration(days: 3650)), // support 10 year plans
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: isDark 
                              ? const ColorScheme.dark(primary: PremiumDesignSystem.primaryBlue) 
                              : const ColorScheme.light(primary: PremiumDesignSystem.primaryBlue),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) {
                      ref.read(wizardTargetDateProvider.notifier).state = picked;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDaysStep() {
    final studyDays = ref.watch(wizardStudyDaysProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Study Days', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Select which days of the week you plan to allocate study time.', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 20),
        Column(
          children: _allWeekdays.map((day) {
            final isSel = studyDays.contains(day);
            return CheckboxListTile(
              activeColor: PremiumDesignSystem.primaryBlue,
              title: Text(day, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              value: isSel,
              onChanged: (val) {
                final current = List<String>.from(studyDays);
                if (val == true) {
                  if (!current.contains(day)) current.add(day);
                } else {
                  current.remove(day);
                }
                ref.read(wizardStudyDaysProvider.notifier).state = current;
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDurationStep() {
    final activeMinutes = ref.watch(wizardAvailableTimeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daily Available Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('How many minutes can you commit each study day?', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 24),
        Column(
          children: _durations.map((d) {
            final isSel = (d['val'] as double) == activeMinutes;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isSel ? PremiumDesignSystem.primaryBlue : Colors.grey.withValues(alpha: 0.3), width: isSel ? 2 : 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: isSel ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.08) : Colors.transparent,
                  foregroundColor: isSel ? PremiumDesignSystem.primaryBlue : Colors.grey,
                ),
                onPressed: () => ref.read(wizardAvailableTimeProvider.notifier).state = d['val'],
                child: Text(d['label'], style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResourcesStep() {
    final selectedModules = ref.watch(wizardResourcesProvider);
    final modules = ['kanji', 'vocab', 'grammar', 'reading', 'listening'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selected Modules', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Include target learning resources in your study queue.', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 20),
        Column(
          children: modules.map((m) {
            final isSel = selectedModules.contains(m);
            return CheckboxListTile(
              activeColor: PremiumDesignSystem.primaryBlue,
              title: Text(m.toUpperCase(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              value: isSel,
              onChanged: (val) {
                final current = List<String>.from(selectedModules);
                if (val == true) {
                  if (!current.contains(m)) current.add(m);
                } else {
                  current.remove(m);
                }
                ref.read(wizardResourcesProvider.notifier).state = current;
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmationStep() {
    final goal = ref.watch(wizardGoalProvider);
    final date = ref.watch(wizardTargetDateProvider);
    final minutes = ref.watch(wizardAvailableTimeProvider);
    final days = ref.watch(wizardStudyDaysProvider);
    final resources = ref.watch(wizardResourcesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Confirm Your Study Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Review your settings before generating the personalized schedule.', style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 24),
        _buildInfoRow('Goal Target', goal),
        const Divider(),
        _buildInfoRow('Exam Date', DateFormat('MMMM d, yyyy').format(date)),
        const Divider(),
        _buildInfoRow('Daily Target', '${minutes.toInt()} Minutes'),
        const Divider(),
        _buildInfoRow('Weekly Commit', '${days.length} Study Days'),
        const Divider(),
        _buildInfoRow('Modules Included', resources.join(', ').toUpperCase()),
      ],
    );
  }

  Widget _buildInfoRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            SizedBox(
              height: 48,
              width: 120,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => setState(() => _currentStep--),
                child: const Text('Back', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          else
            const SizedBox(width: 120),

          SizedBox(
            height: 48,
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                if (_currentStep < 5) {
                  setState(() => _currentStep++);
                } else {
                  // Submit generation
                  final notifier = ref.read(plannerNotifierProvider.notifier);
                  await notifier.generateNewPlan(
                    goal: ref.read(wizardGoalProvider),
                    targetDate: ref.read(wizardTargetDateProvider),
                    availableMinutes: ref.read(wizardAvailableTimeProvider),
                    studyDays: ref.read(wizardStudyDaysProvider),
                    resources: ref.read(wizardResourcesProvider),
                  );
                  if (mounted) {
                    context.pop(); // return to dashboard
                  }
                }
              },
              child: Text(
                _currentStep == 5 ? 'Generate Plan' : 'Continue',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
