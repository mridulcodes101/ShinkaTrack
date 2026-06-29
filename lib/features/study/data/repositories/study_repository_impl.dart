import 'package:drift/drift.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_planner_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/review_entities.dart';
import 'package:shinka_track_n3/features/study/domain/entities/gamification_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinka_track_n3/features/study/domain/repositories/study_repository.dart';
import 'package:uuid/uuid.dart';

class StudyRepositoryImpl implements StudyRepository {
  final AppDatabase db;
  final Uuid _uuid = const Uuid();

  StudyRepositoryImpl(this.db);

  @override
  Future<List<KanjiEntity>> getKanjis() async {
    final list = await db.select(db.kanjis).get();
    return list.map((k) {
      final List<String> kunYomiList = List<String>.from(jsonDecode(k.kunYomi));
      final List<String> onYomiList = List<String>.from(jsonDecode(k.onYomi));
      final List<String> examplesList = List<String>.from(jsonDecode(k.examples));
      return KanjiEntity(
        id: k.id,
        kanji: k.kanji,
        kunYomi: kunYomiList,
        onYomi: onYomiList,
        meaning: k.meaning,
        radicals: k.radicals,
        strokeCount: k.strokeCount,
        strokeOrderDiagramPath: k.strokeOrderDiagramPath,
        jlptLevel: k.jlptLevel,
        gradeLevel: k.gradeLevel,
        unicode: k.unicode,
        notes: k.notes,
        examples: examplesList,
        isLearned: k.isLearned,
        isFavorite: k.isFavorite,
        createdAt: k.createdAt,
        updatedAt: k.updatedAt,
        lastReviewed: k.lastReviewed,
        reviewCount: k.reviewCount,
        easeFactor: k.easeFactor,
        nextReview: k.nextReview,
        rtkNumber: k.rtkNumber,
        frequencyRank: k.frequencyRank,
        pitchAccent: k.pitchAccent,
        audioPath: k.audioPath,
        animatedStrokeOrderPath: k.animatedStrokeOrderPath,
        syncStatus: k.syncStatus,
        lastSyncedAt: k.lastSyncedAt,
      );
    }).toList();
  }

  @override
  Future<void> updateKanjiStatus(String id, StudyStatus status) async {
    final existing = await (db.select(db.kanjis)..where((t) => t.id.equals(id))).getSingleOrNull();
    final bool wasLearned = existing?.isLearned ?? false;
    final bool isNowLearned = status == StudyStatus.mastered;

    await (db.update(db.kanjis)..where((t) => t.id.equals(id))).write(
      KanjisCompanion(
        isLearned: Value(isNowLearned),
        reviewCount: Value((existing?.reviewCount ?? 0) + 1),
        lastReviewed: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await autoScheduleReview('kanji', id, isNowLearned);

    if (isNowLearned && !wasLearned) {
      await _onItemMastered(id, 'kanji');
    }
  }

  @override
  Future<void> addKanji(KanjiEntity kanji) async {
    await db.into(db.kanjis).insert(
      KanjisCompanion.insert(
        id: kanji.id,
        kanji: kanji.kanji,
        kunYomi: jsonEncode(kanji.kunYomi),
        onYomi: jsonEncode(kanji.onYomi),
        meaning: kanji.meaning,
        radicals: kanji.radicals,
        strokeCount: kanji.strokeCount,
        strokeOrderDiagramPath: Value(kanji.strokeOrderDiagramPath),
        jlptLevel: kanji.jlptLevel,
        gradeLevel: Value(kanji.gradeLevel),
        unicode: kanji.unicode,
        notes: Value(kanji.notes),
        examples: Value(jsonEncode(kanji.examples)),
        isLearned: Value(kanji.isLearned),
        isFavorite: Value(kanji.isFavorite),
        createdAt: kanji.createdAt,
        updatedAt: kanji.updatedAt,
        lastReviewed: Value(kanji.lastReviewed),
        reviewCount: Value(kanji.reviewCount),
        easeFactor: Value(kanji.easeFactor),
        nextReview: Value(kanji.nextReview),
        rtkNumber: Value(kanji.rtkNumber),
        frequencyRank: Value(kanji.frequencyRank),
        pitchAccent: Value(kanji.pitchAccent),
        audioPath: Value(kanji.audioPath),
        animatedStrokeOrderPath: Value(kanji.animatedStrokeOrderPath),
        syncStatus: Value(kanji.syncStatus),
        lastSyncedAt: Value(kanji.lastSyncedAt),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  @override
  Future<void> deleteKanji(String id) async {
    // 1. Delete from Kanjis table
    await (db.delete(db.kanjis)..where((t) => t.id.equals(id))).go();
    // 2. Cascade delete from review items
    await (db.delete(db.reviewItems)..where((t) => t.itemId.equals(id) & t.itemType.equals('kanji'))).go();
    // 3. Cascade delete from planner tasks
    await (db.delete(db.plannerTasks)..where((t) => t.itemId.equals(id) & t.itemType.equals('kanji'))).go();
  }

  @override
  Future<List<VocabularyEntity>> getVocabularies() async {
    final list = await db.select(db.vocabularies).get();
    return list.map((v) => VocabularyEntity(
      id: v.id,
      word: v.word,
      reading: v.reading,
      meaning: v.meaning,
      status: StudyStatus.fromString(v.status),
    )).toList();
  }

  @override
  Future<void> updateVocabStatus(String id, StudyStatus status) async {
    final existing = await (db.select(db.vocabularies)..where((t) => t.id.equals(id))).getSingleOrNull();
    final bool wasMastered = existing?.status == 'mastered';

    await (db.update(db.vocabularies)..where((t) => t.id.equals(id))).write(
      VocabulariesCompanion(status: Value(status.toDbString())),
    );
    await autoScheduleReview('vocab', id, status == StudyStatus.mastered);

    if (status == StudyStatus.mastered && !wasMastered) {
      await _onItemMastered(id, 'vocab');
    }
  }

  @override
  Future<List<GrammarEntity>> getGrammars() async {
    final list = await db.select(db.grammars).get();
    return list.map((g) => GrammarEntity.fromDb(
      id: g.id,
      title: g.title,
      explanation: g.explanation,
      structure: g.structure,
      examplesJson: g.examplesJson,
      status: StudyStatus.fromString(g.status),
    )).toList();
  }

  @override
  Future<void> updateGrammarStatus(String id, StudyStatus status) async {
    final existing = await (db.select(db.grammars)..where((t) => t.id.equals(id))).getSingleOrNull();
    final bool wasMastered = existing?.status == 'mastered';

    await (db.update(db.grammars)..where((t) => t.id.equals(id))).write(
      GrammarsCompanion(status: Value(status.toDbString())),
    );
    await autoScheduleReview('grammar', id, status == StudyStatus.mastered);

    if (status == StudyStatus.mastered && !wasMastered) {
      await _onItemMastered(id, 'grammar');
    }
  }

  @override
  Future<List<StudySessionEntity>> getStudySessions() async {
    final list = await db.select(db.studySessions).get();
    return list.map((s) => StudySessionEntity(
      id: s.id,
      date: s.date,
      durationSeconds: s.durationSeconds,
      category: s.category,
    )).toList();
  }

  @override
  Future<void> saveStudySession(DateTime date, int durationSeconds, String category) async {
    final id = _uuid.v4();
    await db.into(db.studySessions).insert(StudySessionsCompanion.insert(
      id: id,
      date: date,
      durationSeconds: durationSeconds,
      category: category,
    ));

    // Gamification payout
    final int minStudy = durationSeconds ~/ 60;
    final int xpGained = minStudy > 1 ? minStudy : 1;
    final int coinsGained = durationSeconds ~/ 300;
    await addXpAndCoins(xpGained, coinsGained);

    // Update weekly goal seconds progress
    final String weekId = _getCurrentWeekId();
    await updateWeeklyGoalProgress(weekId, addSeconds: durationSeconds);
  }

  @override
  Future<DailyGoalEntity> getOrCreateDailyGoal(String date) async {
    final query = db.select(db.dailyGoals)..where((t) => t.id.equals(date));
    final goal = await query.getSingleOrNull();

    final prefs = await SharedPreferences.getInstance();
    final targetMin = prefs.getInt('settings_daily_goal_minutes') ?? 15;
    final targetSeconds = targetMin * 60;
    final targetItems = prefs.getInt('settings_daily_goal_items') ?? 10;

    if (goal != null) {
      return DailyGoalEntity(
        id: goal.id,
        targetSeconds: goal.targetSeconds,
        completedSeconds: goal.completedSeconds,
        targetItems: goal.targetItems,
        completedItems: goal.completedItems,
      );
    } else {
      // Create new one for the day
      await db.into(db.dailyGoals).insert(DailyGoalsCompanion.insert(
        id: date,
        targetSeconds: Value(targetSeconds),
        completedSeconds: const Value(0),
        targetItems: Value(targetItems),
        completedItems: const Value(0),
      ));
      return DailyGoalEntity(
        id: date,
        targetSeconds: targetSeconds,
        completedSeconds: 0,
        targetItems: targetItems,
        completedItems: 0,
      );
    }
  }

  @override
  Future<void> updateDailyGoalProgress(String date, {int? addSeconds, int? addItems}) async {
    final currentGoal = await getOrCreateDailyGoal(date);
    final newSeconds = currentGoal.completedSeconds + (addSeconds ?? 0);
    final newItems = currentGoal.completedItems + (addItems ?? 0);

    await (db.update(db.dailyGoals)..where((t) => t.id.equals(date))).write(
      DailyGoalsCompanion(
        completedSeconds: Value(newSeconds),
        completedItems: Value(newItems),
      ),
    );
  }

  @override
  Future<void> saveQuizResult(int correct, int total, String type) async {
    final id = _uuid.v4();
    await db.into(db.quizResults).insert(QuizResultsCompanion.insert(
      id: id,
      date: DateTime.now(),
      correctCount: correct,
      totalCount: total,
      quizType: type,
    ));
  }

  @override
  Future<List<Map<String, dynamic>>> getQuizStats() async {
    final list = await db.select(db.quizResults).get();
    return list.map((q) => {
      'date': q.date,
      'correct': q.correctCount,
      'total': q.totalCount,
      'type': q.quizType,
    }).toList();
  }

  @override
  Future<List<ReadingEntity>> getReadings() async {
    final list = await db.select(db.readings).get();
    return list.map((r) => ReadingEntity(
      id: r.id,
      title: r.title,
      passage: r.passage,
      question: r.question,
      answer: r.answer,
      explanation: r.explanation,
      notes: r.notes,
      status: StudyStatus.fromString(r.status),
    )).toList();
  }

  @override
  Future<void> updateReadingStatus(String id, StudyStatus status) async {
    final existing = await (db.select(db.readings)..where((t) => t.id.equals(id))).getSingleOrNull();
    final bool wasMastered = existing?.status == 'mastered';

    await (db.update(db.readings)..where((t) => t.id.equals(id))).write(
      ReadingsCompanion(status: Value(status.toDbString())),
    );
    await autoScheduleReview('reading', id, status == StudyStatus.mastered);

    if (status == StudyStatus.mastered && !wasMastered) {
      await _onItemMastered(id, 'reading');
    }
  }

  @override
  Future<void> updateReadingNotes(String id, String notes) async {
    await (db.update(db.readings)..where((t) => t.id.equals(id))).write(
      ReadingsCompanion(notes: Value(notes)),
    );
  }

  @override
  Future<List<ListeningEntity>> getListenings() async {
    final list = await db.select(db.listenings).get();
    return list.map((l) => ListeningEntity(
      id: l.id,
      title: l.title,
      audioScript: l.audioScript,
      question: l.question,
      answer: l.answer,
      explanation: l.explanation,
      notes: l.notes,
      status: StudyStatus.fromString(l.status),
    )).toList();
  }

  @override
  Future<void> updateListeningStatus(String id, StudyStatus status) async {
    final existing = await (db.select(db.listenings)..where((t) => t.id.equals(id))).getSingleOrNull();
    final bool wasMastered = existing?.status == 'mastered';

    await (db.update(db.listenings)..where((t) => t.id.equals(id))).write(
      ListeningsCompanion(status: Value(status.toDbString())),
    );
    await autoScheduleReview('listening', id, status == StudyStatus.mastered);

    if (status == StudyStatus.mastered && !wasMastered) {
      await _onItemMastered(id, 'listening');
    }
  }

  @override
  Future<void> updateListeningNotes(String id, String notes) async {
    await (db.update(db.listenings)..where((t) => t.id.equals(id))).write(
      ListeningsCompanion(notes: Value(notes)),
    );
  }

  @override
  Future<int> calculateCurrentStreak() async {
    final list = await db.select(db.studySessions).get();
    if (list.isEmpty) return 0;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final Set<String> sessionDates = list.map((s) => formatter.format(s.date)).toSet();

    final List<String> sortedDates = sessionDates.toList()..sort((a, b) => b.compareTo(a));

    final String today = formatter.format(DateTime.now());
    final String yesterday = formatter.format(DateTime.now().subtract(const Duration(days: 1)));

    if (!sortedDates.contains(today) && !sortedDates.contains(yesterday)) {
      return 0;
    }

    int streak = 0;
    DateTime checkDate = sortedDates.contains(today) ? DateTime.now() : DateTime.now().subtract(const Duration(days: 1));

    while (true) {
      final String checkStr = formatter.format(checkDate);
      if (sortedDates.contains(checkStr)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Future<void> resetAllProgress() async {
    await db.update(db.kanjis).write(const KanjisCompanion(
      isLearned: Value(false),
      reviewCount: Value(0),
      easeFactor: Value(2.5),
      lastReviewed: Value(null),
      nextReview: Value(null),
    ));
    await db.update(db.vocabularies).write(const VocabulariesCompanion(status: Value('unlearned')));
    await db.update(db.grammars).write(const GrammarsCompanion(status: Value('unlearned')));
    await db.update(db.readings).write(const ReadingsCompanion(status: Value('unlearned'), notes: Value('')));
    await db.update(db.listenings).write(const ListeningsCompanion(status: Value('unlearned'), notes: Value('')));

    await db.delete(db.studySessions).go();
    await db.delete(db.dailyGoals).go();
    await db.delete(db.quizResults).go();
    await db.delete(db.studyPlans).go();
    await db.delete(db.plannerTasks).go();
    await db.delete(db.reviewItems).go();
  }

  @override
  Future<StudyPlanEntity?> getActiveStudyPlan() async {
    final query = db.select(db.studyPlans)..where((t) => t.isActive.equals(true));
    final plan = await query.getSingleOrNull();
    if (plan == null) return null;
    return StudyPlanEntity(
      id: plan.id,
      startDate: plan.startDate,
      targetDate: plan.targetDate,
      availableHours: plan.availableHours,
      isActive: plan.isActive,
    );
  }

  @override
  Future<void> createStudyPlan(StudyPlanEntity plan) async {
    // Deactivate existing plans
    await (db.update(db.studyPlans)..where((t) => t.isActive.equals(true))).write(
      const StudyPlansCompanion(isActive: Value(false)),
    );

    // Insert new plan
    await db.into(db.studyPlans).insert(StudyPlansCompanion.insert(
      id: plan.id,
      startDate: plan.startDate,
      targetDate: plan.targetDate,
      availableHours: plan.availableHours,
      isActive: const Value(true),
    ));

    // Clear existing tasks
    await db.delete(db.plannerTasks).go();

    // Fetch all items that are not mastered
    final kanjiList = await db.select(db.kanjis).get();
    final vocabList = await db.select(db.vocabularies).get();
    final grammarList = await db.select(db.grammars).get();
    final readingList = await db.select(db.readings).get();
    final listeningList = await db.select(db.listenings).get();

    final unlearnedKanjis = kanjiList.where((k) => !k.isLearned).toList();
    final unlearnedVocabs = vocabList.where((v) => v.status != 'mastered').toList();
    final unlearnedGrammars = grammarList.where((g) => g.status != 'mastered').toList();
    final unlearnedReadings = readingList.where((r) => r.status != 'mastered').toList();
    final unlearnedListenings = listeningList.where((l) => l.status != 'mastered').toList();

    // Create list of all items to schedule
    final List<Map<String, String>> scheduleItems = [];
    for (var k in unlearnedKanjis) {
      scheduleItems.add({'type': 'kanji', 'id': k.id});
    }
    for (var v in unlearnedVocabs) {
      scheduleItems.add({'type': 'vocab', 'id': v.id});
    }
    for (var g in unlearnedGrammars) {
      scheduleItems.add({'type': 'grammar', 'id': g.id});
    }
    for (var r in unlearnedReadings) {
      scheduleItems.add({'type': 'reading', 'id': r.id});
    }
    for (var l in unlearnedListenings) {
      scheduleItems.add({'type': 'listening', 'id': l.id});
    }

    // Calculate dates
    final List<DateTime> studyDates = [];
    final List<DateTime> sundayReviewDates = [];

    DateTime current = DateTime(plan.startDate.year, plan.startDate.month, plan.startDate.day);
    final DateTime end = DateTime(plan.targetDate.year, plan.targetDate.month, plan.targetDate.day);

    while (!current.isAfter(end)) {
      if (current.weekday == DateTime.sunday) {
        sundayReviewDates.add(current);
      } else {
        studyDates.add(current);
      }
      current = current.add(const Duration(days: 1));
    }

    // Schedule Sunday Review Days
    for (var sun in sundayReviewDates) {
      await db.into(db.plannerTasks).insert(PlannerTasksCompanion.insert(
        id: _uuid.v4(),
        date: sun,
        itemType: 'review',
        itemId: 'sunday_review',
        isCompleted: const Value(false),
        isReview: const Value(true),
      ));
    }

    if (studyDates.isEmpty || scheduleItems.isEmpty) return;

    // Distribute items round-robin across study dates
    for (int i = 0; i < scheduleItems.length; i++) {
      final item = scheduleItems[i];
      final date = studyDates[i % studyDates.length];

      await db.into(db.plannerTasks).insert(PlannerTasksCompanion.insert(
        id: _uuid.v4(),
        date: date,
        itemType: item['type']!,
        itemId: item['id']!,
        isCompleted: const Value(false),
        isReview: const Value(false),
      ));
    }
  }

  @override
  Future<List<PlannerTaskEntity>> getTasksForDate(DateTime date) async {
    final DateTime dayStart = DateTime(date.year, date.month, date.day);
    final query = db.select(db.plannerTasks)..where((t) => t.date.equals(dayStart));
    final dbTasks = await query.get();

    final List<PlannerTaskEntity> entities = [];

    for (var t in dbTasks) {
      String title = '';
      String details = '';

      if (t.isReview) {
        title = 'Sunday Review Session';
        details = 'Weekly wrap-up: review all items studied this week.';
      } else {
        if (t.itemType == 'kanji') {
          final item = await (db.select(db.kanjis)..where((x) => x.id.equals(t.itemId))).getSingleOrNull();
          title = 'Learn Kanji: ${item?.kanji ?? ""}';
          details = item?.meaning ?? '';
        } else if (t.itemType == 'vocab') {
          final item = await (db.select(db.vocabularies)..where((x) => x.id.equals(t.itemId))).getSingleOrNull();
          title = 'Learn Vocab: ${item?.word ?? ""}';
          details = item?.meaning ?? '';
        } else if (t.itemType == 'grammar') {
          final item = await (db.select(db.grammars)..where((x) => x.id.equals(t.itemId))).getSingleOrNull();
          title = 'Learn Grammar: ${item?.title ?? ""}';
          details = item?.explanation ?? '';
        } else if (t.itemType == 'reading') {
          final item = await (db.select(db.readings)..where((x) => x.id.equals(t.itemId))).getSingleOrNull();
          title = 'Read Lesson: ${item?.title ?? ""}';
          details = item?.question ?? '';
        } else if (t.itemType == 'listening') {
          final item = await (db.select(db.listenings)..where((x) => x.id.equals(t.itemId))).getSingleOrNull();
          title = 'Listen Lesson: ${item?.title ?? ""}';
          details = item?.question ?? '';
        }
      }

      entities.add(PlannerTaskEntity(
        id: t.id,
        date: t.date,
        itemType: t.itemType,
        itemId: t.itemId,
        isCompleted: t.isCompleted,
        isReview: t.isReview,
        title: title,
        details: details,
      ));
    }

    return entities;
  }

  @override
  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    // 1. Update task in database
    await (db.update(db.plannerTasks)..where((t) => t.id.equals(taskId))).write(
      PlannerTasksCompanion(isCompleted: Value(isCompleted)),
    );

    // 2. Fetch the task details to find itemType & itemId
    final task = await (db.select(db.plannerTasks)..where((t) => t.id.equals(taskId))).getSingleOrNull();
    if (task == null || task.isReview) return;

    final newStatus = isCompleted ? StudyStatus.mastered : StudyStatus.learning;

    // 3. Update the corresponding study item status
    if (task.itemType == 'kanji') {
      await (db.update(db.kanjis)..where((x) => x.id.equals(task.itemId))).write(
        KanjisCompanion(isLearned: Value(isCompleted)),
      );
    } else if (task.itemType == 'vocab') {
      await (db.update(db.vocabularies)..where((x) => x.id.equals(task.itemId))).write(
        VocabulariesCompanion(status: Value(newStatus.toDbString())),
      );
    } else if (task.itemType == 'grammar') {
      await (db.update(db.grammars)..where((x) => x.id.equals(task.itemId))).write(
        GrammarsCompanion(status: Value(newStatus.toDbString())),
      );
    } else if (task.itemType == 'reading') {
      await (db.update(db.readings)..where((x) => x.id.equals(task.itemId))).write(
        ReadingsCompanion(status: Value(newStatus.toDbString())),
      );
    } else if (task.itemType == 'listening') {
      await (db.update(db.listenings)..where((x) => x.id.equals(task.itemId))).write(
        ListeningsCompanion(status: Value(newStatus.toDbString())),
      );
    }

    // 4. Auto schedule review!
    await autoScheduleReview(task.itemType, task.itemId, isCompleted);
  }

  @override
  Future<void> checkAndRedistributeMissedTasks() async {
    final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // Check if there are any uncompleted, non-review tasks from strictly before today
    final queryMissed = db.select(db.plannerTasks)
      ..where((t) => t.date.isSmallerThan(Variable(today)) & t.isCompleted.equals(false) & t.isReview.equals(false));
    final missedTasks = await queryMissed.get();

    if (missedTasks.isEmpty) return; // No missed tasks to redistribute!

    // Get active plan
    final plan = await getActiveStudyPlan();
    if (plan == null) return;

    // Get all uncompleted tasks in the entire database (both missed from past, and scheduled in future)
    final queryAllUncompleted = db.select(db.plannerTasks)
      ..where((t) => t.isCompleted.equals(false) & t.isReview.equals(false));
    final allUncompletedTasks = await queryAllUncompleted.get();

    final List<Map<String, String>> scheduleItems = allUncompletedTasks.map((t) => {
      'type': t.itemType,
      'id': t.itemId,
    }).toList();

    if (scheduleItems.isEmpty) return;

    // Delete all uncompleted tasks in the database
    await (db.delete(db.plannerTasks)..where((t) => t.isCompleted.equals(false))).go();

    // Calculate remaining study dates from today to targetDate
    final List<DateTime> studyDates = [];
    final List<DateTime> sundayReviewDates = [];

    DateTime current = today;
    final DateTime end = DateTime(plan.targetDate.year, plan.targetDate.month, plan.targetDate.day);

    while (!current.isAfter(end)) {
      if (current.weekday == DateTime.sunday) {
        sundayReviewDates.add(current);
      } else {
        studyDates.add(current);
      }
      current = current.add(const Duration(days: 1));
    }

    // Ensure review tasks exist for Sundays from today onwards (avoid double-inserting if one already exists)
    for (var sun in sundayReviewDates) {
      final existingReview = await (db.select(db.plannerTasks)
        ..where((t) => t.date.equals(sun) & t.isReview.equals(true))).getSingleOrNull();

      if (existingReview == null) {
        await db.into(db.plannerTasks).insert(PlannerTasksCompanion.insert(
          id: _uuid.v4(),
          date: sun,
          itemType: 'review',
          itemId: 'sunday_review',
          isCompleted: const Value(false),
          isReview: const Value(true),
        ));
      }
    }

    if (studyDates.isEmpty) return;

    // Distribute items round-robin across remaining study dates
    for (int i = 0; i < scheduleItems.length; i++) {
      final item = scheduleItems[i];
      final date = studyDates[i % studyDates.length];

      await db.into(db.plannerTasks).insert(PlannerTasksCompanion.insert(
        id: _uuid.v4(),
        date: date,
        itemType: item['type']!,
        itemId: item['id']!,
        isCompleted: const Value(false),
        isReview: const Value(false),
      ));
    }
  }

  @override
  Future<void> autoScheduleReview(String itemType, String itemId, bool isMastered) async {
    final query = db.select(db.reviewItems)..where((t) => t.itemType.equals(itemType) & t.itemId.equals(itemId));
    final existing = await query.getSingleOrNull();

    if (isMastered) {
      if (existing == null) {
        final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        await db.into(db.reviewItems).insert(ReviewItemsCompanion.insert(
          id: _uuid.v4(),
          itemType: itemType,
          itemId: itemId,
          stage: const Value(0),
          nextReviewDate: today.add(const Duration(days: 1)),
          lastReviewDate: today,
        ));
      }
    } else {
      if (existing != null) {
        await (db.delete(db.reviewItems)..where((t) => t.id.equals(existing.id))).go();
      }
    }
  }

  @override
  Future<void> submitReviewCompletion(String reviewId) async {
    final query = db.select(db.reviewItems)..where((t) => t.id.equals(reviewId));
    final review = await query.getSingleOrNull();
    if (review == null) return;

    final newStage = review.stage + 1;
    final intervals = [1, 3, 7, 14, 30, 90];

    DateTime nextDate;
    if (newStage >= 6) {
      nextDate = DateTime(3000, 1, 1); // fully reviewed
    } else {
      final int daysToAdd = intervals[newStage];
      final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      nextDate = today.add(Duration(days: daysToAdd));
    }

    await (db.update(db.reviewItems)..where((t) => t.id.equals(reviewId))).write(
      ReviewItemsCompanion(
        stage: Value(newStage),
        nextReviewDate: Value(nextDate),
        lastReviewDate: Value(DateTime.now()),
      ),
    );

    // Reward +5 XP and +1 Coin
    await addXpAndCoins(5, 1);
  }

  Future<List<ReviewItemEntity>> _resolveReviewEntities(List<ReviewItem> dbReviews) async {
    final List<ReviewItemEntity> entities = [];

    for (var r in dbReviews) {
      String title = '';
      String details = '';

      if (r.itemType == 'kanji') {
        final item = await (db.select(db.kanjis)..where((x) => x.id.equals(r.itemId))).getSingleOrNull();
        title = 'Review Kanji: ${item?.kanji ?? ""}';
        details = 'Meaning: ${item?.meaning ?? ""}';
      } else if (r.itemType == 'vocab') {
        final item = await (db.select(db.vocabularies)..where((x) => x.id.equals(r.itemId))).getSingleOrNull();
        title = 'Review Vocab: ${item?.word ?? ""}';
        details = 'Meaning: ${item?.meaning ?? ""}';
      } else if (r.itemType == 'grammar') {
        final item = await (db.select(db.grammars)..where((x) => x.id.equals(r.itemId))).getSingleOrNull();
        title = 'Review Grammar: ${item?.title ?? ""}';
        details = 'Explanation: ${item?.explanation ?? ""}';
      } else if (r.itemType == 'reading') {
        final item = await (db.select(db.readings)..where((x) => x.id.equals(r.itemId))).getSingleOrNull();
        title = 'Review Reading: ${item?.title ?? ""}';
        details = 'Question: ${item?.question ?? ""}';
      } else if (r.itemType == 'listening') {
        final item = await (db.select(db.listenings)..where((x) => x.id.equals(r.itemId))).getSingleOrNull();
        title = 'Review Listening: ${item?.title ?? ""}';
        details = 'Question: ${item?.question ?? ""}';
      }

      entities.add(ReviewItemEntity(
        id: r.id,
        itemType: r.itemType,
        itemId: r.itemId,
        stage: r.stage,
        nextReviewDate: r.nextReviewDate,
        lastReviewDate: r.lastReviewDate,
        title: title,
        details: details,
      ));
    }

    return entities;
  }

  @override
  Future<List<ReviewItemEntity>> getDueReviews(DateTime date) async {
    final DateTime dayStart = DateTime(date.year, date.month, date.day);
    final DateTime dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = db.select(db.reviewItems)
      ..where((t) => t.nextReviewDate.isBetweenValues(dayStart, dayEnd) & t.stage.isSmallerThan(const Variable(6)));
    final dbReviews = await query.get();

    return _resolveReviewEntities(dbReviews);
  }

  @override
  Future<List<ReviewItemEntity>> getMissedReviews(DateTime date) async {
    final DateTime dayStart = DateTime(date.year, date.month, date.day);

    final query = db.select(db.reviewItems)
      ..where((t) => t.nextReviewDate.isSmallerThan(Variable(dayStart)) & t.stage.isSmallerThan(const Variable(6)));
    final dbReviews = await query.get();

    return _resolveReviewEntities(dbReviews);
  }

  @override
  Future<List<ReviewItemEntity>> getUpcomingReviews(DateTime date) async {
    final DateTime dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = db.select(db.reviewItems)
      ..where((t) => t.nextReviewDate.isBiggerThan(Variable(dayEnd)) & t.stage.isSmallerThan(const Variable(6)));
    final dbReviews = await query.get();

    return _resolveReviewEntities(dbReviews);
  }

  @override
  Future<int> calculateLongestStreak() async {
    final list = await db.select(db.studySessions).get();
    if (list.isEmpty) return 0;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final Set<String> dateStrings = list.map((s) => formatter.format(s.date)).toSet();

    final List<DateTime> sortedDates = dateStrings.map((s) => formatter.parse(s)).toList()..sort();

    int longest = 0;
    int currentStreak = 0;
    DateTime? prevDate;

    for (var date in sortedDates) {
      if (prevDate == null) {
        currentStreak = 1;
      } else {
        final difference = date.difference(prevDate).inDays;
        if (difference == 1) {
          currentStreak++;
        } else if (difference > 1) {
          if (currentStreak > longest) {
            longest = currentStreak;
          }
          currentStreak = 1;
        }
      }
      prevDate = date;
    }

    if (currentStreak > longest) {
      longest = currentStreak;
    }

    return longest;
  }

  // --- GAMIFICATION HELPERS & METHODS ---

  String _getCurrentWeekId() {
    final today = DateTime.now();
    final firstDayOfYear = DateTime(today.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - 1;
    final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));
    final daysSinceFirstMonday = today.difference(firstMonday).inDays;
    final weekNumber = (daysSinceFirstMonday / 7).floor() + 1;
    return '${today.year}-W${weekNumber.toString().padLeft(2, '0')}';
  }

  Future<void> _onItemMastered(String id, String type) async {
    await addXpAndCoins(10, 2);
    final weekId = _getCurrentWeekId();
    await updateWeeklyGoalProgress(weekId, addItems: 1);
  }

  @override
  Future<UserStatsEntity> getUserStats() async {
    final query = db.select(db.userStats)..where((t) => t.id.equals('user'));
    var stats = await query.getSingleOrNull();

    if (stats == null) {
      await db.into(db.userStats).insert(UserStatsCompanion.insert(
        id: 'user',
        xp: const Value(0),
        coins: const Value(0),
      ));
      return const UserStatsEntity(id: 'user', xp: 0, coins: 0);
    }

    return UserStatsEntity(id: stats.id, xp: stats.xp, coins: stats.coins);
  }

  @override
  Future<void> addXpAndCoins(int xp, int coins) async {
    final current = await getUserStats();
    final newXp = current.xp + xp;
    final newCoins = current.coins + coins;

    await (db.update(db.userStats)..where((t) => t.id.equals('user'))).write(
      UserStatsCompanion(
        xp: Value(newXp),
        coins: Value(newCoins),
      ),
    );

    await checkAndUnlockAchievements();
  }

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    var list = await db.select(db.achievements).get();

    if (list.isEmpty) {
      final defaults = [
        const AchievementsCompanion(id: Value('first_lesson'), title: Value('First Step'), description: Value('Master your first N3 lesson'), xpReward: Value(50), coinReward: Value(10), isUnlocked: Value(false)),
        const AchievementsCompanion(id: Value('srs_level_1'), title: Value('Spaced Out'), description: Value('Complete your first spaced repetition review'), xpReward: Value(100), coinReward: Value(20), isUnlocked: Value(false)),
        const AchievementsCompanion(id: Value('streak_3'), title: Value('Habit Builder'), description: Value('Reach a 3-day study streak'), xpReward: Value(150), coinReward: Value(30), isUnlocked: Value(false)),
        const AchievementsCompanion(id: Value('streak_7'), title: Value('Dedicated Scholar'), description: Value('Reach a 7-day study streak'), xpReward: Value(300), coinReward: Value(50), isUnlocked: Value(false)),
        const AchievementsCompanion(id: Value('study_60'), title: Value('Deep Focus'), description: Value('Log 60 minutes of total study time'), xpReward: Value(250), coinReward: Value(40), isUnlocked: Value(false)),
      ];

      for (var d in defaults) {
        await db.into(db.achievements).insert(d);
      }
      list = await db.select(db.achievements).get();
    }

    return list.map((a) => AchievementEntity(
      id: a.id,
      title: a.title,
      description: a.description,
      xpReward: a.xpReward,
      coinReward: a.coinReward,
      isUnlocked: a.isUnlocked,
      unlockedAt: a.unlockedAt,
    )).toList();
  }

  @override
  Future<void> checkAndUnlockAchievements() async {
    final achievements = await getAchievements();

    Future<void> unlock(String id) async {
      final ach = achievements.firstWhere((a) => a.id == id);
      if (ach.isUnlocked) return;

      await (db.update(db.achievements)..where((t) => t.id.equals(id))).write(
        AchievementsCompanion(
          isUnlocked: const Value(true),
          unlockedAt: Value(DateTime.now()),
        ),
      );

      final stats = await getUserStats();
      await (db.update(db.userStats)..where((t) => t.id.equals('user'))).write(
        UserStatsCompanion(
          xp: Value(stats.xp + ach.xpReward),
          coins: Value(stats.coins + ach.coinReward),
        ),
      );
    }

    // 1. First Step (master first lesson)
    final masteredKanjis = await (db.select(db.kanjis)..where((x) => x.isLearned.equals(true))).get();
    final masteredVocabs = await (db.select(db.vocabularies)..where((x) => x.status.equals('mastered'))).get();
    final masteredGrammars = await (db.select(db.grammars)..where((x) => x.status.equals('mastered'))).get();
    final masteredReadings = await (db.select(db.readings)..where((x) => x.status.equals('mastered'))).get();
    final masteredListenings = await (db.select(db.listenings)..where((x) => x.status.equals('mastered'))).get();

    if (masteredKanjis.isNotEmpty || masteredVocabs.isNotEmpty || masteredGrammars.isNotEmpty || masteredReadings.isNotEmpty || masteredListenings.isNotEmpty) {
      await unlock('first_lesson');
    }

    // 2. Spaced Out (first SRS complete)
    final reviewsCompleted = await (db.select(db.reviewItems)..where((x) => x.stage.isBiggerThan(const Variable(0)))).get();
    if (reviewsCompleted.isNotEmpty) {
      await unlock('srs_level_1');
    }

    // 3. Streaks
    final currentStr = await calculateCurrentStreak();
    if (currentStr >= 3) {
      await unlock('streak_3');
    }
    if (currentStr >= 7) {
      await unlock('streak_7');
    }

    // 4. Deep Focus
    final sessionsList = await db.select(db.studySessions).get();
    final totalSecs = sessionsList.fold(0, (sum, s) => sum + s.durationSeconds);
    if (totalSecs >= 3600) {
      await unlock('study_60');
    }
  }

  @override
  Future<WeeklyGoalEntity> getOrCreateWeeklyGoal(String weekId) async {
    final query = db.select(db.weeklyGoals)..where((t) => t.id.equals(weekId));
    var goal = await query.getSingleOrNull();

    if (goal == null) {
      const targetSec = 5400; // 90 min
      const targetItm = 50;
      await db.into(db.weeklyGoals).insert(WeeklyGoalsCompanion.insert(
        id: weekId,
        targetSeconds: targetSec,
        targetItems: targetItm,
        completedSeconds: const Value(0),
        completedItems: const Value(0),
        isClaimed: const Value(false),
      ));
      return WeeklyGoalEntity(
        id: weekId,
        targetSeconds: targetSec,
        completedSeconds: 0,
        targetItems: targetItm,
        completedItems: 0,
        isClaimed: false,
      );
    }

    return WeeklyGoalEntity(
      id: goal.id,
      targetSeconds: goal.targetSeconds,
      completedSeconds: goal.completedSeconds,
      targetItems: goal.targetItems,
      completedItems: goal.completedItems,
      isClaimed: goal.isClaimed,
    );
  }

  @override
  Future<void> updateWeeklyGoalProgress(String weekId, {int? addSeconds, int? addItems}) async {
    final goal = await getOrCreateWeeklyGoal(weekId);
    final newSeconds = goal.completedSeconds + (addSeconds ?? 0);
    final newItems = goal.completedItems + (addItems ?? 0);

    await (db.update(db.weeklyGoals)..where((t) => t.id.equals(weekId))).write(
      WeeklyGoalsCompanion(
        completedSeconds: Value(newSeconds),
        completedItems: Value(newItems),
      ),
    );

    final wasCompletedBefore = goal.completedSeconds >= goal.targetSeconds && goal.completedItems >= goal.targetItems;
    final isCompletedNow = newSeconds >= goal.targetSeconds && newItems >= goal.targetItems;

    if (!wasCompletedBefore && isCompletedNow) {
      await addXpAndCoins(200, 50);
    }
  }

  @override
  Future<void> updateActivePlanHours(double hours) async {
    await (db.update(db.studyPlans)..where((t) => t.isActive.equals(true))).write(
      StudyPlansCompanion(availableHours: Value(hours)),
    );
  }

  @override
  Future<String> exportBackupJson() async {
    final kanjisData = await db.select(db.kanjis).get();
    final vocabsData = await db.select(db.vocabularies).get();
    final grammarsData = await db.select(db.grammars).get();
    final readingsData = await db.select(db.readings).get();
    final listeningsData = await db.select(db.listenings).get();
    final sessionsData = await db.select(db.studySessions).get();
    final goalsData = await db.select(db.dailyGoals).get();
    final reviewsData = await db.select(db.reviewItems).get();
    final statsData = await db.select(db.userStats).get();
    final achsData = await db.select(db.achievements).get();
    final weeklyGoalsData = await db.select(db.weeklyGoals).get();

    final data = {
      'kanjis': kanjisData.map((k) => {
        'id': k.id,
        'isLearned': k.isLearned,
        'reviewCount': k.reviewCount,
        'status': k.isLearned ? 'mastered' : (k.reviewCount > 0 ? 'learning' : 'unlearned')
      }).toList(),
      'vocabularies': vocabsData.map((v) => {'id': v.id, 'status': v.status}).toList(),
      'grammars': grammarsData.map((g) => {'id': g.id, 'status': g.status}).toList(),
      'readings': readingsData.map((r) => {'id': r.id, 'status': r.status, 'notes': r.notes}).toList(),
      'listenings': listeningsData.map((l) => {'id': l.id, 'status': l.status, 'notes': l.notes}).toList(),
      'studySessions': sessionsData.map((s) => {
        'id': s.id,
        'date': s.date.toIso8601String(),
        'durationSeconds': s.durationSeconds,
        'category': s.category,
      }).toList(),
      'dailyGoals': goalsData.map((dg) => {
        'id': dg.id,
        'targetSeconds': dg.targetSeconds,
        'completedSeconds': dg.completedSeconds,
        'targetItems': dg.targetItems,
        'completedItems': dg.completedItems,
      }).toList(),
      'reviewItems': reviewsData.map((ri) => {
        'id': ri.id,
        'itemType': ri.itemType,
        'itemId': ri.itemId,
        'stage': ri.stage,
        'nextReviewDate': ri.nextReviewDate.toIso8601String(),
        'lastReviewDate': ri.lastReviewDate.toIso8601String(),
      }).toList(),
      'userStats': statsData.map((us) => {
        'id': us.id,
        'xp': us.xp,
        'coins': us.coins,
      }).toList(),
      'achievements': achsData.map((a) => {
        'id': a.id,
        'title': a.title,
        'description': a.description,
        'xpReward': a.xpReward,
        'coinReward': a.coinReward,
        'isUnlocked': a.isUnlocked,
        'unlockedAt': a.unlockedAt?.toIso8601String(),
      }).toList(),
      'weeklyGoals': weeklyGoalsData.map((wg) => {
        'id': wg.id,
        'targetSeconds': wg.targetSeconds,
        'completedSeconds': wg.completedSeconds,
        'targetItems': wg.targetItems,
        'completedItems': wg.completedItems,
        'isClaimed': wg.isClaimed,
      }).toList(),
    };

    return jsonEncode(data);
  }

  @override
  Future<void> importBackupJson(String jsonStr) async {
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;

    await db.transaction(() async {
      // 1. Restore master items statuses
      if (data.containsKey('kanjis')) {
        for (var k in data['kanjis']) {
          final isLearned = k['isLearned'] ?? (k['status'] == 'mastered');
          final reviewCount = k['reviewCount'] ?? (k['status'] == 'learning' ? 1 : (k['status'] == 'mastered' ? 5 : 0));
          await (db.update(db.kanjis)..where((t) => t.id.equals(k['id']))).write(
            KanjisCompanion(
              isLearned: Value(isLearned),
              reviewCount: Value(reviewCount),
            ),
          );
        }
      }
      if (data.containsKey('vocabularies')) {
        for (var v in data['vocabularies']) {
          await (db.update(db.vocabularies)..where((t) => t.id.equals(v['id']))).write(
            VocabulariesCompanion(status: Value(v['status'])),
          );
        }
      }
      if (data.containsKey('grammars')) {
        for (var g in data['grammars']) {
          await (db.update(db.grammars)..where((t) => t.id.equals(g['id']))).write(
            GrammarsCompanion(status: Value(g['status'])),
          );
        }
      }
      if (data.containsKey('readings')) {
        for (var r in data['readings']) {
          await (db.update(db.readings)..where((t) => t.id.equals(r['id']))).write(
            ReadingsCompanion(status: Value(r['status']), notes: Value(r['notes'] ?? '')),
          );
        }
      }
      if (data.containsKey('listenings')) {
        for (var l in data['listenings']) {
          await (db.update(db.listenings)..where((t) => t.id.equals(l['id']))).write(
            ListeningsCompanion(status: Value(l['status']), notes: Value(l['notes'] ?? '')),
          );
        }
      }

      // 2. Clear tables that are fully user-generated
      await db.delete(db.studySessions).go();
      await db.delete(db.dailyGoals).go();
      await db.delete(db.reviewItems).go();
      await db.delete(db.userStats).go();
      await db.delete(db.achievements).go();
      await db.delete(db.weeklyGoals).go();

      // 3. Re-insert user-generated data
      if (data.containsKey('studySessions')) {
        for (var s in data['studySessions']) {
          await db.into(db.studySessions).insert(StudySessionsCompanion.insert(
            id: s['id'],
            date: DateTime.parse(s['date']),
            durationSeconds: s['durationSeconds'],
            category: s['category'],
          ));
        }
      }
      if (data.containsKey('dailyGoals')) {
        for (var dg in data['dailyGoals']) {
          await db.into(db.dailyGoals).insert(DailyGoalsCompanion.insert(
            id: dg['id'],
            targetSeconds: Value(dg['targetSeconds']),
            completedSeconds: Value(dg['completedSeconds']),
            targetItems: Value(dg['targetItems']),
            completedItems: Value(dg['completedItems']),
          ));
        }
      }
      if (data.containsKey('reviewItems')) {
        for (var ri in data['reviewItems']) {
          await db.into(db.reviewItems).insert(ReviewItemsCompanion.insert(
            id: ri['id'],
            itemType: ri['itemType'],
            itemId: ri['itemId'],
            stage: Value(ri['stage']),
            nextReviewDate: DateTime.parse(ri['nextReviewDate']),
            lastReviewDate: DateTime.parse(ri['lastReviewDate']),
          ));
        }
      }
      if (data.containsKey('userStats')) {
        for (var us in data['userStats']) {
          await db.into(db.userStats).insert(UserStatsCompanion.insert(
            id: us['id'],
            xp: Value(us['xp']),
            coins: Value(us['coins']),
          ));
        }
      }
      if (data.containsKey('achievements')) {
        for (var a in data['achievements']) {
          await db.into(db.achievements).insert(AchievementsCompanion.insert(
            id: a['id'],
            title: a['title'],
            description: a['description'],
            xpReward: a['xpReward'],
            coinReward: a['coinReward'],
            isUnlocked: Value(a['isUnlocked'] ?? false),
            unlockedAt: Value(a['unlockedAt'] != null ? DateTime.parse(a['unlockedAt']) : null),
          ));
        }
      }
      if (data.containsKey('weeklyGoals')) {
        for (var wg in data['weeklyGoals']) {
          await db.into(db.weeklyGoals).insert(WeeklyGoalsCompanion.insert(
            id: wg['id'],
            targetSeconds: wg['targetSeconds'],
            completedSeconds: Value(wg['completedSeconds']),
            targetItems: wg['targetItems'],
            completedItems: Value(wg['completedItems']),
            isClaimed: Value(wg['isClaimed']),
          ));
        }
      }
    });
  }
}
