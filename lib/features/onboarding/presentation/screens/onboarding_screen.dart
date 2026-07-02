import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/onboarding/application/onboarding_notifier.dart';
import 'package:shinka_track_n3/core/services/notification_service.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentStep = 0; // 0 = Splash, 1 = Welcome, 2 = Lang, 3 = Exp, 4 = Target, 5 = Date, 6 = Days, 7 = Time, 8 = Modules, 9 = Notif, 10 = Generation, 11 = Success
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _runSplashTimer();
  }

  void _runSplashTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _currentStep = 1;
      });
    }
  }

  void _nextStep() {
    if (_currentStep == 9) {
      _runGenerationSimulation();
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _runGenerationSimulation() async {
    setState(() {
      _currentStep = 10;
      _isGenerating = true;
    });

    // Simulate planner engine calculations
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isGenerating = false;
        _currentStep = 11;
      });
    }
  }

  Future<void> _finishOnboarding() async {
    await ref.read(onboardingProvider.notifier).completeOnboarding();
    ref.read(onboardingCompletedProvider.notifier).state = true;
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildCurrentStepView(context, state),
        ),
      ),
    );
  }

  Widget _buildCurrentStepView(BuildContext context, OnboardingState state) {
    switch (_currentStep) {
      case 0:
        return _buildSplash();
      case 1:
        return _buildWelcome();
      case 2:
        return _buildLanguage(state);
      case 3:
        return _buildExperience(state);
      case 4:
        return _buildTargetGoal(state);
      case 5:
        return _buildExamDate(state);
      case 6:
        return _buildStudyDays(state);
      case 7:
        return _buildDailyStudyTime(state);
      case 8:
        return _buildModuleSelection(state);
      case 9:
        return _buildNotifications(state);
      case 10:
        return _buildPlanGeneration();
      case 11:
        return _buildSuccess(state);
      default:
        return _buildWelcome();
    }
  }

  // STEP 0: SPLASH SCREEN
  Widget _buildSplash() {
    return Center(
      key: const ValueKey('splash'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.15),
            child: const Icon(Icons.school, color: PremiumDesignSystem.primaryBlue, size: 40),
          ),
          const SizedBox(height: 16),
          const Text('ShinkaTrack N3', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Evolutionary Japanese Study Tracker', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 32),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  // STEP 1: WELCOME SCREEN
  Widget _buildWelcome() {
    return Padding(
      key: const ValueKey('welcome'),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(Icons.insights, size: 80, color: PremiumDesignSystem.primaryBlue),
          const SizedBox(height: 24),
          const Text(
            'Welcome to ShinkaTrack',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Master JLPT N3 with daily adaptive planning, spaced repetition cards, and smart progress analytics.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _nextStep,
              child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // STEP 2: LANGUAGE SCREEN
  Widget _buildLanguage(OnboardingState state) {
    return _buildStepWrapper(
      title: 'Choose Language',
      desc: 'Select preferred user interface display language.',
      child: Column(
        children: [
          _buildOptionTile(
            title: 'English',
            subtitle: 'English UI',
            isSelected: state.language == 'English',
            onTap: () => ref.read(onboardingProvider.notifier).setLanguage('English'),
          ),
          const SizedBox(height: 12),
          _buildOptionTile(
            title: '日本語',
            subtitle: 'Japanese UI',
            isSelected: state.language == 'Japanese',
            onTap: () => ref.read(onboardingProvider.notifier).setLanguage('Japanese'),
          ),
        ],
      ),
    );
  }

  // STEP 3: JAPANESE EXPERIENCE SCREEN
  Widget _buildExperience(OnboardingState state) {
    final options = ['Complete Beginner', 'Know Hiragana & Katakana', 'Studying for N5/N4', 'Intermediate Scholar'];
    return _buildStepWrapper(
      title: 'Japanese Experience',
      desc: 'Select options matching your current language level.',
      child: Column(
        children: options.map((opt) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildOptionTile(
              title: opt,
              subtitle: 'Tailor initial goals difficulty',
              isSelected: state.experience == opt,
              onTap: () => ref.read(onboardingProvider.notifier).setExperience(opt),
            ),
          );
        }).toList(),
      ),
    );
  }

  // STEP 4: TARGET GOAL SCREEN
  Widget _buildTargetGoal(OnboardingState state) {
    final goals = ['JLPT N5', 'JLPT N4', 'JLPT N3', 'JLPT N2', 'JLPT N1'];
    return _buildStepWrapper(
      title: 'Target Goal',
      desc: 'Choose your upcoming Japanese Language target goal.',
      child: Column(
        children: goals.map((goal) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildOptionTile(
              title: goal,
              subtitle: 'Focus planner content targets',
              isSelected: state.targetJlpt == goal,
              onTap: () => ref.read(onboardingProvider.notifier).setTargetJlpt(goal),
            ),
          );
        }).toList(),
      ),
    );
  }

  // STEP 5: EXAM DATE SCREEN
  Widget _buildExamDate(OnboardingState state) {
    return _buildStepWrapper(
      title: 'Exam Date',
      desc: 'Pick your scheduled exam date. Skip for open-ended study schedules.',
      child: Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.calendar_today),
            label: Text(
              state.examDate != null ? 'Exam Date: ${state.examDate}' : 'Select Date',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 90)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 730)),
              );
              if (picked != null) {
                final dateStr = DateFormat('yyyy-MM-dd').format(picked);
                ref.read(onboardingProvider.notifier).setExamDate(dateStr);
              }
            },
          ),
          if (state.examDate != null) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => ref.read(onboardingProvider.notifier).setExamDate(null),
              child: const Text('Clear date', style: TextStyle(color: Colors.red)),
            ),
          ]
        ],
      ),
    );
  }

  // STEP 6: STUDY DAYS SCREEN
  Widget _buildStudyDays(OnboardingState state) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return _buildStepWrapper(
      title: 'Study Days',
      desc: 'Select which days you want to study each week.',
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: days.map((day) {
              final isSelected = state.studyDays.contains(day);
              return ChoiceChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (selected) {
                  final list = List<String>.from(state.studyDays);
                  if (selected) {
                    list.add(day);
                  } else {
                    list.remove(day);
                  }
                  if (list.isNotEmpty) {
                    ref.read(onboardingProvider.notifier).setStudyDays(list);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // STEP 7: DAILY STUDY TIME SCREEN
  Widget _buildDailyStudyTime(OnboardingState state) {
    final times = [15, 30, 45, 60, 90, 120];
    return _buildStepWrapper(
      title: 'Daily Study Duration',
      desc: 'Select preferred daily duration target goal.',
      child: Column(
        children: times.map((t) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildOptionTile(
              title: '$t Minutes',
              subtitle: 'Daily Target Goal',
              isSelected: state.dailyStudyTime == t,
              onTap: () => ref.read(onboardingProvider.notifier).setDailyStudyTime(t),
            ),
          );
        }).toList(),
      ),
    );
  }

  // STEP 8: MODULE SELECTION SCREEN
  Widget _buildModuleSelection(OnboardingState state) {
    final modules = ['Kanji', 'Vocabulary', 'Grammar', 'Reading', 'Listening'];
    return _buildStepWrapper(
      title: 'Learning Modules',
      desc: 'Enable preferred modules. Customize study focus.',
      child: Column(
        children: modules.map((m) {
          final isSelected = state.preferredModules.contains(m);
          return CheckboxListTile(
            title: Text(m, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Enable study track records for $m.'),
            value: isSelected,
            onChanged: (val) {
              final list = List<String>.from(state.preferredModules);
              if (val == true) {
                list.add(m);
              } else {
                list.remove(m);
              }
              if (list.isNotEmpty) {
                ref.read(onboardingProvider.notifier).setPreferredModules(list);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  // STEP 9: NOTIFICATIONS SCREEN
  Widget _buildNotifications(OnboardingState state) {
    return _buildStepWrapper(
      title: 'Notifications Permission',
      desc: 'Get smart study reminders and achievements alerts.',
      child: Column(
        children: [
          const Icon(Icons.notifications_active, size: 64, color: PremiumDesignSystem.primaryBlue),
          const SizedBox(height: 24),
          const Text(
            'We recommend enabling notifications to help you stay consistent and never lose streaks.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Notifications Enable'),
            value: state.notificationsEnabled,
            onChanged: (val) {
              ref.read(onboardingProvider.notifier).setNotificationsEnabled(val);
            },
          ),
        ],
      ),
    );
  }

  // STEP 10: PLAN GENERATION SCREEN
  Widget _buildPlanGeneration() {
    return Center(
      key: const ValueKey('generation'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: PremiumDesignSystem.primaryBlue),
          const SizedBox(height: 24),
          const Text('Generating Personalized Study Plan...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text('Seeding targets, review times, and smart calendars...', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }

  // STEP 11: SUCCESS SCREEN
  Widget _buildSuccess(OnboardingState state) {
    return Padding(
      key: const ValueKey('success'),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          const Text('You are ready!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
            'Your personalized Japanese study plan has been calculated and initialized. Let\'s begin!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSummaryRow('Target Goal', state.targetJlpt),
                  _buildSummaryRow('Study Duration', '${state.dailyStudyTime} min/day'),
                  _buildSummaryRow('Study Days', '${state.studyDays.length} days/week'),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _finishOnboarding,
              child: const Text('Go to Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  // Shared builders
  Widget _buildStepWrapper({
    required String title,
    required String desc,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          const SizedBox(height: 24),
          Expanded(child: SingleChildScrollView(child: child)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _prevStep,
                child: const Text('BACK'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PremiumDesignSystem.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _nextStep,
                child: const Text('NEXT'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? const BorderSide(color: PremiumDesignSystem.primaryBlue, width: 2)
            : BorderSide.none,
      ),
      color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        trailing: isSelected ? const Icon(Icons.check_circle, color: PremiumDesignSystem.primaryBlue) : null,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
