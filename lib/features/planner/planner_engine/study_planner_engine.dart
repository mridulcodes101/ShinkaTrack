import 'package:uuid/uuid.dart';
import 'package:shinka_track_n3/features/planner/domain/models/study_plan.dart';
import 'package:shinka_track_n3/features/planner/domain/models/planner_task.dart';

class StudyPlannerEngine {
  static const _uuid = Uuid();

  // Workload duration rules (in minutes)
  static int getDurationForType(String type) {
    switch (type) {
      case 'kanji':
        return 10;
      case 'vocab':
        return 5;
      case 'grammar':
        return 15;
      case 'reading':
        return 20;
      case 'listening':
        return 20;
      default:
        return 15;
    }
  }

  // Check if a date matches the user's selected study days (weekdays)
  static bool isStudyDay(DateTime date, List<String> studyDays) {
    final Map<int, String> weekdayNames = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
    final name = weekdayNames[date.weekday];
    return studyDays.contains(name);
  }

  // Generate initial list of tasks
  static List<PlannerTask> generatePlanTasks({
    required StudyPlan plan,
    required List<Map<String, String>> itemsToSchedule,
  }) {
    final List<PlannerTask> tasks = [];
    final DateTime start = DateTime(plan.startDate.year, plan.startDate.month, plan.startDate.day);
    final DateTime end = DateTime(plan.targetDate.year, plan.targetDate.month, plan.targetDate.day);

    // 1. Find all available study dates
    final List<DateTime> studyDates = [];
    DateTime temp = start;
    while (!temp.isAfter(end)) {
      if (isStudyDay(temp, plan.studyDays)) {
        studyDates.add(temp);
      }
      temp = temp.add(const Duration(days: 1));
    }

    if (studyDates.isEmpty) {
      // Fallback: use all days if none selected
      temp = start;
      while (!temp.isAfter(end)) {
        studyDates.add(temp);
        temp = temp.add(const Duration(days: 1));
      }
    }

    // 2. Distribute items evenly
    final int totalItems = itemsToSchedule.length;
    final int totalDays = studyDates.length;
    final int itemsPerDay = (totalItems / totalDays).ceil();

    int itemIndex = 0;
    for (int dayIndex = 0; dayIndex < totalDays; dayIndex++) {
      final date = studyDates[dayIndex];
      
      // Schedule reviews on Sundays
      if (date.weekday == DateTime.sunday) {
        tasks.add(PlannerTask(
          id: _uuid.v4(),
          date: date,
          itemType: 'review',
          itemId: 'weekly_review',
          isCompleted: false,
          isReview: true,
          duration: 30,
          priority: 1,
          completion: 0.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
      }

      // Schedule items
      for (int i = 0; i < itemsPerDay; i++) {
        if (itemIndex >= totalItems) break;
        final item = itemsToSchedule[itemIndex++];
        final type = item['type']!;
        final id = item['id']!;

        tasks.add(PlannerTask(
          id: _uuid.v4(),
          date: date,
          itemType: type,
          itemId: id,
          isCompleted: false,
          isReview: false,
          duration: getDurationForType(type),
          priority: 2,
          completion: 0.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
      }
    }

    return tasks;
  }

  // Missed days task redistribution
  static List<PlannerTask> redistributeMissedTasks({
    required List<PlannerTask> allTasks,
    required StudyPlan plan,
  }) {
    final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // 1. Separate completed tasks and uncompleted tasks
    final completed = allTasks.where((t) => t.isCompleted).toList();
    final uncompleted = allTasks.where((t) => !t.isCompleted).toList();

    if (uncompleted.isEmpty) return allTasks;

    // 2. Identify future study dates from today to target date
    final DateTime end = DateTime(plan.targetDate.year, plan.targetDate.month, plan.targetDate.day);
    final List<DateTime> futureStudyDates = [];
    DateTime temp = today;
    while (!temp.isAfter(end)) {
      if (isStudyDay(temp, plan.studyDays)) {
        futureStudyDates.add(temp);
      }
      temp = temp.add(const Duration(days: 1));
    }

    if (futureStudyDates.isEmpty) {
      futureStudyDates.add(today);
    }

    // 3. Redistribute uncompleted tasks evenly over future study dates
    final List<PlannerTask> redistributed = [];
    redistributed.addAll(completed);

    final int totalUncompleted = uncompleted.length;
    final int totalDays = futureStudyDates.length;
    final int tasksPerDay = (totalUncompleted / totalDays).ceil();

    int taskIndex = 0;
    for (int dayIndex = 0; dayIndex < totalDays; dayIndex++) {
      final date = futureStudyDates[dayIndex];
      for (int i = 0; i < tasksPerDay; i++) {
        if (taskIndex >= totalUncompleted) break;
        final t = uncompleted[taskIndex++];
        redistributed.add(t.copyWith(
          date: date,
          updatedAt: DateTime.now(),
        ));
      }
    }

    return redistributed;
  }

  // Calculate daily workload metrics (remaining tasks and durations)
  static Map<String, dynamic> calculateDailyWorkload(List<PlannerTask> tasksForDay) {
    int duration = 0;
    int reviews = 0;
    int completed = 0;
    for (var t in tasksForDay) {
      duration += t.duration;
      if (t.isReview) reviews++;
      if (t.isCompleted) completed++;
    }

    final double completionPercent = tasksForDay.isNotEmpty 
        ? (completed / tasksForDay.length) * 100 
        : 0.0;

    return {
      'durationMinutes': duration,
      'reviewCount': reviews,
      'completionPercent': completionPercent,
    };
  }
}
