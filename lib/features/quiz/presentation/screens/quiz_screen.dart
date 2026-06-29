import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  bool _quizStarted = false;
  bool _quizFinished = false;
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  bool _answerSubmitted = false;
  int _correctCount = 0;
  String _selectedQuizType = 'all'; // all, kanji, vocab, grammar

  // --- GENERATING THE QUIZ QUESTIONS ---

  void _generateQuiz(
    List<KanjiEntity> kanjis,
    List<VocabularyEntity> vocabs,
    List<GrammarEntity> grammars,
  ) {
    if (_selectedQuizType == 'kanji' && kanjis.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your Kanji Collection is empty. Add Kanji in the Study tab first!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final Random random = Random();
    final List<QuizQuestion> generatedQuestions = [];

    var activeKanjis = kanjis.where((k) => k.status != StudyStatus.unlearned).toList();
    var activeVocabs = vocabs.where((v) => v.status != StudyStatus.unlearned).toList();
    var activeGrammars = grammars.where((g) => g.status != StudyStatus.unlearned).toList();

    if (activeKanjis.isEmpty) activeKanjis = kanjis;
    if (activeVocabs.isEmpty) activeVocabs = vocabs;
    if (activeGrammars.isEmpty) activeGrammars = grammars;

    List<String> poolTypes = [];
    if (_selectedQuizType == 'all') {
      if (kanjis.isNotEmpty) poolTypes.add('kanji');
      if (vocabs.isNotEmpty) poolTypes.add('vocab');
      if (grammars.isNotEmpty) poolTypes.add('grammar');
      if (poolTypes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No study items found in catalog.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    } else {
      poolTypes = [_selectedQuizType];
    }

    const int questionLimit = 5;

    for (int i = 0; i < questionLimit; i++) {
      final type = poolTypes[random.nextInt(poolTypes.length)];

      if (type == 'kanji' && activeKanjis.isNotEmpty) {
        final target = activeKanjis[random.nextInt(activeKanjis.length)];
        final correctAns = target.meaning;

        final List<String> dist = kanjis
            .where((k) => k.id != target.id)
            .map((k) => k.meaning)
            .toSet()
            .toList();
        dist.shuffle(random);
        final options = [
          correctAns,
          if (dist.isNotEmpty) dist[0],
          if (dist.length > 1) dist[1],
          if (dist.length > 2) dist[2],
        ];
        options.shuffle(random);

        generatedQuestions.add(QuizQuestion(
          question: 'What is the meaning of this Kanji?\n\n"${target.character}"',
          options: options,
          correctAnswer: correctAns,
          explanation: 'Kanji: ${target.character}\nOnyomi: ${target.onyomi}\nKunyomi: ${target.kunyomi}\nMeaning: ${target.meaning}',
          type: 'kanji',
          targetId: target.id,
        ));
      } else if (type == 'vocab' && activeVocabs.isNotEmpty) {
        final target = activeVocabs[random.nextInt(activeVocabs.length)];
        final correctAns = target.meaning;

        final List<String> dist = vocabs
            .where((v) => v.id != target.id)
            .map((v) => v.meaning)
            .toSet()
            .toList();
        dist.shuffle(random);
        final options = [
          correctAns,
          if (dist.isNotEmpty) dist[0],
          if (dist.length > 1) dist[1],
          if (dist.length > 2) dist[2],
        ];
        options.shuffle(random);

        generatedQuestions.add(QuizQuestion(
          question: 'What is the meaning of this vocabulary word?\n\n"${target.word}" (${target.reading})',
          options: options,
          correctAnswer: correctAns,
          explanation: 'Word: ${target.word} (${target.reading})\nMeaning: ${target.meaning}',
          type: 'vocab',
          targetId: target.id,
        ));
      } else if (type == 'grammar' && activeGrammars.isNotEmpty) {
        final target = activeGrammars[random.nextInt(activeGrammars.length)];
        final correctAns = target.explanation;

        final List<String> dist = grammars
            .where((g) => g.id != target.id)
            .map((g) => g.explanation)
            .toSet()
            .toList();
        dist.shuffle(random);
        final options = [
          correctAns,
          if (dist.isNotEmpty) dist[0],
          if (dist.length > 1) dist[1],
          if (dist.length > 2) dist[2],
        ];
        options.shuffle(random);

        String prompt = 'What does this grammar structure express?\n\n"${target.title}"';
        if (target.examples.isNotEmpty) {
          prompt = 'Based on the grammar "${target.title}", what does this sentence express?\n\n"${target.examples[0].japanese}"';
        }

        generatedQuestions.add(QuizQuestion(
          question: prompt,
          options: options,
          correctAnswer: correctAns,
          explanation: 'Grammar: ${target.title}\nStructure: ${target.structure}\nExplanation: ${target.explanation}',
          type: 'grammar',
          targetId: target.id,
        ));
      }
    }

    setState(() {
      _questions = generatedQuestions;
      _quizStarted = true;
      _quizFinished = false;
      _currentQuestionIndex = 0;
      _selectedOption = null;
      _answerSubmitted = false;
      _correctCount = 0;
    });
  }

  // --- ACTIONS ---

  void _submitAnswer() {
    if (_selectedOption == null || _answerSubmitted) return;

    final q = _questions[_currentQuestionIndex];
    final bool isCorrect = _selectedOption == q.correctAnswer;

    setState(() {
      _answerSubmitted = true;
      if (isCorrect) {
        _correctCount++;
      }
    });

    // Play feedback using Duolingo-style bottom sheet panel
    _showDuolingoFeedbackSheet(isCorrect, q);
  }

  Future<void> _nextQuestion() async {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
        _answerSubmitted = false;
      });
    } else {
      setState(() {
        _quizFinished = true;
      });

      final repo = ref.read(repositoryProvider);
      await repo.saveQuizResult(_correctCount, _questions.length, _selectedQuizType);

      if (_correctCount > 0) {
        await ref.read(dailyGoalProvider.notifier).addProgress(items: _correctCount);
      }
    }
  }

  // --- DUOLINGO-STYLE SLIDE FEEDBACK SHEET ---

  void _showDuolingoFeedbackSheet(bool isCorrect, QuizQuestion q) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        final Color panelColor = isCorrect
            ? (isDark ? const Color(0xFF064E3B) : const Color(0xFFD1FAE5))
            : (isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2));

        final Color textColor = isCorrect
            ? (isDark ? const Color(0xFF34D399) : const Color(0xFF065F46))
            : (isDark ? const Color(0xFFF87171) : const Color(0xFF991B1B));

        final String title = isCorrect
            ? (isCorrectJapanesePhrase())
            : 'Oops! Correct answer below:';

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: textColor,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Explanation
              Text(
                isCorrect ? q.explanation : 'Correct: ${q.correctAnswer}\n\n${q.explanation}',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _nextQuestion();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCorrect ? Colors.green : Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('CONTINUE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
              ),
            ],
          ),
        );
      },
    );
  }

  String isCorrectJapanesePhrase() {
    final phrases = ['素晴らしい! (Excellent!)', '正解! (Correct!)', 'よくできました! (Well done!)', 'すごい! (Amazing!)'];
    return phrases[Random().nextInt(phrases.length)];
  }

  // --- LAYOUT BUILDERS ---

  @override
  Widget build(BuildContext context) {
    final kanjiAsync = ref.watch(kanjiListProvider);
    final vocabAsync = ref.watch(vocabListProvider);
    final grammarAsync = ref.watch(grammarListProvider);

    final bool dataLoaded = kanjiAsync.hasValue && vocabAsync.hasValue && grammarAsync.hasValue;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Evolution Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: !dataLoaded
                ? const CircularProgressIndicator()
                : !_quizStarted
                    ? _buildSetupScreen(
                        kanjiAsync.value ?? [],
                        vocabAsync.value ?? [],
                        grammarAsync.value ?? [],
                      )
                    : _quizFinished
                        ? _buildSummaryScreen()
                        : _buildQuestionScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildSetupScreen(
    List<KanjiEntity> kanjis,
    List<VocabularyEntity> vocabs,
    List<GrammarEntity> grammars,
  ) {
    final activeCount = kanjis.where((k) => k.status != StudyStatus.unlearned).length +
        vocabs.where((v) => v.status != StudyStatus.unlearned).length +
        grammars.where((g) => g.status != StudyStatus.unlearned).length;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: PremiumDesignSystem.secondaryPink.withValues(alpha: 0.12),
          child: const Icon(Icons.psychology, size: 48, color: PremiumDesignSystem.secondaryPink),
        ),
        const SizedBox(height: 24),
        const Text(
          'Quiz Space',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        Text(
          'Quiz is generated from items you are currently learning to strengthen retention.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.outline, height: 1.3),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: activeCount > 0
                ? PremiumDesignSystem.forestEmerald.withValues(alpha: 0.1)
                : Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: activeCount > 0
                  ? PremiumDesignSystem.forestEmerald.withValues(alpha: 0.2)
                  : Colors.amber.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                activeCount > 0 ? Icons.check_circle_outline : Icons.info_outline,
                color: activeCount > 0 ? PremiumDesignSystem.forestEmerald : Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                activeCount > 0
                    ? '$activeCount active items ready for review.'
                    : 'No active items. Using entire catalog.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: activeCount > 0 ? PremiumDesignSystem.forestEmerald : Colors.amber[800],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        const Text(
          'Select Quiz Topic',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: -0.2),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCategoryChip('all', 'Mixed'),
            const SizedBox(width: 8),
            _buildCategoryChip('kanji', 'Kanji'),
            const SizedBox(width: 8),
            _buildCategoryChip('vocab', 'Vocab'),
            const SizedBox(width: 8),
            _buildCategoryChip('grammar', 'Grammar'),
          ],
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () => _generateQuiz(kanjis, vocabs, grammars),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text('Start Quiz', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String type, String label) {
    final isSelected = _selectedQuizType == type;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedQuizType = type;
          });
        }
      },
    );
  }

  Widget _buildQuestionScreen() {
    final q = _questions[_currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Duolingo-style Progress indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'QUESTION ${_currentQuestionIndex + 1}/${_questions.length}',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.5, color: Colors.grey),
            ),
            Text(
              'SCORE: $_correctCount',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.5, color: PremiumDesignSystem.primaryBlue),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            minHeight: 8,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
          ),
        ),
        const SizedBox(height: 36),
        // Question Box
        GlassCard(
          child: SizedBox(
            width: double.infinity,
            child: Text(
              q.question,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, height: 1.4, letterSpacing: -0.3),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Options List
        ...q.options.map((opt) => _buildOptionRow(opt, q)),
        const Spacer(),
        if (!_answerSubmitted)
          ElevatedButton(
            onPressed: _selectedOption == null ? null : _submitAnswer,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text('SUBMIT', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOptionRow(String opt, QuizQuestion q) {
    final bool isSelected = _selectedOption == opt;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color cardBorderColor = isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFE2E8F0);
    Color cardBgColor = isDark ? PremiumDesignSystem.surfaceDark : Colors.white;

    if (isSelected) {
      cardBorderColor = PremiumDesignSystem.primaryBlue;
      cardBgColor = PremiumDesignSystem.primaryBlue.withValues(alpha: 0.08);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AnimatedScale(
        scale: isSelected ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: InkWell(
          onTap: _answerSubmitted
              ? null
              : () {
                  setState(() {
                    _selectedOption = opt;
                  });
                },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cardBorderColor, width: 2),
              boxShadow: isSelected ? [] : PremiumDesignSystem.premiumShadow,
            ),
            child: Text(
              opt,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? PremiumDesignSystem.primaryBlue : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryScreen() {
    final percentage = (_correctCount / _questions.length * 100).toInt();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: PremiumDesignSystem.amberGold.withValues(alpha: 0.12),
          child: const Icon(Icons.workspace_premium, size: 54, color: PremiumDesignSystem.amberGold),
        ),
        const SizedBox(height: 28),
        const Text(
          'Quiz Finished!',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        const SizedBox(height: 16),
        Text(
          'Score: $_correctCount / ${_questions.length} ($percentage%)',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          percentage >= 80
              ? 'Excellent performance! You gained points toward your daily evolution goal!'
              : 'Keep pushing! Daily practice makes perfect.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.outline, height: 1.3),
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _quizStarted = false;
              _quizFinished = false;
            });
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text('Practice Again', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to Dashboard'),
        ),
      ],
    );
  }
}
