import 'package:shinka_track_n3/features/study_session/domain/models/study_session_model.dart';

abstract class StudySessionRepository {
  Future<List<StudySessionModel>> getSessionHistory();
  Future<void> saveSession(StudySessionModel session);
  Future<StudySessionModel?> getSession(String id);
}
