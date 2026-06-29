import 'dart:convert';
import 'package:drift/drift.dart';
import 'connection.dart';

part 'database.g.dart';

// --- TABLE DEFINITIONS ---

@TableIndex(name: 'idx_kanjis_kanji', columns: {#kanji})
@TableIndex(name: 'idx_kanjis_learned', columns: {#isLearned})
@TableIndex(name: 'idx_kanjis_favorite', columns: {#isFavorite})
@TableIndex(name: 'idx_kanjis_next_review', columns: {#nextReview})
class Kanjis extends Table {
  TextColumn get id => text()();
  TextColumn get kanji => text()();
  TextColumn get kunYomi => text()(); // JSON List<String>
  TextColumn get onYomi => text()();  // JSON List<String>
  TextColumn get meaning => text()();
  TextColumn get radicals => text()();
  IntColumn get strokeCount => integer()();
  TextColumn get strokeOrderDiagramPath => text().nullable()();
  IntColumn get jlptLevel => integer()();
  IntColumn get gradeLevel => integer().nullable()();
  TextColumn get unicode => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get examples => text().withDefault(const Constant('[]'))(); // JSON List<String>
  BoolColumn get isLearned => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastReviewed => dateTime().nullable()();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();
  DateTimeColumn get nextReview => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Vocabularies extends Table {
  TextColumn get id => text()();
  TextColumn get word => text()();
  TextColumn get reading => text()();
  TextColumn get meaning => text()();
  TextColumn get status => text().withDefault(const Constant('unlearned'))(); // unlearned, learning, mastered

  @override
  Set<Column> get primaryKey => {id};
}

class Grammars extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get explanation => text()();
  TextColumn get structure => text()();
  TextColumn get examplesJson => text()(); // JSON list of examples: [{"jp": "...", "en": "..."}]
  TextColumn get status => text().withDefault(const Constant('unlearned'))(); // unlearned, learning, mastered

  @override
  Set<Column> get primaryKey => {id};
}

class StudySessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get durationSeconds => integer()();
  TextColumn get category => text()(); // kanji, vocabulary, grammar

  @override
  Set<Column> get primaryKey => {id};
}

class DailyGoals extends Table {
  TextColumn get id => text()(); // Format: YYYY-MM-DD
  IntColumn get targetSeconds => integer().withDefault(const Constant(900))(); // default 15 mins
  IntColumn get completedSeconds => integer().withDefault(const Constant(0))();
  IntColumn get targetItems => integer().withDefault(const Constant(10))(); // default 10 cards
  IntColumn get completedItems => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class QuizResults extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get correctCount => integer()();
  IntColumn get totalCount => integer()();
  TextColumn get quizType => text()(); // kanji, vocabulary, grammar

  @override
  Set<Column> get primaryKey => {id};
}

class Readings extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get passage => text()();
  TextColumn get question => text()();
  TextColumn get answer => text()();
  TextColumn get explanation => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('unlearned'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Listenings extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get audioScript => text()();
  TextColumn get question => text()();
  TextColumn get answer => text()();
  TextColumn get explanation => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('unlearned'))();

  @override
  Set<Column> get primaryKey => {id};
}

class StudyPlans extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get targetDate => dateTime()();
  RealColumn get availableHours => real()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_planner_tasks_date', columns: {#date})
class PlannerTasks extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get itemType => text()(); // kanji, vocab, grammar, reading, listening
  TextColumn get itemId => text()(); // ID of target item
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isReview => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_review_items_next_review', columns: {#nextReviewDate, #stage})
class ReviewItems extends Table {
  TextColumn get id => text()();
  TextColumn get itemType => text()(); // kanji, vocab, grammar, reading, listening
  TextColumn get itemId => text()();
  IntColumn get stage => integer().withDefault(const Constant(0))(); // 0 to 6
  DateTimeColumn get nextReviewDate => dateTime()();
  DateTimeColumn get lastReviewDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserStats extends Table {
  TextColumn get id => text()(); // "user"
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get coins => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Achievements extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get xpReward => integer()();
  IntColumn get coinReward => integer()();
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WeeklyGoals extends Table {
  TextColumn get id => text()(); // "yyyy-Www"
  IntColumn get targetSeconds => integer()();
  IntColumn get completedSeconds => integer().withDefault(const Constant(0))();
  IntColumn get targetItems => integer()();
  IntColumn get completedItems => integer().withDefault(const Constant(0))();
  BoolColumn get isClaimed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// --- DATABASE CLASS ---

@DriftDatabase(tables: [Kanjis, Vocabularies, Grammars, StudySessions, DailyGoals, QuizResults, Readings, Listenings, StudyPlans, PlannerTasks, ReviewItems, UserStats, Achievements, WeeklyGoals])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedDatabase();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        final List<Map<String, dynamic>> oldKanjis = [];
        try {
          final rows = await customSelect('SELECT id, character, onyomi, kunyomi, meaning, status FROM kanjis;').get();
          for (var r in rows) {
            oldKanjis.add({
              'id': r.read<String>('id'),
              'character': r.read<String>('character'),
              'onyomi': r.read<String>('onyomi'),
              'kunyomi': r.read<String>('kunyomi'),
              'meaning': r.read<String>('meaning'),
              'status': r.read<String>('status'),
            });
          }
        } catch (e) {
          // Ignore if old table does not exist or structure mismatch
        }

        await m.drop(kanjis);
        await m.create(kanjis);

        for (var old in oldKanjis) {
          final onyomiList = (old['onyomi'] as String).split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();
          final kunyomiList = (old['kunyomi'] as String).split(RegExp(r'[,、\s]+')).where((s) => s.isNotEmpty).toList();
          final status = old['status'] as String;

          await into(kanjis).insert(
            KanjisCompanion.insert(
              id: old['id'] as String,
              kanji: old['character'] as String,
              kunYomi: jsonEncode(kunyomiList),
              onYomi: jsonEncode(onyomiList),
              meaning: old['meaning'] as String,
              radicals: '-',
              strokeCount: 0,
              jlptLevel: 3,
              unicode: '',
              isLearned: Value(status == 'mastered'),
              reviewCount: Value(status == 'learning' ? 1 : (status == 'mastered' ? 5 : 0)),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
        }
      }
    },
  );

  Future<void> _seedDatabase() async {
    // --- Vocabulary Seeds ---
    final vocabSeeds = [
      {'id': 'v1', 'word': '諦める', 'reading': 'あきらめる', 'meaning': 'To give up, to abandon hope', 'status': 'unlearned'},
      {'id': 'v2', 'word': '謝る', 'reading': 'あやまる', 'meaning': 'To apologize', 'status': 'unlearned'},
      {'id': 'v3', 'word': '怒る', 'reading': 'おこる', 'meaning': 'To get angry, to be mad', 'status': 'unlearned'},
      {'id': 'v4', 'word': '驚く', 'reading': 'おどろく', 'meaning': 'To be surprised, to be astonished', 'status': 'unlearned'},
      {'id': 'v5', 'word': '飾る', 'reading': 'かざる', 'meaning': 'To decorate, to ornament', 'status': 'unlearned'},
      {'id': 'v6', 'word': '乾く', 'reading': 'かわく', 'meaning': 'To get dry', 'status': 'unlearned'},
      {'id': 'v7', 'word': '暮らす', 'reading': 'くらす', 'meaning': 'To live, to spend time', 'status': 'unlearned'},
      {'id': 'v8', 'word': '込む', 'reading': 'こむ', 'meaning': 'To be crowded, to be packed', 'status': 'unlearned'},
      {'id': 'v9', 'word': '断る', 'reading': 'ことわる', 'meaning': 'To refuse, to decline', 'status': 'unlearned'},
      {'id': 'v10', 'word': '準備', 'reading': 'じゅんび', 'meaning': 'Preparation, arrangements', 'status': 'unlearned'},
      {'id': 'v11', 'word': '紹介', 'reading': 'しょうかい', 'meaning': 'Introduction', 'status': 'unlearned'},
      {'id': 'v12', 'word': '相談', 'reading': 'そうだん', 'meaning': 'Consultation, discussion', 'status': 'unlearned'},
      {'id': 'v13', 'word': '適当', 'reading': 'てきとう', 'meaning': 'Suitable, appropriate, random', 'status': 'unlearned'},
      {'id': 'v14', 'word': '複雑', 'reading': 'ふくざつ', 'meaning': 'Complexity, complication', 'status': 'unlearned'},
      {'id': 'v15', 'word': '独身', 'reading': 'どくしん', 'meaning': 'Single, unmarried', 'status': 'unlearned'},
    ];

    for (var seed in vocabSeeds) {
      await into(vocabularies).insert(VocabulariesCompanion.insert(
        id: seed['id'] as String,
        word: seed['word'] as String,
        reading: seed['reading'] as String,
        meaning: seed['meaning'] as String,
        status: Value(seed['status'] as String),
      ));
    }

    // --- Grammar Seeds ---
    final grammarSeeds = [
      {
        'id': 'g1',
        'title': 'に対して (ni taishite)',
        'explanation': 'Towards, regarding, in contrast to. Used to indicate a target of an action/attitude, or to contrast two entities.',
        'structure': 'Noun + に対して / Verb (dictionary/casual form) + のに対して',
        'examples': jsonEncode([
          {'jp': '先生に対して失礼なことを言ってはいけません。', 'en': 'You must not speak rudely to the teacher.'},
          {'jp': '兄が活動的なのに対して、弟は家で読書をするのが好きだ。', 'en': 'While the older brother is active, the younger brother likes to read at home.'}
        ]),
        'status': 'unlearned'
      },
      {
        'id': 'g2',
        'title': '反面 (hanmen)',
        'explanation': 'On the other hand, although. Expresses two contrasting aspects of the same state or action.',
        'structure': 'Verb casual + 反面 / Noun + である反面',
        'examples': jsonEncode([
          {'jp': '一人暮らしは自由な反面、寂しさも感じる。', 'en': 'Living alone is free, but on the other hand, you also feel lonely.'},
          {'jp': 'このスマホは高価な反面、機能がとても優れている。', 'en': 'Although this smartphone is expensive, its features are excellent.'}
        ]),
        'status': 'unlearned'
      },
      {
        'id': 'g3',
        'title': 'さえ〜ば (sae... ba)',
        'explanation': 'If only..., as long as... Highlights the single necessary condition that, once met, guarantees the outcome.',
        'structure': 'Noun + さえ + Verb (conditional/ba form) / Verb stem + さえすれば',
        'examples': jsonEncode([
          {'jp': '薬を飲みさえすれば、病気は治ります。', 'en': 'As long as you take the medicine, you will recover.'},
          {'jp': 'お金さえあれば、何でも買えるわけではない。', 'en': 'Just because you have money doesn\'t mean you can buy anything.'}
        ]),
        'status': 'unlearned'
      },
      {
        'id': 'g4',
        'title': 'わけにはいかない (wake ni wa ikanai)',
        'explanation': 'Cannot afford to, must not. Indicates that societal rules, moral obligation, or common sense prevents someone from doing an action.',
        'structure': 'Verb (dictionary form) + わけにはいかない',
        'examples': jsonEncode([
          {'jp': '明日は大事な試験があるから、休むわけにはいかない。', 'en': 'Because there is an important exam tomorrow, I cannot afford to take a day off.'},
          {'jp': 'お世話になった人に、嘘をつくわけにはいかない。', 'en': 'I cannot lie to someone who has taken care of me.'}
        ]),
        'status': 'unlearned'
      },
      {
        'id': 'g5',
        'title': 'うちに (uchi ni)',
        'explanation': 'While, before. Doing something while the current state lasts, or a change occurring without the speaker noticing.',
        'structure': 'Noun + のうちに / Verb + ているうちに / Adj + うちに',
        'examples': jsonEncode([
          {'jp': '桜が綺麗なうちに、お花見に行きましょう。', 'en': 'Let\'s go cherry blossom viewing while the cherry blossoms are still beautiful.'},
          {'jp': '話し合っているうちに、問題が解決しました。', 'en': 'While we were discussing, the problem was solved.'}
        ]),
        'status': 'unlearned'
      }
    ];

    for (var seed in grammarSeeds) {
      await into(grammars).insert(GrammarsCompanion.insert(
        id: seed['id'] as String,
        title: seed['title'] as String,
        explanation: seed['explanation'] as String,
        structure: seed['structure'] as String,
        examplesJson: seed['examples'] as String,
        status: Value(seed['status'] as String),
      ));
    }

    // --- Reading Seeds ---
    final readingSeeds = [
      {
        'id': 'r1',
        'title': 'お茶の文化 (Tea Culture)',
        'passage': '日本では、お茶はただの飲み物ではなく、長い歴史と深い文化を持っています。特に「茶道」は、お茶を点てる作法だけでなく、客をもてなす心や精神的な静けさを重んじる芸術です。現代でも多くの人が趣味として茶道を学んでいます。',
        'question': 'What does Sado (茶道) emphasize?',
        'answer': 'It values hospitality and mental tranquility as an art form.',
        'explanation': 'The passage states that Sado values hospitality (客をもてなす心) and mental tranquility (精神的な静けさ) as an art.',
        'status': 'unlearned'
      },
      {
        'id': 'r2',
        'title': '自転車のルール (Bicycle Rules)',
        'passage': '近年、日本国内で自転車の事故が増加しています。そのため、ルールが厳しくなっています。例えば、原則として自転車は歩道ではなく車道の左側を走らなければなりません。また、傘を差し長らの運転や、携帯電話を使いながらの運転は禁止されており、違反すると罰金が科されます。',
        'question': 'Where should bicycles be ridden on Japanese streets?',
        'answer': 'On the left side of the roadway, not on the sidewalks.',
        'explanation': 'The passage explicitly states that bicycles must run on the left side of the roadway (車道の左側), not on sidewalks.',
        'status': 'unlearned'
      }
    ];

    for (var seed in readingSeeds) {
      await into(readings).insert(ReadingsCompanion.insert(
        id: seed['id']!,
        title: seed['title']!,
        passage: seed['passage']!,
        question: seed['question']!,
        answer: seed['answer']!,
        explanation: seed['explanation']!,
        status: Value(seed['status']!),
      ));
    }

    // --- Listening Seeds ---
    final listeningSeeds = [
      {
        'id': 'l1',
        'title': 'オフィスの依頼 (Office Task)',
        'audioScript': '男の人と女の人が話しています。女の人はこれから何をしますか？\n男：「佐藤さん、この会議の資料、30部コピーしてくれる？」\n女：「はい、わかりました。そのあと、会議室の準備もしましょうか？」\n男：「準備は鈴木くんがやってくれているから大丈夫。コピーができたらプロジェクターの電源が入るかチェックしておいて。」\n女：「承知いたしました。」',
        'question': 'What will the woman do first?',
        'answer': 'Copy the conference materials.',
        'explanation': 'The man asks her to make 30 copies first, then check the projector power.',
        'status': 'unlearned'
      },
      {
        'id': 'l2',
        'title': '駅への道順 (Directions to Station)',
        'audioScript': '道で女の人と警察官が話しています。女の人はどの角を曲がりますか？\n女：「すみません、桜駅へはどう行けばいいですか？」\n警官：「ここをまっすぐ行って、最初の信号を渡ってください。そのあと、二つ目の角を右に曲がると、目の前に駅が見えますよ。」\n女：「最初の信号を渡って、二つ目の角を右ですね。ありがとうございます。」',
        'question': 'Which corner must the woman turn at?',
        'answer': 'The second corner on the right after crossing the traffic light.',
        'explanation': 'The policeman directs her to cross the first traffic light, and then turn right at the second corner.',
        'status': 'unlearned'
      }
    ];

    for (var seed in listeningSeeds) {
      await into(listenings).insert(ListeningsCompanion.insert(
        id: seed['id']!,
        title: seed['title']!,
        audioScript: seed['audioScript']!,
        question: seed['question']!,
        answer: seed['answer']!,
        explanation: seed['explanation']!,
        status: Value(seed['status']!),
      ));
    }
  }
}
