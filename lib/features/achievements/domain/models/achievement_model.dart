class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String category; // learning, consistency, review, collection, planner, milestones, hidden
  final int xpReward;
  final int coinReward;
  final String icon;
  final int progress;
  final int target;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final bool hidden;
  final String difficulty; // Easy, Medium, Hard, Legendary

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.xpReward,
    required this.coinReward,
    required this.icon,
    required this.progress,
    required this.target,
    required this.isUnlocked,
    this.unlockedAt,
    required this.hidden,
    required this.difficulty,
  });

  AchievementModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    int? xpReward,
    int? coinReward,
    String? icon,
    int? progress,
    int? target,
    bool? isUnlocked,
    DateTime? unlockedAt,
    bool? hidden,
    String? difficulty,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      xpReward: xpReward ?? this.xpReward,
      coinReward: coinReward ?? this.coinReward,
      icon: icon ?? this.icon,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      hidden: hidden ?? this.hidden,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
