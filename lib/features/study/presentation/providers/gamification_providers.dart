import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/domain/entities/gamification_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

// --- CONFETTI TRIGGER PROVIDER ---

final confettiTriggerProvider = StateProvider<int>((ref) => 0);

// --- USER STATS NOTIFIER & PROVIDER ---

class UserStatsNotifier extends StateNotifier<AsyncValue<UserStatsEntity>> {
  final Ref ref;

  UserStatsNotifier(this.ref) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(repositoryProvider);
      final stats = await repo.getUserStats();
      state = AsyncValue.data(stats);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addXpAndCoins(int xp, int coins) async {
    try {
      final repo = ref.read(repositoryProvider);
      await repo.addXpAndCoins(xp, coins);

      // Reload stats and achievements
      await load();
      ref.read(achievementsProvider.notifier).load();
    } catch (e) {
      // Silently catch or handle
    }
  }
}

final userStatsProvider = StateNotifierProvider<UserStatsNotifier, AsyncValue<UserStatsEntity>>((ref) {
  return UserStatsNotifier(ref);
});

// --- ACHIEVEMENTS NOTIFIER & PROVIDER ---

class AchievementsNotifier extends StateNotifier<AsyncValue<List<AchievementEntity>>> {
  final Ref ref;

  AchievementsNotifier(this.ref) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(repositoryProvider);
      final list = await repo.getAchievements();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> checkAndUnlock() async {
    try {
      final repo = ref.read(repositoryProvider);
      await repo.checkAndUnlockAchievements();
      await load();
      ref.read(userStatsProvider.notifier).load();
    } catch (e) {
      debugPrint('Error checking or unlocking achievements: $e');
    }
  }
}

final achievementsProvider = StateNotifierProvider<AchievementsNotifier, AsyncValue<List<AchievementEntity>>>((ref) {
  return AchievementsNotifier(ref);
});

// --- WEEKLY GOAL NOTIFIER & PROVIDER ---

class WeeklyGoalNotifier extends StateNotifier<AsyncValue<WeeklyGoalEntity>> {
  final Ref ref;

  WeeklyGoalNotifier(this.ref) : super(const AsyncValue.loading()) {
    load();
  }

  String _getCurrentWeekId() {
    final today = DateTime.now();
    final firstDayOfYear = DateTime(today.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - 1;
    final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));
    final daysSinceFirstMonday = today.difference(firstMonday).inDays;
    final weekNumber = (daysSinceFirstMonday / 7).floor() + 1;
    return '${today.year}-W${weekNumber.toString().padLeft(2, '0')}';
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(repositoryProvider);
      final weekId = _getCurrentWeekId();
      final goal = await repo.getOrCreateWeeklyGoal(weekId);
      state = AsyncValue.data(goal);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProgress({int? addSeconds, int? addItems}) async {
    try {
      final repo = ref.read(repositoryProvider);
      final weekId = _getCurrentWeekId();
      await repo.updateWeeklyGoalProgress(weekId, addSeconds: addSeconds, addItems: addItems);
      await load();
      ref.read(userStatsProvider.notifier).load();
    } catch (e) {
      debugPrint('Error updating weekly goal progress: $e');
    }
  }
}

final weeklyGoalProvider = StateNotifierProvider<WeeklyGoalNotifier, AsyncValue<WeeklyGoalEntity>>((ref) {
  return WeeklyGoalNotifier(ref);
});
