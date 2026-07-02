import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/features/achievements/domain/models/achievement_model.dart';
import 'package:shinka_track_n3/features/achievements/domain/repositories/achievements_repository.dart';
import 'package:shinka_track_n3/features/achievements/data/repositories/achievements_repository_impl.dart';
import 'package:shinka_track_n3/features/achievements/services/achievement_engine.dart';

final achievementsRepositoryProvider = Provider<AchievementsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AchievementsRepositoryImpl(db);
});

final achievementEngineProvider = Provider<AchievementEngine>((ref) {
  final repo = ref.watch(achievementsRepositoryProvider);
  final engine = AchievementEngine(repo);
  
  // Auto-seed initial achievements lists
  engine.seedAchievements();
  
  ref.onDispose(() {
    engine.dispose();
  });
  return engine;
});

final userXpProvider = FutureProvider.autoDispose<int>((ref) async {
  final repo = ref.watch(achievementsRepositoryProvider);
  return repo.getUserXp();
});

final achievementsListProvider = FutureProvider.autoDispose<List<AchievementModel>>((ref) async {
  final repo = ref.watch(achievementsRepositoryProvider);
  return repo.getAchievements();
});
