import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/study/data/repositories/study_repository_impl.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';
import 'package:intl/intl.dart';

// --- BASE DATABASE & REPOSITORY PROVIDERS ---

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    db.close();
  });
  return db;
});

final repositoryProvider = Provider<StudyRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return StudyRepositoryImpl(db);
});

// --- KANJI LIST STATE ---

class KanjiListNotifier extends StateNotifier<AsyncValue<List<KanjiEntity>>> {
  final StudyRepository _repository;

  KanjiListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadKanjis();
  }

  Future<void> loadKanjis() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repository.getKanjis();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStatus(String id, StudyStatus status) async {
    final previousState = state;
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((k) => k.id == id ? k.copyWith(
          isLearned: status == StudyStatus.mastered,
          reviewCount: status == StudyStatus.learning ? 1 : (status == StudyStatus.mastered ? 5 : 0),
        ) : k).toList(),
      );
    });

    try {
      await _repository.updateKanjiStatus(id, status);
    } catch (e) {
      state = previousState; // Rollback
    }
  Future<void> toggleFavorite(String id) async {
    final previousState = state;
    KanjiEntity? updatedKanji;

    state.whenData((list) {
      state = AsyncValue.data(
        list.map((k) {
          if (k.id == id) {
            updatedKanji = k.copyWith(isFavorite: !k.isFavorite);
            return updatedKanji!;
          }
          return k;
        }).toList(),
      );
    });

    if (updatedKanji != null) {
      try {
        await _repository.addKanji(updatedKanji!);
      } catch (e) {
        state = previousState; // Rollback
      }
    }
  }

  Future<void> addKanji(KanjiEntity kanji) async {
    try {
      await _repository.addKanji(kanji);
      await loadKanjis();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteKanji(String id) async {
    try {
      await _repository.deleteKanji(id);
      await loadKanjis();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final kanjiListProvider = StateNotifierProvider<KanjiListNotifier, AsyncValue<List<KanjiEntity>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return KanjiListNotifier(repo);
});

// --- VOCABULARY LIST STATE ---

class VocabListNotifier extends StateNotifier<AsyncValue<List<VocabularyEntity>>> {
  final StudyRepository _repository;

  VocabListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadVocabularies();
  }

  Future<void> loadVocabularies() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repository.getVocabularies();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStatus(String id, StudyStatus status) async {
    final previousState = state;
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((v) => v.id == id ? v.copyWith(status: status) : v).toList(),
      );
    });

    try {
      await _repository.updateVocabStatus(id, status);
    } catch (e) {
      state = previousState; // Rollback
    }
  }
}

final vocabListProvider = StateNotifierProvider<VocabListNotifier, AsyncValue<List<VocabularyEntity>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return VocabListNotifier(repo);
});

// --- GRAMMAR LIST STATE ---

class GrammarListNotifier extends StateNotifier<AsyncValue<List<GrammarEntity>>> {
  final StudyRepository _repository;

  GrammarListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadGrammars();
  }

  Future<void> loadGrammars() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repository.getGrammars();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStatus(String id, StudyStatus status) async {
    final previousState = state;
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((g) => g.id == id ? g.copyWith(status: status) : g).toList(),
      );
    });

    try {
      await _repository.updateGrammarStatus(id, status);
    } catch (e) {
      state = previousState; // Rollback
    }
  }
}

final grammarListProvider = StateNotifierProvider<GrammarListNotifier, AsyncValue<List<GrammarEntity>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return GrammarListNotifier(repo);
});

// --- DAILY GOAL STATE ---

class DailyGoalNotifier extends StateNotifier<AsyncValue<DailyGoalEntity>> {
  final StudyRepository _repository;
  final String _todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

  DailyGoalNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadTodayGoal();
  }

  Future<void> loadTodayGoal() async {
    try {
      final goal = await _repository.getOrCreateDailyGoal(_todayStr);
      state = AsyncValue.data(goal);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addProgress({int? seconds, int? items}) async {
    state.whenData((goal) {
      state = AsyncValue.data(DailyGoalEntity(
        id: goal.id,
        targetSeconds: goal.targetSeconds,
        completedSeconds: goal.completedSeconds + (seconds ?? 0),
        targetItems: goal.targetItems,
        completedItems: goal.completedItems + (items ?? 0),
      ));
    });

    try {
      await _repository.updateDailyGoalProgress(_todayStr, addSeconds: seconds, addItems: items);
    } catch (e) {
      // Re-load to resolve discrepancies on error
      await loadTodayGoal();
    }
  }
}

final dailyGoalProvider = StateNotifierProvider<DailyGoalNotifier, AsyncValue<DailyGoalEntity>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return DailyGoalNotifier(repo);
});

// --- STUDY SESSIONS STATE ---

class StudySessionsNotifier extends StateNotifier<AsyncValue<List<StudySessionEntity>>> {
  final StudyRepository _repository;

  StudySessionsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadSessions();
  }

  Future<void> loadSessions() async {
    try {
      final list = await _repository.getStudySessions();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> logSession(int durationSeconds, String category) async {
    try {
      final date = DateTime.now();
      await _repository.saveStudySession(date, durationSeconds, category);
      // Reload sessions list
      await loadSessions();
    } catch (e) {
      // Handle error
    }
  }
}

final studySessionsProvider = StateNotifierProvider<StudySessionsNotifier, AsyncValue<List<StudySessionEntity>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return StudySessionsNotifier(repo);
});

// --- READING LIST STATE ---

class ReadingListNotifier extends StateNotifier<AsyncValue<List<ReadingEntity>>> {
  final StudyRepository _repository;

  ReadingListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadReadings();
  }

  Future<void> loadReadings() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repository.getReadings();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStatus(String id, StudyStatus status) async {
    final previousState = state;
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((r) => r.id == id ? r.copyWith(status: status) : r).toList(),
      );
    });

    try {
      await _repository.updateReadingStatus(id, status);
    } catch (e) {
      state = previousState;
    }
  }

  Future<void> saveNotes(String id, String notes) async {
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((r) => r.id == id ? r.copyWith(notes: notes) : r).toList(),
      );
    });

    try {
      await _repository.updateReadingNotes(id, notes);
    } catch (e) {
      // Reload on error
      await loadReadings();
    }
  }
}

final readingListProvider = StateNotifierProvider<ReadingListNotifier, AsyncValue<List<ReadingEntity>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return ReadingListNotifier(repo);
});

// --- LISTENING LIST STATE ---

class ListeningListNotifier extends StateNotifier<AsyncValue<List<ListeningEntity>>> {
  final StudyRepository _repository;

  ListeningListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadListenings();
  }

  Future<void> loadListenings() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repository.getListenings();
      state = AsyncValue.data(list);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateStatus(String id, StudyStatus status) async {
    final previousState = state;
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((l) => l.id == id ? l.copyWith(status: status) : l).toList(),
      );
    });

    try {
      await _repository.updateListeningStatus(id, status);
    } catch (e) {
      state = previousState;
    }
  }

  Future<void> saveNotes(String id, String notes) async {
    state.whenData((list) {
      state = AsyncValue.data(
        list.map((l) => l.id == id ? l.copyWith(notes: notes) : l).toList(),
      );
    });

    try {
      await _repository.updateListeningNotes(id, notes);
    } catch (e) {
      await loadListenings();
    }
  }
}

final listeningListProvider = StateNotifierProvider<ListeningListNotifier, AsyncValue<List<ListeningEntity>>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return ListeningListNotifier(repo);
});

// --- STREAK STATE ---

class StreakNotifier extends StateNotifier<AsyncValue<int>> {
  final StudyRepository _repository;

  StreakNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadStreak();
  }

  Future<void> loadStreak() async {
    try {
      final streak = await _repository.calculateCurrentStreak();
      state = AsyncValue.data(streak);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final streakProvider = StateNotifierProvider<StreakNotifier, AsyncValue<int>>((ref) {
  final repo = ref.watch(repositoryProvider);
  return StreakNotifier(repo);
});

// --- PROGRESS STATISTICS ---

class ProgressStats {
  final double overall;
  final int kanjiMastered;
  final int kanjiTotal;
  final int vocabMastered;
  final int vocabTotal;
  final int grammarMastered;
  final int grammarTotal;
  final int readingMastered;
  final int readingTotal;
  final int listeningMastered;
  final int listeningTotal;

  ProgressStats({
    required this.overall,
    required this.kanjiMastered,
    required this.kanjiTotal,
    required this.vocabMastered,
    required this.vocabTotal,
    required this.grammarMastered,
    required this.grammarTotal,
    required this.readingMastered,
    required this.readingTotal,
    required this.listeningMastered,
    required this.listeningTotal,
  });
}

final overallProgressProvider = Provider<AsyncValue<ProgressStats>>((ref) {
  final kanji = ref.watch(kanjiListProvider);
  final vocab = ref.watch(vocabListProvider);
  final grammar = ref.watch(grammarListProvider);
  final reading = ref.watch(readingListProvider);
  final listening = ref.watch(listeningListProvider);

  if (kanji.hasValue && vocab.hasValue && grammar.hasValue && reading.hasValue && listening.hasValue) {
    final kList = kanji.value!;
    final vList = vocab.value!;
    final gList = grammar.value!;
    final rList = reading.value!;
    final lList = listening.value!;

    final kMastered = kList.where((x) => x.status == StudyStatus.mastered).length;
    final vMastered = vList.where((x) => x.status == StudyStatus.mastered).length;
    final gMastered = gList.where((x) => x.status == StudyStatus.mastered).length;
    final rMastered = rList.where((x) => x.status == StudyStatus.mastered).length;
    final lMastered = lList.where((x) => x.status == StudyStatus.mastered).length;

    final totalMastered = kMastered + vMastered + gMastered + rMastered + lMastered;
    final totalItems = kList.length + vList.length + gList.length + rList.length + lList.length;
    final double overallRatio = totalItems == 0 ? 0.0 : (totalMastered / totalItems);

    return AsyncValue.data(ProgressStats(
      overall: overallRatio,
      kanjiMastered: kMastered,
      kanjiTotal: kList.length,
      vocabMastered: vMastered,
      vocabTotal: vList.length,
      grammarMastered: gMastered,
      grammarTotal: gList.length,
      readingMastered: rMastered,
      readingTotal: rList.length,
      listeningMastered: lMastered,
      listeningTotal: lList.length,
    ));
  }
  return const AsyncValue.loading();
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final themeColorProvider = StateProvider<String>((ref) {
  return 'indigo';
});

final fontSizeProvider = StateProvider<double>((ref) {
  return 1.0;
});

final studyTabProvider = StateProvider<int>((ref) => 0);

// --- LONGEST STREAK PROVIDER ---

final longestStreakProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(repositoryProvider);
  return repo.calculateLongestStreak();
});

// --- DETAILED STUDY STATS PROVIDER ---

class StudyStatsBundle {
  final double dailyMinutes;
  final double weeklyMinutes;
  final double monthlyMinutes;
  final double averageDailyMinutes;

  StudyStatsBundle({
    required this.dailyMinutes,
    required this.weeklyMinutes,
    required this.monthlyMinutes,
    required this.averageDailyMinutes,
  });
}

final studyStatsProvider = FutureProvider<StudyStatsBundle>((ref) async {
  final sessionsAsync = ref.watch(studySessionsProvider);

  return sessionsAsync.when(
    loading: () => StudyStatsBundle(dailyMinutes: 0, weeklyMinutes: 0, monthlyMinutes: 0, averageDailyMinutes: 0),
    error: (err, stack) => StudyStatsBundle(dailyMinutes: 0, weeklyMinutes: 0, monthlyMinutes: 0, averageDailyMinutes: 0),
    data: (sessions) {
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      final sevenDaysAgo = todayStart.subtract(const Duration(days: 7));
      final thirtyDaysAgo = todayStart.subtract(const Duration(days: 30));

      double dailySec = 0.0;
      double weeklySec = 0.0;
      double monthlySec = 0.0;

      for (var s in sessions) {
        if (s.date.isAfter(todayStart) || s.date.isAtSameMomentAs(todayStart)) {
          dailySec += s.durationSeconds;
        }
        if (s.date.isAfter(sevenDaysAgo)) {
          weeklySec += s.durationSeconds;
        }
        if (s.date.isAfter(thirtyDaysAgo)) {
          monthlySec += s.durationSeconds;
        }
      }

      final uniqueDays = sessions.map((s) => DateTime(s.date.year, s.date.month, s.date.day)).toSet().length;
      final double avg = uniqueDays == 0 ? 0.0 : (sessions.fold(0, (sum, s) => sum + s.durationSeconds) / 60.0) / uniqueDays;

      return StudyStatsBundle(
        dailyMinutes: dailySec / 60.0,
        weeklyMinutes: weeklySec / 60.0,
        monthlyMinutes: monthlySec / 60.0,
        averageDailyMinutes: avg,
      );
    },
  );
});
