import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/achievement_model.dart';
import 'package:shinka_track_n3/features/achievements/domain/repositories/achievements_repository.dart';

class AchievementsRepositoryImpl implements AchievementsRepository {
  final AppDatabase db;

  AchievementsRepositoryImpl(this.db);

  AchievementModel _mapAchievement(Achievement a) {
    return AchievementModel(
      id: a.id,
      title: a.title,
      description: a.description,
      category: a.category,
      xpReward: a.xpReward,
      coinReward: a.coinReward,
      icon: a.icon,
      progress: a.progress,
      target: a.target,
      isUnlocked: a.isUnlocked,
      unlockedAt: a.unlockedAt,
      hidden: a.hidden,
      difficulty: a.difficulty,
    );
  }

  @override
  Future<List<AchievementModel>> getAchievements() async {
    final list = await db.select(db.achievements).get();
    return list.map(_mapAchievement).toList();
  }

  @override
  Future<AchievementModel?> getAchievement(String id) async {
    final query = db.select(db.achievements)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapAchievement(row);
  }

  @override
  Future<void> saveAchievement(AchievementModel achievement) async {
    await db.into(db.achievements).insertOnConflictUpdate(
      AchievementsCompanion.insert(
        id: achievement.id,
        title: achievement.title,
        description: achievement.description,
        category: Value(achievement.category),
        xpReward: achievement.xpReward,
        coinReward: achievement.coinReward,
        icon: Value(achievement.icon),
        progress: Value(achievement.progress),
        target: Value(achievement.target),
        isUnlocked: Value(achievement.isUnlocked),
        unlockedAt: Value(achievement.unlockedAt),
        hidden: Value(achievement.hidden),
        difficulty: Value(achievement.difficulty),
      ),
    );
  }

  @override
  Future<void> unlockAchievement(String id) async {
    final now = DateTime.now();
    await (db.update(db.achievements)..where((tbl) => tbl.id.equals(id))).write(
      AchievementsCompanion(
        isUnlocked: const Value(true),
        unlockedAt: Value(now),
        progress: const Value(1), // set progress matching target to unlock
      ),
    );
  }

  @override
  Future<void> updateProgress(String id, int progress) async {
    final ach = await getAchievement(id);
    if (ach == null) return;
    
    final reachedTarget = progress >= ach.target;
    await (db.update(db.achievements)..where((tbl) => tbl.id.equals(id))).write(
      AchievementsCompanion(
        progress: Value(progress.clamp(0, ach.target)),
        isUnlocked: Value(reachedTarget),
        unlockedAt: Value(reachedTarget ? (ach.unlockedAt ?? DateTime.now()) : null),
      ),
    );
  }

  @override
  Future<int> getUserXp() async {
    final query = db.select(db.userStats)..where((tbl) => tbl.id.equals('user'));
    final row = await query.getSingleOrNull();
    if (row == null) {
      // Seed initial user statistics row
      await db.into(db.userStats).insert(
        UserStatsCompanion.insert(id: 'user', xp: const Value(0), coins: const Value(0)),
      );
      return 0;
    }
    return row.xp;
  }

  @override
  Future<void> addUserXp(int amount) async {
    final currentXp = await getUserXp();
    await (db.update(db.userStats)..where((tbl) => tbl.id.equals('user'))).write(
      UserStatsCompanion(
        xp: Value(currentXp + amount),
      ),
    );
  }

  @override
  Future<void> resetProgression() async {
    await (db.update(db.userStats)..where((tbl) => tbl.id.equals('user'))).write(
      const UserStatsCompanion(xp: Value(0), coins: Value(0)),
    );
    await (db.update(db.achievements)).write(
      const AchievementsCompanion(
        isUnlocked: Value(false),
        unlockedAt: Value(null),
        progress: Value(0),
      ),
    );
  }
}
