import 'dart:async';
import 'package:shinka_track_n3/features/study_session/domain/models/study_session_model.dart';
import 'package:shinka_track_n3/features/study_session/domain/repositories/study_session_repository.dart';
import 'package:shinka_track_n3/core/analytics/services/analytics_engine.dart';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';

class StudySessionEngine {
  final StudySessionRepository repository;
  final AnalyticsEngine analyticsEngine;

  // Active session parameters
  StudySessionModel? _activeSession;
  Timer? _timer;
  int _secondsElapsed = 0;
  DateTime? _pauseStartTime;
  
  // Timer streams
  final _tickController = StreamController<int>.broadcast();
  Stream<int> get onTick => _tickController.stream;

  StudySessionEngine({
    required this.repository,
    required this.analyticsEngine,
  });

  StudySessionModel? get activeSession => _activeSession;
  int get secondsElapsed => _secondsElapsed;

  void dispose() {
    _timer?.cancel();
    _tickController.close();
  }

  // Start new StudySession
  Future<StudySessionModel> startSession({
    required String id,
    required String type, // guided, review, quick, planner, custom
    required List<String> modules,
  }) async {
    _timer?.cancel();
    _secondsElapsed = 0;
    _pauseStartTime = null;

    final session = StudySessionModel(
      id: id,
      startTime: DateTime.now(),
      durationSeconds: 0,
      sessionType: type,
      status: 'Running',
      modulesStudied: modules,
      tasksCompleted: 0,
      reviewsCompleted: 0,
      interruptions: 0,
      pauseCount: 0,
      completion: 0.0,
      xpEarned: 0,
    );

    _activeSession = session;
    await repository.saveSession(session);

    // Start timer ticker loop
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_activeSession?.status == 'Running') {
        _secondsElapsed++;
        _tickController.add(_secondsElapsed);
      }
    });

    return session;
  }

  // Pause active session
  Future<void> pauseSession() async {
    if (_activeSession == null || _activeSession!.status != 'Running') return;

    _pauseStartTime = DateTime.now();
    _activeSession = _activeSession!.copyWith(
      status: 'Paused',
      pauseCount: _activeSession!.pauseCount + 1,
    );

    await repository.saveSession(_activeSession!);
  }

  // Resume active session
  Future<void> resumeSession() async {
    if (_activeSession == null || _activeSession!.status != 'Paused') return;

    _pauseStartTime = null;

    _activeSession = _activeSession!.copyWith(status: 'Running');
    await repository.saveSession(_activeSession!);
  }

  // Record an interruption (app backgrounded / locked)
  Future<void> recordInterruption() async {
    if (_activeSession == null || _activeSession!.status != 'Running') return;

    _activeSession = _activeSession!.copyWith(
      interruptions: _activeSession!.interruptions + 1,
    );
    await repository.saveSession(_activeSession!);
  }

  // Log completed tasks/reviews
  void incrementTasks() {
    if (_activeSession == null) return;
    _activeSession = _activeSession!.copyWith(
      tasksCompleted: _activeSession!.tasksCompleted + 1,
    );
  }

  void incrementReviews(int count) {
    if (_activeSession == null) return;
    _activeSession = _activeSession!.copyWith(
      reviewsCompleted: _activeSession!.reviewsCompleted + count,
    );
  }

  // Finish active session
  Future<StudySessionModel> finishSession({bool isAbandon = false}) async {
    _timer?.cancel();

    if (_activeSession == null) {
      throw Exception('No active study session to finish.');
    }

    final now = DateTime.now();
    final status = isAbandon ? 'Abandoned' : 'Completed';
    final xpEarned = isAbandon ? 5 : (_secondsElapsed ~/ 60) * 2 + 10;

    final finished = _activeSession!.copyWith(
      endTime: now,
      status: status,
      durationSeconds: _secondsElapsed,
      completion: isAbandon ? 0.2 : 1.0,
      xpEarned: xpEarned,
    );

    await repository.saveSession(finished);
    _activeSession = null;

    // Log AnalyticsEvent on study finished
    await analyticsEngine.logEvent(AnalyticsEvent(
      id: finished.id,
      eventType: isAbandon ? 'STUDY_ABANDONED' : 'STUDY_FINISHED',
      contentType: finished.modulesStudied.join(','),
      timestamp: now,
      durationSeconds: finished.durationSeconds,
      result: status.toLowerCase(),
      metadata: {
        'tasksCompleted': finished.tasksCompleted,
        'reviewsCompleted': finished.reviewsCompleted,
        'xpEarned': finished.xpEarned,
      },
    ));

    return finished;
  }
}
