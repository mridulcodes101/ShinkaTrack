import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/study_session/domain/models/study_session_model.dart';
import 'package:shinka_track_n3/features/study_session/domain/repositories/study_session_repository.dart';

class StudySessionRepositoryImpl implements StudySessionRepository {
  final AppDatabase db;

  StudySessionRepositoryImpl(this.db);

  StudySessionModel _mapSession(StudySession row) {
    return StudySessionModel(
      id: row.id,
      startTime: row.date,
      endTime: row.endTime,
      durationSeconds: row.durationSeconds,
      sessionType: row.category,
      status: row.status,
      modulesStudied: row.modulesStudied.isEmpty
          ? []
          : row.modulesStudied.split(','),
      tasksCompleted: row.tasksCompleted,
      reviewsCompleted: row.reviewsCompleted,
      interruptions: row.interruptions,
      pauseCount: row.pauseCount,
      completion: row.completion,
      xpEarned: row.xpEarned,
    );
  }

  @override
  Future<List<StudySessionModel>> getSessionHistory() async {
    final query = db.select(db.studySessions)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc)]);
    final list = await query.get();
    return list.map(_mapSession).toList();
  }

  @override
  Future<StudySessionModel?> getSession(String id) async {
    final query = db.select(db.studySessions)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapSession(row);
  }

  @override
  Future<void> saveSession(StudySessionModel session) async {
    await db.into(db.studySessions).insertOnConflictUpdate(
      StudySessionsCompanion.insert(
        id: session.id,
        date: session.startTime,
        endTime: Value(session.endTime),
        durationSeconds: session.durationSeconds,
        category: session.sessionType,
        status: Value(session.status),
        modulesStudied: Value(session.modulesStudied.join(',')),
        tasksCompleted: Value(session.tasksCompleted),
        reviewsCompleted: Value(session.reviewsCompleted),
        interruptions: Value(session.interruptions),
        pauseCount: Value(session.pauseCount),
        completion: Value(session.completion),
        xpEarned: Value(session.xpEarned),
      ),
    );
  }
}
