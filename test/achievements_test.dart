import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/achievement_model.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/progression_config.dart';
import 'package:shinka_track_n3/features/achievements/domain/repositories/achievements_repository.dart';
import 'package:shinka_track_n3/features/achievements/services/achievement_engine.dart';

class InMemoryAchievementsRepository implements AchievementsRepository {
  final Map<String, AchievementModel> achievements = {};
  int userXp = 0;

  @override
  Future<List<AchievementModel>> getAchievements() async {
    return achievements.values.toList();
  }

  @override
  Future<AchievementModel?> getAchievement(String id) async {
    return achievements[id];
  }

  @override
  Future<void> saveAchievement(AchievementModel achievement) async {
    achievements[achievement.id] = achievement;
  }

  @override
  Future<void> unlockAchievement(String id) async {
    final ach = achievements[id];
    if (ach != null) {
      achievements[id] = ach.copyWith(isUnlocked: true, unlockedAt: DateTime.now(), progress: ach.target);
    }
  }

  @override
  Future<void> updateProgress(String id, int progress) async {
    final ach = achievements[id];
    if (ach != null) {
      final reachedTarget = progress >= ach.target;
      achievements[id] = ach.copyWith(
        progress: progress.clamp(0, ach.target),
        isUnlocked: reachedTarget,
        unlockedAt: reachedTarget ? DateTime.now() : null,
      );
    }
  }

  @override
  Future<int> getUserXp() async {
    return userXp;
  }

  @override
  Future<void> addUserXp(int amount) async {
    userXp += amount;
  }

  @override
  Future<void> resetProgression() async {
    userXp = 0;
    achievements.updateAll((key, val) => val.copyWith(isUnlocked: false, progress: 0, unlockedAt: null));
  }
}

void main() {
  late InMemoryAchievementsRepository repository;
  late AchievementEngine engine;

  setUp(() {
    repository = InMemoryAchievementsRepository();
    engine = AchievementEngine(repository);
  });

  group('SPEC-016: Achievement & Progression System Tests', () {
    test('Configurable XP rewards are awarded and Level formula aggregates correctly', () async {
      await repository.addUserXp(100);
      final level100 = ProgressionConfig.calculateLevelFromXp(100);
      expect(level100, 2); // Level 2 requires exactly 100 XP

      await repository.addUserXp(150); // Total 250 XP
      final level250 = ProgressionConfig.calculateLevelFromXp(250);
      expect(level250, 3); // Level 3 requires exactly 250 XP
    });

    test('Seeding triggers and registers all achievements', () async {
      await engine.seedAchievements();
      final seeded = await repository.getAchievements();
      expect(seeded.isNotEmpty, isTrue);
      
      final firstKanji = seeded.firstWhere((a) => a.id == 'first_kanji');
      expect(firstKanji.title, 'First Kanji');
      expect(firstKanji.xpReward, 20);
    });

    test('Analytics events increments progress and unlocks achievements', () async {
      await engine.seedAchievements();

      // Process a lesson completed event for Kanji
      await engine.processEvent(AnalyticsEvent(
        id: 'ev1',
        eventType: 'LESSON_COMPLETED',
        contentType: 'kanji',
        timestamp: DateTime.now(),
      ));

      final ach = await repository.getAchievement('first_kanji');
      expect(ach, isNotNull);
      expect(ach!.isUnlocked, isTrue);
      expect(ach.progress, 1);
    });

    test('Confetti unlocks callback triggers listeners correctly', () async {
      await engine.seedAchievements();

      AchievementModel? unlocked;
      final sub = engine.onAchievementUnlocked.listen((item) {
        unlocked = item;
      });

      await engine.processEvent(AnalyticsEvent(
        id: 'ev1',
        eventType: 'LESSON_COMPLETED',
        contentType: 'kanji',
        timestamp: DateTime.now(),
      ));

      await Future.delayed(const Duration(milliseconds: 10));
      expect(unlocked, isNotNull);
      expect(unlocked!.id, 'first_kanji');
      sub.cancel();
    });
  });
}
