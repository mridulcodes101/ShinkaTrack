import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/core/analytics/services/analytics_engine.dart';
import 'package:shinka_track_n3/core/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:shinka_track_n3/features/study_session/domain/models/study_session_model.dart';
import 'package:shinka_track_n3/features/study_session/domain/repositories/study_session_repository.dart';
import 'package:shinka_track_n3/features/study_session/data/repositories/study_session_repository_impl.dart';
import 'package:shinka_track_n3/features/study_session/services/study_session_engine.dart';

final studySessionRepositoryProvider = Provider<StudySessionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return StudySessionRepositoryImpl(db);
});

// Watch analytics provider to inject into session engine
final analyticsRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return AnalyticsRepositoryImpl(db);
});

final analyticsEngineProvider = Provider((ref) {
  final repo = ref.watch(analyticsRepositoryProvider);
  return AnalyticsEngine(repo);
});

final studySessionEngineProvider = Provider<StudySessionEngine>((ref) {
  final repo = ref.watch(studySessionRepositoryProvider);
  final analytics = ref.watch(analyticsEngineProvider);
  return StudySessionEngine(repository: repo, analyticsEngine: analytics);
});

final sessionHistoryProvider = FutureProvider.autoDispose<List<StudySessionModel>>((ref) async {
  final repo = ref.watch(studySessionRepositoryProvider);
  return repo.getSessionHistory();
});

final activeSessionStateProvider = StateProvider<StudySessionModel?>((ref) => null);
