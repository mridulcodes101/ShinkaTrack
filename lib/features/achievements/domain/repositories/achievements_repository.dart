import 'package:shinka_track_n3/features/achievements/domain/models/achievement_model.dart';

abstract class AchievementsRepository {
  Future<List<AchievementModel>> getAchievements();
  Future<AchievementModel?> getAchievement(String id);
  Future<void> saveAchievement(AchievementModel achievement);
  Future<void> unlockAchievement(String id);
  Future<void> updateProgress(String id, int progress);
  Future<int> getUserXp();
  Future<void> addUserXp(int amount);
  Future<void> resetProgression();
}
