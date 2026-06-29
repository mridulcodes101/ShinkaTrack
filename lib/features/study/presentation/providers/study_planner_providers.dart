import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_planner_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:uuid/uuid.dart';

// --- ACTIVE PLAN STATE NOTIFIER ---

class ActivePlanNotifier extends StateNotifier<AsyncValue<StudyPlanEntity?>> {
  final Ref _ref;

  ActivePlanNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadActivePlan();
  }

  Future<void> loadActivePlan() async {
    try {
      final repo = _ref.read(repositoryProvider);
      
      // Auto-redistribute any missed tasks from past dates before loading
      await repo.checkAndRedistributeMissedTasks();
      
      final plan = await repo.getActiveStudyPlan();
      state = AsyncValue.data(plan);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createPlan({
    required DateTime startDate,
    required DateTime targetDate,
    required double availableHours,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(repositoryProvider);
      final newPlan = StudyPlanEntity(
        id: const Uuid().v4(),
        startDate: startDate,
        targetDate: targetDate,
        availableHours: availableHours,
      );
      
      await repo.createStudyPlan(newPlan);
      state = AsyncValue.data(newPlan);

      // Invalidate related providers to redraw screens reactively
      _ref.invalidate(kanjiListProvider);
      _ref.invalidate(vocabListProvider);
      _ref.invalidate(grammarListProvider);
      _ref.invalidate(readingListProvider);
      _ref.invalidate(listeningListProvider);
      _ref.invalidate(streakProvider);
      _ref.invalidate(dailyGoalProvider);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final activePlanProvider = StateNotifierProvider<ActivePlanNotifier, AsyncValue<StudyPlanEntity?>>((ref) {
  return ActivePlanNotifier(ref);
});

// --- DAILY TASKS FAMILY STATE NOTIFIER ---

class DailyTasksNotifier extends StateNotifier<AsyncValue<List<PlannerTaskEntity>>> {
  final Ref _ref;
  final DateTime _date;

  DailyTasksNotifier(this._ref, this._date) : super(const AsyncValue.loading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final repo = _ref.read(repositoryProvider);
      final tasks = await repo.getTasksForDate(_date);
      state = AsyncValue.data(tasks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleTask(String taskId, bool isCompleted) async {
    state.whenData((tasks) {
      state = AsyncValue.data(
        tasks.map((t) => t.id == taskId ? t.copyWith(isCompleted: isCompleted) : t).toList(),
      );
    });

    try {
      final repo = _ref.read(repositoryProvider);
      await repo.toggleTaskCompletion(taskId, isCompleted);
      
      // Update daily goal completed item count
      if (isCompleted) {
        await _ref.read(dailyGoalProvider.notifier).addProgress(items: 1);
      } else {
        await _ref.read(dailyGoalProvider.notifier).addProgress(items: -1);
      }

      // Reload related catalogs
      _ref.invalidate(kanjiListProvider);
      _ref.invalidate(vocabListProvider);
      _ref.invalidate(grammarListProvider);
      _ref.invalidate(readingListProvider);
      _ref.invalidate(listeningListProvider);
      _ref.invalidate(streakProvider);
      
      // Reload self
      await loadTasks();
    } catch (e) {
      // Reload on failure to sync
      await loadTasks();
    }
  }
}

final dailyTasksProvider = StateNotifierProvider.family<DailyTasksNotifier, AsyncValue<List<PlannerTaskEntity>>, DateTime>((ref, date) {
  return DailyTasksNotifier(ref, date);
});
