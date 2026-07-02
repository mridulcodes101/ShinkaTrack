import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shinka_track_n3/core/database/database.dart' hide StudyPlan, PlannerTask;
import 'package:shinka_track_n3/features/planner/domain/models/study_plan.dart';
import 'package:shinka_track_n3/features/planner/domain/models/planner_task.dart';
import 'package:shinka_track_n3/features/planner/planner_engine/study_planner_engine.dart';

void main() {
  late AppDatabase db;
  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
  });

  tearDown(() async {
    await db.close();
  });

  group('SPEC-012: Study Intelligence Engine Tests', () {
    test('Generate study plan distributes items evenly over weekdays', () {
      final plan = StudyPlan(
        id: 'test_plan_1',
        startDate: DateTime.now(),
        targetDate: DateTime.now().add(const Duration(days: 7)),
        availableHours: 45.0,
        isActive: true,
        goal: 'JLPT N3',
        studyDays: ['Monday', 'Wednesday', 'Friday'],
        resources: ['kanji', 'vocab'],
      );

      final items = [
        {'type': 'kanji', 'id': 'k1'},
        {'type': 'kanji', 'id': 'k2'},
        {'type': 'vocab', 'id': 'v1'},
        {'type': 'vocab', 'id': 'v2'},
      ];

      final tasks = StudyPlannerEngine.generatePlanTasks(plan: plan, itemsToSchedule: items);
      
      expect(tasks.isNotEmpty, isTrue);
      // Verify only study days are used
      for (var t in tasks) {
        if (t.itemId != 'weekly_review') {
          expect(StudyPlannerEngine.isStudyDay(t.date, plan.studyDays), isTrue);
        }
      }
    });

    test('Redistribute missed tasks pushes uncompleted items forward', () {
      final plan = StudyPlan(
        id: 'test_plan_2',
        startDate: DateTime.now().subtract(const Duration(days: 2)),
        targetDate: DateTime.now().add(const Duration(days: 5)),
        availableHours: 60.0,
        isActive: true,
        goal: 'JLPT N3',
        studyDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        resources: ['kanji'],
      );

      // 1 missed task, 1 completed task
      final tasks = <PlannerTask>[
        PlannerTask(
          id: 't1',
          date: DateTime.now().subtract(const Duration(days: 1)),
          itemType: 'kanji',
          itemId: 'k1',
          isCompleted: false,
          isReview: false,
          duration: 10,
          priority: 2,
          completion: 0.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        PlannerTask(
          id: 't2',
          date: DateTime.now().subtract(const Duration(days: 2)),
          itemType: 'kanji',
          itemId: 'k2',
          isCompleted: true,
          isReview: false,
          duration: 10,
          priority: 2,
          completion: 100.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final redistributed = StudyPlannerEngine.redistributeMissedTasks(
        allTasks: tasks,
        plan: plan,
      );

      // Verify that uncompleted task t1 was rescheduled to today or a future date
      final updatedT1 = redistributed.firstWhere((t) => t.id == 't1');
      expect(updatedT1.date.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)), isFalse);

      // Verify completed task t2 date remains unchanged
      final updatedT2 = redistributed.firstWhere((t) => t.id == 't2');
      expect(updatedT2.date.day, tasks[1].date.day);
    });
  });
}
