import 'dart:async';
import 'package:shinka_track_n3/core/analytics/domain/models/analytics_event.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/achievement_model.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/progression_config.dart';
import 'package:shinka_track_n3/features/achievements/domain/repositories/achievements_repository.dart';

class AchievementEngine {
  final AchievementsRepository repository;
  
  // Unlock callback trigger stream
  final _unlockController = StreamController<AchievementModel>.broadcast();
  Stream<AchievementModel> get onAchievementUnlocked => _unlockController.stream;

  AchievementEngine(this.repository);

  void dispose() {
    _unlockController.close();
  }

  // Seed standard achievements list
  Future<void> seedAchievements() async {
    final list = await repository.getAchievements();
    if (list.isNotEmpty) return;

    final standard = [
      const AchievementModel(
        id: 'first_kanji',
        title: 'First Kanji',
        description: 'Learn your first Kanji character.',
        category: 'learning',
        xpReward: 20,
        coinReward: 10,
        icon: 'menu_book',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'kanji_100',
        title: 'Kanji Scholar',
        description: 'Learn 100 Kanji characters.',
        category: 'learning',
        xpReward: 100,
        coinReward: 50,
        icon: 'menu_book',
        progress: 0,
        target: 100,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Medium',
      ),
      const AchievementModel(
        id: 'first_vocab',
        title: 'First Vocabulary',
        description: 'Learn your first vocabulary word.',
        category: 'learning',
        xpReward: 20,
        coinReward: 10,
        icon: 'translate',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'vocab_500',
        title: 'Vocabulary Master',
        description: 'Learn 500 vocabulary words.',
        category: 'learning',
        xpReward: 150,
        coinReward: 75,
        icon: 'translate',
        progress: 0,
        target: 500,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Hard',
      ),
      const AchievementModel(
        id: 'first_grammar',
        title: 'First Grammar',
        description: 'Learn your first grammatical pattern.',
        category: 'learning',
        xpReward: 20,
        coinReward: 10,
        icon: 'g_translate',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'grammar_100',
        title: 'Grammar Expert',
        description: 'Learn 100 grammar points.',
        category: 'learning',
        xpReward: 150,
        coinReward: 75,
        icon: 'g_translate',
        progress: 0,
        target: 100,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Hard',
      ),
      const AchievementModel(
        id: 'first_reading',
        title: 'First Reader',
        description: 'Complete your first reading comprehension passage.',
        category: 'learning',
        xpReward: 30,
        coinReward: 15,
        icon: 'chrome_reader_mode',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'first_listening',
        title: 'First Listener',
        description: 'Complete your first listening comprehension lesson.',
        category: 'learning',
        xpReward: 30,
        coinReward: 15,
        icon: 'audiotrack',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'streak_3',
        title: 'Consistent Start',
        description: 'Maintain a 3-day study streak.',
        category: 'consistency',
        xpReward: 50,
        coinReward: 25,
        icon: 'trending_up',
        progress: 0,
        target: 3,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'streak_30',
        title: 'Daily Routine',
        description: 'Maintain a 30-day study streak.',
        category: 'consistency',
        xpReward: 200,
        coinReward: 100,
        icon: 'trending_up',
        progress: 0,
        target: 30,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Hard',
      ),
      const AchievementModel(
        id: 'reviews_100',
        title: 'Active Reviewer',
        description: 'Complete 100 spaced repetition review cards.',
        category: 'review',
        xpReward: 50,
        coinReward: 25,
        icon: 'rate_review',
        progress: 0,
        target: 100,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Medium',
      ),
      const AchievementModel(
        id: 'perfect_review',
        title: 'Impeccable Recall',
        description: 'Complete a perfect review session with no incorrect answers.',
        category: 'review',
        xpReward: 100,
        coinReward: 50,
        icon: 'verified',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Medium',
      ),
      const AchievementModel(
        id: 'first_collection',
        title: 'Curator',
        description: 'Add your first item to study collection.',
        category: 'collection',
        xpReward: 20,
        coinReward: 10,
        icon: 'favorite',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'first_plan',
        title: 'Pathfinder',
        description: 'Generate your first study plan targets.',
        category: 'planner',
        xpReward: 30,
        coinReward: 15,
        icon: 'calendar_today',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: false,
        difficulty: 'Easy',
      ),
      const AchievementModel(
        id: 'hidden_easter_egg',
        title: 'Secret Scroll',
        description: 'Find the secret easter egg menu setting.',
        category: 'hidden',
        xpReward: 100,
        coinReward: 50,
        icon: 'help_outline',
        progress: 0,
        target: 1,
        isUnlocked: false,
        hidden: true,
        difficulty: 'Legendary',
      ),
    ];

    for (var a in standard) {
      await repository.saveAchievement(a);
    }
  }

  // Handle incoming log events and evaluate rules
  Future<void> processEvent(AnalyticsEvent event) async {
    // 1. Calculate XP Award
    int xpAward = 0;
    switch (event.eventType) {
      case 'LESSON_COMPLETED':
        if (event.contentType == 'kanji') xpAward = ProgressionConfig.xpKanjiCompleted;
        if (event.contentType == 'vocab') xpAward = ProgressionConfig.xpVocabCompleted;
        if (event.contentType == 'grammar') xpAward = ProgressionConfig.xpGrammarCompleted;
        if (event.contentType == 'reading') xpAward = ProgressionConfig.xpReadingCompleted;
        if (event.contentType == 'listening') xpAward = ProgressionConfig.xpListeningCompleted;
        break;
      case 'REVIEW_FINISHED':
        xpAward = ProgressionConfig.xpReviewSessionCompleted;
        break;
      case 'PLANNER_GENERATED':
        xpAward = ProgressionConfig.xpWeeklyGoalCompleted;
        break;
      case 'GOAL_COMPLETED':
        xpAward = ProgressionConfig.xpDailyGoalCompleted;
        break;
    }

    if (xpAward > 0) {
      await repository.addUserXp(xpAward);
    }

    // 2. Evaluate achievement progression rules
    final achievements = await repository.getAchievements();

    for (var a in achievements) {
      if (a.isUnlocked) continue;

      int newProgress = a.progress;

      if (a.id == 'first_kanji' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'kanji') {
        newProgress = 1;
      }
      if (a.id == 'kanji_100' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'kanji') {
        newProgress++;
      }
      if (a.id == 'first_vocab' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'vocab') {
        newProgress = 1;
      }
      if (a.id == 'vocab_500' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'vocab') {
        newProgress++;
      }
      if (a.id == 'first_grammar' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'grammar') {
        newProgress = 1;
      }
      if (a.id == 'grammar_100' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'grammar') {
        newProgress++;
      }
      if (a.id == 'first_reading' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'reading') {
        newProgress = 1;
      }
      if (a.id == 'first_listening' && event.eventType == 'LESSON_COMPLETED' && event.contentType == 'listening') {
        newProgress = 1;
      }
      if (a.id == 'first_collection' && event.eventType == 'COLLECTION_ADDED') {
        newProgress = 1;
      }
      if (a.id == 'first_plan' && event.eventType == 'PLANNER_GENERATED') {
        newProgress = 1;
      }
      if (a.id == 'reviews_100' && event.eventType == 'REVIEW_FINISHED') {
        final currentReviews = event.metadata['cardsCount'] as int? ?? 1;
        newProgress += currentReviews;
      }
      if (a.id == 'perfect_review' && event.eventType == 'REVIEW_FINISHED' && event.result == 'correct') {
        newProgress = 1;
      }
      if (a.id == 'streak_3' && event.eventType == 'STUDY_FINISHED') {
        final currentStreak = event.metadata['streak'] as int? ?? 1;
        newProgress = currentStreak;
      }
      if (a.id == 'streak_30' && event.eventType == 'STUDY_FINISHED') {
        final currentStreak = event.metadata['streak'] as int? ?? 1;
        newProgress = currentStreak;
      }

      if (newProgress != a.progress) {
        await repository.updateProgress(a.id, newProgress);

        // Check if now unlocked
        if (newProgress >= a.target) {
          final unlocked = a.copyWith(isUnlocked: true, unlockedAt: DateTime.now(), progress: a.target);
          _unlockController.add(unlocked);
          // Award unlock XP bonus!
          await repository.addUserXp(a.xpReward);
        }
      }
    }
  }
}
