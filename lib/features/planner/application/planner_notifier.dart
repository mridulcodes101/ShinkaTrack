import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/planner/domain/models/study_plan.dart';
import 'package:shinka_track_n3/features/planner/domain/models/planner_task.dart';
import 'package:shinka_track_n3/features/planner/domain/repositories/planner_repository.dart';
import 'package:shinka_track_n3/features/planner/data/repositories/planner_repository_impl.dart';
import 'package:shinka_track_n3/features/planner/planner_engine/study_planner_engine.dart';

final plannerRepositoryProvider = Provider<PlannerRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return PlannerRepositoryImpl(db);
});

// Selected Date Provider for Calendar views
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// Wizard Setup State Providers
final wizardGoalProvider = StateProvider<String>((ref) => 'JLPT N3');
final wizardTargetDateProvider = StateProvider<DateTime>((ref) => DateTime.now().add(const Duration(days: 90)));
final wizardStudyDaysProvider = StateProvider<List<String>>((ref) => [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
]);
final wizardAvailableTimeProvider = StateProvider<double>((ref) => 60.0); // minutes
final wizardResourcesProvider = StateProvider<List<String>>((ref) => [
  'kanji', 'vocab', 'grammar', 'reading', 'listening'
]);

// Active Plan State Class
class PlannerState {
  final StudyPlan? activePlan;
  final bool isLoading;
  final String? error;

  const PlannerState({
    this.activePlan,
    this.isLoading = false,
    this.error,
  });

  PlannerState copyWith({
    StudyPlan? activePlan,
    bool? isLoading,
    String? error,
  }) {
    return PlannerState(
      activePlan: activePlan ?? this.activePlan,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Active Plan Notifier
class PlannerNotifier extends StateNotifier<PlannerState> {
  final PlannerRepository _repository;
  final Ref _ref;

  PlannerNotifier(this._repository, this._ref) : super(const PlannerState()) {
    loadActivePlan();
  }

  Future<void> loadActivePlan() async {
    state = state.copyWith(isLoading: true);
    try {
      final plan = await _repository.getActivePlan();
      state = state.copyWith(activePlan: plan, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> generateNewPlan({
    required String goal,
    required DateTime targetDate,
    required double availableMinutes,
    required List<String> studyDays,
    required List<String> resources,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final planId = const Uuid().v4();
      final plan = StudyPlan(
        id: planId,
        startDate: DateTime.now(),
        targetDate: targetDate,
        availableHours: availableMinutes,
        isActive: true,
        goal: goal,
        studyDays: studyDays,
        resources: resources,
      );

      // Fetch unlearned items
      final items = await _repository.getUnlearnedItems(resources);

      // Generate task lists
      final tasks = StudyPlannerEngine.generatePlanTasks(plan: plan, itemsToSchedule: items);

      // Save to database
      await _repository.saveActivePlan(plan);
      await _repository.deleteUncompletedTasks();
      await _repository.savePlannerTasks(tasks);

      state = state.copyWith(activePlan: plan, isLoading: false);
      _ref.invalidate(dailyTasksProvider);
      
      // Also invalidate existing planner providers to refresh study screen if needed
      _ref.invalidate(kanjiListProvider);
      _ref.invalidate(vocabListProvider);
      _ref.invalidate(grammarListProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> toggleTask(String taskId, bool isCompleted) async {
    await _repository.toggleTaskCompletion(taskId, isCompleted);
    _ref.invalidate(dailyTasksProvider);
  }

  // Skip Day action: redistributes all remaining tasks and recalculates schedule
  Future<void> skipDay() async {
    final plan = state.activePlan;
    if (plan == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final allTasks = await _repository.getAllScheduledTasks();
      
      // Redistribute uncompleted items using engine
      final redistributed = StudyPlannerEngine.redistributeMissedTasks(
        allTasks: allTasks,
        plan: plan,
      );

      // Save updated tasks
      await _repository.deleteUncompletedTasks();
      await _repository.savePlannerTasks(redistributed);

      state = state.copyWith(isLoading: false);
      _ref.invalidate(dailyTasksProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Reschedule trigger
  Future<void> recalculatePlan() async {
    final plan = state.activePlan;
    if (plan == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final allTasks = await _repository.getAllScheduledTasks();
      final redistributed = StudyPlannerEngine.redistributeMissedTasks(
        allTasks: allTasks,
        plan: plan,
      );

      await _repository.deleteUncompletedTasks();
      await _repository.savePlannerTasks(redistributed);

      state = state.copyWith(isLoading: false);
      _ref.invalidate(dailyTasksProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final plannerNotifierProvider = StateNotifierProvider.autoDispose<PlannerNotifier, PlannerState>((ref) {
  final repo = ref.watch(plannerRepositoryProvider);
  return PlannerNotifier(repo, ref);
});

// Daily Tasks Provider
final dailyTasksProvider = FutureProvider.autoDispose<List<PlannerTask>>((ref) async {
  final repo = ref.watch(plannerRepositoryProvider);
  final date = ref.watch(selectedDateProvider);
  return repo.getTasksForDate(date);
});

// Overall Progress Statistics Provider
final plannerProgressStatsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repo = ref.watch(plannerRepositoryProvider);
  final allTasks = await repo.getAllScheduledTasks();
  final plan = ref.watch(plannerNotifierProvider).activePlan;

  final total = allTasks.length;
  final completed = allTasks.where((t) => t.isCompleted).length;
  final double accuracy = total > 0 ? (completed / total) * 100 : 0.0;

  int remainingDays = 0;
  if (plan != null) {
    remainingDays = plan.targetDate.difference(DateTime.now()).inDays.clamp(0, 10000);
  }

  return {
    'totalTasks': total,
    'completedTasks': completed,
    'completionPercent': accuracy,
    'remainingDays': remainingDays,
  };
});
