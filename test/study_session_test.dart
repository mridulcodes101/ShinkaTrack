import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/features/study_session/domain/models/study_session_model.dart';
import 'package:shinka_track_n3/features/study_session/domain/repositories/study_session_repository.dart';
import 'package:shinka_track_n3/features/study_session/services/study_session_engine.dart';
import 'package:shinka_track_n3/core/analytics/services/analytics_engine.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';
import 'package:shinka_track_n3/core/analytics/domain/repositories/analytics_repository.dart';

class InMemoryStudySessionRepository implements StudySessionRepository {
  final Map<String, StudySessionModel> store = {};

  @override
  Future<List<StudySessionModel>> getSessionHistory() async {
    return store.values.toList();
  }

  @override
  Future<void> saveSession(StudySessionModel session) async {
    store[session.id] = session;
  }

  @override
  Future<StudySessionModel?> getSession(String id) async {
    return store[id];
  }
}

class InMemoryAnalyticsRepository implements AnalyticsRepository {
  final List<AnalyticsEvent> events = [];

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    events.add(event);
  }

  @override
  Future<List<AnalyticsEvent>> getEvents(DateTime start, DateTime end) async => [];

  @override
  Future<List<AnalyticsEvent>> getEventsByType(String eventType) async => [];

  @override
  Future<int> getStudyTimeSeconds(DateTime start, DateTime end) async => 0;

  @override
  Future<int> getReviewCount(DateTime start, DateTime end) async => 0;

  @override
  Future<double> getAccuracyRatio(DateTime start, DateTime end) async => 0.0;

  @override
  Future<int> getLearnedCount(String contentType) async => 0;

  @override
  Future<int> getCompletedCount(String contentType) async => 0;
}

void main() {
  late InMemoryStudySessionRepository repository;
  late InMemoryAnalyticsRepository analyticsRepo;
  late AnalyticsEngine analyticsEngine;
  late StudySessionEngine engine;

  setUp(() {
    repository = InMemoryStudySessionRepository();
    analyticsRepo = InMemoryAnalyticsRepository();
    analyticsEngine = AnalyticsEngine(analyticsRepo);
    engine = StudySessionEngine(repository: repository, analyticsEngine: analyticsEngine);
  });

  group('SPEC-020: Study Session Engine (SSE) Tests', () {
    test('Start study session instantiates model and starts running', () async {
      final session = await engine.startSession(
        id: 's1',
        type: 'guided',
        modules: ['Kanji', 'Vocabulary'],
      );

      expect(session.id, 's1');
      expect(session.status, 'Running');
      expect(session.sessionType, 'guided');
      expect(session.modulesStudied, ['Kanji', 'Vocabulary']);
    });

    test('Pause and Resume transitions status and increments pause counts', () async {
      await engine.startSession(
        id: 's1',
        type: 'guided',
        modules: ['Kanji'],
      );

      await engine.pauseSession();
      expect(engine.activeSession!.status, 'Paused');
      expect(engine.activeSession!.pauseCount, 1);

      await engine.resumeSession();
      expect(engine.activeSession!.status, 'Running');
    });

    test('Interruption increments correct counter stats', () async {
      await engine.startSession(
        id: 's1',
        type: 'guided',
        modules: ['Kanji'],
      );

      await engine.recordInterruption();
      expect(engine.activeSession!.interruptions, 1);
    });

    test('Finish session maps duration, xp, and status logs', () async {
      await engine.startSession(
        id: 's1',
        type: 'guided',
        modules: ['Kanji'],
      );

      engine.incrementTasks();
      final finished = await engine.finishSession();

      expect(finished.status, 'Completed');
      expect(finished.tasksCompleted, 1);
      expect(finished.xpEarned, 10); // Base XP + elapsed seconds calculation
      expect(analyticsRepo.events.length, 1);
      expect(analyticsRepo.events.first.eventType, 'STUDY_FINISHED');
    });
  });
}
