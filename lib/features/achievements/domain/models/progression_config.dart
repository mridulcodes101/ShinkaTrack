class ProgressionConfig {
  // Configurable XP rewards
  static const int xpKanjiCompleted = 10;
  static const int xpVocabCompleted = 8;
  static const int xpGrammarCompleted = 12;
  static const int xpReadingCompleted = 20;
  static const int xpListeningCompleted = 20;
  static const int xpReviewSessionCompleted = 15;
  static const int xpDailyGoalCompleted = 30;
  static const int xpWeeklyGoalCompleted = 100;

  // Formula level mapping: XP(L) = 25 * L^2 + 25 * L - 50
  static int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;
    return 25 * level * level + 25 * level - 50;
  }

  // Derived level from total XP
  static int calculateLevelFromXp(int totalXp) {
    int level = 1;
    while (xpRequiredForLevel(level + 1) <= totalXp) {
      level++;
    }
    return level;
  }
}
