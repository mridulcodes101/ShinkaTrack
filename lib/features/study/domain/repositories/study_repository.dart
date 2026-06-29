import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_planner_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/review_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/gamification_entities.dart';

abstract class StudyRepository {
  // Kanji catalog
  Future<List<KanjiEntity>> getKanjis();
  Future<void> updateKanjiStatus(String id, StudyStatus status);

  // Vocabulary catalog
  Future<List<VocabularyEntity>> getVocabularies();
  Future<void> updateVocabStatus(String id, StudyStatus status);

  // Grammar catalog
  Future<List<GrammarEntity>> getGrammars();
  Future<void> updateGrammarStatus(String id, StudyStatus status);

  // Reading catalog
  Future<List<ReadingEntity>> getReadings();
  Future<void> updateReadingStatus(String id, StudyStatus status);
  Future<void> updateReadingNotes(String id, String notes);

  // Listening catalog
  Future<List<ListeningEntity>> getListenings();
  Future<void> updateListeningStatus(String id, StudyStatus status);
  Future<void> updateListeningNotes(String id, String notes);

  // Study sessions
  Future<List<StudySessionEntity>> getStudySessions();
  Future<void> saveStudySession(DateTime date, int durationSeconds, String category);

  // Streak
  Future<int> calculateCurrentStreak();

  // Goals
  Future<DailyGoalEntity> getOrCreateDailyGoal(String date);
  Future<void> updateDailyGoalProgress(String date, {int? addSeconds, int? addItems});

  // Quiz assessment
  Future<void> saveQuizResult(int correct, int total, String type);
  Future<List<Map<String, dynamic>>> getQuizStats();

  // Reset database progress
  Future<void> resetAllProgress();

  // Study planner contracts
  Future<StudyPlanEntity?> getActiveStudyPlan();
  Future<void> createStudyPlan(StudyPlanEntity plan);
  Future<List<PlannerTaskEntity>> getTasksForDate(DateTime date);
  Future<void> toggleTaskCompletion(String taskId, bool isCompleted);
  Future<void> checkAndRedistributeMissedTasks();

  // Revision engine contracts
  Future<List<ReviewItemEntity>> getDueReviews(DateTime date);
  Future<List<ReviewItemEntity>> getMissedReviews(DateTime date);
  Future<List<ReviewItemEntity>> getUpcomingReviews(DateTime date);
  Future<void> submitReviewCompletion(String reviewId);
  Future<void> autoScheduleReview(String itemType, String itemId, bool isMastered);

  // Longest streak contract
  Future<int> calculateLongestStreak();

  // Gamification contracts
  Future<UserStatsEntity> getUserStats();
  Future<void> addXpAndCoins(int xp, int coins);
  Future<List<AchievementEntity>> getAchievements();
  Future<void> checkAndUnlockAchievements();
  Future<WeeklyGoalEntity> getOrCreateWeeklyGoal(String weekId);
  Future<void> updateWeeklyGoalProgress(String weekId, {int? addSeconds, int? addItems});
  Future<void> updateActivePlanHours(double hours);
  Future<String> exportBackupJson();
  Future<void> importBackupJson(String jsonStr);
}
