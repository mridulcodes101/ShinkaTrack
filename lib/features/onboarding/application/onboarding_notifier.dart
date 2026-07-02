import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/core/services/admin_service.dart';

class OnboardingState {
  final String language;
  final String experience;
  final String currentJlpt;
  final String targetJlpt;
  final String? examDate; // yyyy-MM-dd
  final List<String> studyDays;
  final int dailyStudyTime;
  final List<String> preferredModules;
  final bool notificationsEnabled;

  const OnboardingState({
    this.language = 'English',
    this.experience = 'Complete Beginner',
    this.currentJlpt = 'None',
    this.targetJlpt = 'JLPT N3',
    this.examDate,
    this.studyDays = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    this.dailyStudyTime = 15,
    this.preferredModules = const ['Kanji', 'Vocabulary', 'Grammar'],
    this.notificationsEnabled = true,
  });

  OnboardingState copyWith({
    String? language,
    String? experience,
    String? currentJlpt,
    String? targetJlpt,
    String? examDate,
    List<String>? studyDays,
    int? dailyStudyTime,
    List<String>? preferredModules,
    bool? notificationsEnabled,
  }) {
    return OnboardingState(
      language: language ?? this.language,
      experience: experience ?? this.experience,
      currentJlpt: currentJlpt ?? this.currentJlpt,
      targetJlpt: targetJlpt ?? this.targetJlpt,
      examDate: examDate ?? this.examDate,
      studyDays: studyDays ?? this.studyDays,
      dailyStudyTime: dailyStudyTime ?? this.dailyStudyTime,
      preferredModules: preferredModules ?? this.preferredModules,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final SharedPreferences prefs;

  OnboardingNotifier(this.prefs) : super(const OnboardingState());

  void setLanguage(String lang) => state = state.copyWith(language: lang);
  void setExperience(String exp) => state = state.copyWith(experience: exp);
  void setCurrentJlpt(String jlpt) => state = state.copyWith(currentJlpt: jlpt);
  void setTargetJlpt(String goal) => state = state.copyWith(targetJlpt: goal);
  void setExamDate(String? date) => state = state.copyWith(examDate: date);
  void setStudyDays(List<String> days) => state = state.copyWith(studyDays: days);
  void setDailyStudyTime(int minutes) => state = state.copyWith(dailyStudyTime: minutes);
  void setPreferredModules(List<String> modules) => state = state.copyWith(preferredModules: modules);
  void setNotificationsEnabled(bool enabled) => state = state.copyWith(notificationsEnabled: enabled);

  // Commit Onboarding values and initialize planner
  Future<void> completeOnboarding() async {
    await prefs.setString('settings_general_language', state.language);
    await prefs.setString('settings_study_difficulty', state.experience == 'Complete Beginner' ? 'Easy' : 'Normal');
    await prefs.setInt('settings_study_goal_minutes', state.dailyStudyTime);
    await prefs.setStringList('settings_study_preferred_modules', state.preferredModules);
    await prefs.setStringList('settings_planner_study_days', state.studyDays);

    if (state.examDate != null) {
      await prefs.setString('settings_planner_exam_date', state.examDate!);
    }

    await prefs.setBool('onboarding_completed', true);
  }

  Future<void> resetOnboarding() async {
    await prefs.remove('onboarding_completed');
    state = const OnboardingState();
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return OnboardingNotifier(sharedPrefs);
});

final onboardingCompletedProvider = StateProvider<bool>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return sharedPrefs.getBool('onboarding_completed') ?? false;
});
