import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/planner/domain/models/study_plan.dart' as domain;
import 'package:shinka_track_n3/features/planner/domain/models/planner_task.dart' as domain;
import 'package:shinka_track_n3/features/planner/domain/repositories/planner_repository.dart';

class PlannerRepositoryImpl implements PlannerRepository {
  final AppDatabase db;

  PlannerRepositoryImpl(this.db);

  List<String> _parseJsonList(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is List) {
        return decoded.cast<String>();
      }
    } catch (_) {}
    return [];
  }

  domain.StudyPlan _mapDriftPlanToDomain(StudyPlan p) {
    return domain.StudyPlan(
      id: p.id,
      startDate: p.startDate,
      targetDate: p.targetDate,
      availableHours: p.availableHours,
      isActive: p.isActive,
      goal: p.goal ?? 'JLPT N3',
      studyDays: _parseJsonList(p.studyDays),
      resources: _parseJsonList(p.resources),
    );
  }

  domain.PlannerTask _mapDriftTaskToDomain(PlannerTask t) {
    return domain.PlannerTask(
      id: t.id,
      date: t.date,
      itemType: t.itemType,
      itemId: t.itemId,
      isCompleted: t.isCompleted,
      isReview: t.isReview,
      duration: t.duration ?? 15,
      priority: t.priority ?? 2,
      completion: t.completion ?? 0.0,
      createdAt: t.createdAt ?? DateTime.now(),
      updatedAt: t.updatedAt ?? DateTime.now(),
    );
  }

  @override
  Future<domain.StudyPlan?> getActivePlan() async {
    final row = await (db.select(db.studyPlans)..where((t) => t.isActive.equals(true))).getSingleOrNull();
    if (row == null) return null;
    return _mapDriftPlanToDomain(row);
  }

  @override
  Future<void> saveActivePlan(domain.StudyPlan plan) async {
    await (db.update(db.studyPlans)..where((t) => t.isActive.equals(true))).write(
      const StudyPlansCompanion(isActive: Value(false)),
    );

    await db.into(db.studyPlans).insert(
      StudyPlansCompanion.insert(
        id: plan.id,
        startDate: plan.startDate,
        targetDate: plan.targetDate,
        availableHours: plan.availableHours,
        isActive: const Value(true),
        goal: Value(plan.goal),
        studyDays: Value(jsonEncode(plan.studyDays)),
        resources: Value(jsonEncode(plan.resources)),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  @override
  Future<void> deleteActivePlan() async {
    await (db.delete(db.studyPlans)..where((t) => t.isActive.equals(true))).go();
  }

  @override
  Future<List<domain.PlannerTask>> getTasksForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final rows = await (db.select(db.plannerTasks)
          ..where((t) => t.date.isBetweenValues(startOfDay, endOfDay)))
        .get();

    return rows.map(_mapDriftTaskToDomain).toList();
  }

  @override
  Future<List<domain.PlannerTask>> getAllScheduledTasks() async {
    final rows = await db.select(db.plannerTasks).get();
    return rows.map(_mapDriftTaskToDomain).toList();
  }

  @override
  Future<void> savePlannerTasks(List<domain.PlannerTask> tasks) async {
    await db.batch((batch) {
      for (var t in tasks) {
        batch.insert(
          db.plannerTasks,
          PlannerTasksCompanion.insert(
            id: t.id,
            date: t.date,
            itemType: t.itemType,
            itemId: t.itemId,
            isCompleted: Value(t.isCompleted),
            isReview: Value(t.isReview),
            duration: Value(t.duration),
            priority: Value(t.priority),
            completion: Value(t.completion),
            createdAt: Value(t.createdAt),
            updatedAt: Value(t.updatedAt),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<void> deleteUncompletedTasks() async {
    await (db.delete(db.plannerTasks)..where((t) => t.isCompleted.equals(false))).go();
  }

  @override
  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    await (db.update(db.plannerTasks)..where((t) => t.id.equals(taskId))).write(
      PlannerTasksCompanion(
        isCompleted: Value(isCompleted),
        completion: Value(isCompleted ? 100.0 : 0.0),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<List<Map<String, String>>> getUnlearnedItems(List<String> types) async {
    final List<Map<String, String>> items = [];

    if (types.contains('kanji')) {
      final rows = await (db.select(db.userKanjis)..where((u) => u.isAdded.equals(true) & u.isLearned.equals(false))).get();
      for (var r in rows) {
        items.add({'type': 'kanji', 'id': r.masterKanjiId});
      }
    }
    if (types.contains('vocab')) {
      final rows = await (db.select(db.userVocabularies)..where((u) => u.isAdded.equals(true) & u.status.isNotValue('mastered'))).get();
      for (var r in rows) {
        items.add({'type': 'vocab', 'id': r.masterVocabId});
      }
    }
    if (types.contains('grammar')) {
      final rows = await (db.select(db.userGrammars)..where((u) => u.isAdded.equals(true) & u.status.isNotValue('mastered'))).get();
      for (var r in rows) {
        items.add({'type': 'grammar', 'id': r.masterGrammarId});
      }
    }
    if (types.contains('reading')) {
      final rows = await (db.select(db.userReadings)..where((u) => u.isAdded.equals(true) & u.status.isNotValue('completed'))).get();
      for (var r in rows) {
        items.add({'type': 'reading', 'id': r.masterReadingId});
      }
    }
    if (types.contains('listening')) {
      final rows = await (db.select(db.userListenings)..where((u) => u.isAdded.equals(true) & u.status.isNotValue('completed'))).get();
      for (var r in rows) {
        items.add({'type': 'listening', 'id': r.masterListeningId});
      }
    }

    return items;
  }
}
