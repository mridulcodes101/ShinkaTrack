class UserStatsEntity {
  final String id;
  final int xp;
  final int coins;

  const UserStatsEntity({
    required this.id,
    required this.xp,
    required this.coins,
  });

  int get level => (xp ~/ 100) + 1;
  int get xpInLevel => xp % 100;
  int get xpNeededForNextLevel => 100;

  UserStatsEntity copyWith({
    int? xp,
    int? coins,
  }) {
    return UserStatsEntity(
      id: id,
      xp: xp ?? this.xp,
      coins: coins ?? this.coins,
    );
  }
}

class AchievementEntity {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final int coinReward;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const AchievementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.coinReward,
    required this.isUnlocked,
    this.unlockedAt,
  });

  AchievementEntity copyWith({
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return AchievementEntity(
      id: id,
      title: title,
      description: description,
      xpReward: xpReward,
      coinReward: coinReward,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}

class WeeklyGoalEntity {
  final String id; // "yyyy-Www"
  final int targetSeconds;
  final int completedSeconds;
  final int targetItems;
  final int completedItems;
  final bool isClaimed;

  const WeeklyGoalEntity({
    required this.id,
    required this.targetSeconds,
    required this.completedSeconds,
    required this.targetItems,
    required this.completedItems,
    required this.isClaimed,
  });

  double get timeRatio => (completedSeconds / targetSeconds).clamp(0.0, 1.0);
  double get itemRatio => (completedItems / targetItems).clamp(0.0, 1.0);

  WeeklyGoalEntity copyWith({
    int? completedSeconds,
    int? completedItems,
    bool? isClaimed,
  }) {
    return WeeklyGoalEntity(
      id: id,
      targetSeconds: targetSeconds,
      completedSeconds: completedSeconds ?? this.completedSeconds,
      targetItems: targetItems,
      completedItems: completedItems ?? this.completedItems,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }
}
