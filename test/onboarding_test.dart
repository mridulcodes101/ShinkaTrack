import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/features/onboarding/application/onboarding_notifier.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SPEC-019: First Launch Experience & Onboarding Tests', () {
    test('Onboarding values update state correctly', () async {
      final prefs = await SharedPreferences.getInstance();
      final notifier = OnboardingNotifier(prefs);

      notifier.setLanguage('Japanese');
      expect(notifier.state.language, 'Japanese');

      notifier.setDailyStudyTime(45);
      expect(notifier.state.dailyStudyTime, 45);

      notifier.setTargetJlpt('JLPT N2');
      expect(notifier.state.targetJlpt, 'JLPT N2');
    });

    test('Onboarding commits values correctly to settings', () async {
      final prefs = await SharedPreferences.getInstance();
      final notifier = OnboardingNotifier(prefs);

      notifier.setLanguage('Japanese');
      notifier.setDailyStudyTime(30);
      notifier.setPreferredModules(['Kanji', 'Grammar']);

      await notifier.completeOnboarding();

      expect(prefs.getString('settings_general_language'), 'Japanese');
      expect(prefs.getInt('settings_study_goal_minutes'), 30);
      expect(prefs.getStringList('settings_study_preferred_modules'), ['Kanji', 'Grammar']);
      expect(prefs.getBool('onboarding_completed'), isTrue);
    });

    test('Reset onboarding resets first launch detection', () async {
      final prefs = await SharedPreferences.getInstance();
      final notifier = OnboardingNotifier(prefs);

      await notifier.completeOnboarding();
      expect(prefs.getBool('onboarding_completed'), isTrue);

      await notifier.resetOnboarding();
      expect(prefs.getBool('onboarding_completed'), isNull);
    });
  });
}
