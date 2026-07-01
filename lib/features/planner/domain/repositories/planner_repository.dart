import 'package:shinka_track_n3/features/planner/domain/models/study_plan.dart';
import 'package:shinka_track_n3/features/planner/domain/models/planner_task.dart';

abstract class PlannerRepository {
  Future<StudyPlan?> getActivePlan();
  Future<void> saveActivePlan(StudyPlan plan);
  Future<void> deleteActivePlan();

  Future<List<PlannerTask>> getTasksForDate(DateTime date);
  Future<List<PlannerTask>> getAllScheduledTasks();
  Future<void> savePlannerTasks(List<PlannerTask> tasks);
  Future<void> deleteUncompletedTasks();
  Future<void> toggleTaskCompletion(String taskId, bool isCompleted);

  Future<List<Map<String, String>>> getUnlearnedItems(List<String> types);
}
