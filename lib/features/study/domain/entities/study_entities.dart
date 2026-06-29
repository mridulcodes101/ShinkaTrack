import 'dart:convert';

/// Represents the study status of any N3 item.
enum StudyStatus {
  unlearned,
  learning,
  mastered;

  static StudyStatus fromString(String val) {
    switch (val) {
      case 'learning':
        return StudyStatus.learning;
      case 'mastered':
        return StudyStatus.mastered;
      default:
        return StudyStatus.unlearned;
    }
  }

  String toDbString() => name;
}

class KanjiEntity {
  final String id;
  final String kanji;
  final List<String> kunYomi;
  final List<String> onYomi;
  final String meaning;
  final String radicals;
  final int strokeCount;
  final String? strokeOrderDiagramPath;
  final int jlptLevel;
  final int? gradeLevel;
  final String unicode;
  final String notes;
  final List<String> examples;
  final bool isLearned;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastReviewed;
  final int reviewCount;
  final double easeFactor;
  final DateTime? nextReview;

  const KanjiEntity({
    required this.id,
    required this.kanji,
    required this.kunYomi,
    required this.onYomi,
    required this.meaning,
    required this.radicals,
    required this.strokeCount,
    this.strokeOrderDiagramPath,
    required this.jlptLevel,
    this.gradeLevel,
    required this.unicode,
    required this.notes,
    required this.examples,
    required this.isLearned,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
    this.lastReviewed,
    required this.reviewCount,
    required this.easeFactor,
    this.nextReview,
  });

  // Compatibility getters to keep other UI/widgets clean and functional
  String get character => kanji;
  String get onyomi => onYomi.isEmpty ? '-' : onYomi.join(', ');
  String get kunyomi => kunYomi.isEmpty ? '-' : kunYomi.join(', ');
  StudyStatus get status {
    if (isLearned) return StudyStatus.mastered;
    if (reviewCount > 0) return StudyStatus.learning;
    return StudyStatus.unlearned;
  }

  KanjiEntity copyWith({
    String? id,
    String? kanji,
    List<String>? kunYomi,
    List<String>? onYomi,
    String? meaning,
    String? radicals,
    int? strokeCount,
    String? strokeOrderDiagramPath,
    int? jlptLevel,
    int? gradeLevel,
    String? unicode,
    String? notes,
    List<String>? examples,
    bool? isLearned,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastReviewed,
    int? reviewCount,
    double? easeFactor,
    DateTime? nextReview,
  }) {
    return KanjiEntity(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      kunYomi: kunYomi ?? this.kunYomi,
      onYomi: onYomi ?? this.onYomi,
      meaning: meaning ?? this.meaning,
      radicals: radicals ?? this.radicals,
      strokeCount: strokeCount ?? this.strokeCount,
      strokeOrderDiagramPath: strokeOrderDiagramPath ?? this.strokeOrderDiagramPath,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      unicode: unicode ?? this.unicode,
      notes: notes ?? this.notes,
      examples: examples ?? this.examples,
      isLearned: isLearned ?? this.isLearned,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      reviewCount: reviewCount ?? this.reviewCount,
      easeFactor: easeFactor ?? this.easeFactor,
      nextReview: nextReview ?? this.nextReview,
    );
  }
}

class VocabularyEntity {
  final String id;
  final String word;
  final String reading;
  final String meaning;
  final StudyStatus status;

  const VocabularyEntity({
    required this.id,
    required this.word,
    required this.reading,
    required this.meaning,
    required this.status,
  });

  VocabularyEntity copyWith({StudyStatus? status}) {
    return VocabularyEntity(
      id: id,
      word: word,
      reading: reading,
      meaning: meaning,
      status: status ?? this.status,
    );
  }
}

class GrammarExample {
  final String japanese;
  final String english;

  const GrammarExample({required this.japanese, required this.english});

  factory GrammarExample.fromMap(Map<String, dynamic> map) {
    return GrammarExample(
      japanese: map['jp'] ?? '',
      english: map['en'] ?? '',
    );
  }
}

class GrammarEntity {
  final String id;
  final String title;
  final String explanation;
  final String structure;
  final List<GrammarExample> examples;
  final StudyStatus status;

  const GrammarEntity({
    required this.id,
    required this.title,
    required this.explanation,
    required this.structure,
    required this.examples,
    required this.status,
  });

  factory GrammarEntity.fromDb({
    required String id,
    required String title,
    required String explanation,
    required String structure,
    required String examplesJson,
    required StudyStatus status,
  }) {
    final List<dynamic> decoded = jsonDecode(examplesJson);
    final examples = decoded
        .map((e) => GrammarExample.fromMap(e as Map<String, dynamic>))
        .toList();
    return GrammarEntity(
      id: id,
      title: title,
      explanation: explanation,
      structure: structure,
      examples: examples,
      status: status,
    );
  }

  GrammarEntity copyWith({StudyStatus? status}) {
    return GrammarEntity(
      id: id,
      title: title,
      explanation: explanation,
      structure: structure,
      examples: examples,
      status: status ?? this.status,
    );
  }
}

class StudySessionEntity {
  final String id;
  final DateTime date;
  final int durationSeconds;
  final String category;

  const StudySessionEntity({
    required this.id,
    required this.date,
    required this.durationSeconds,
    required this.category,
  });
}

class DailyGoalEntity {
  final String id; // Format: YYYY-MM-DD
  final int targetSeconds;
  final int completedSeconds;
  final int targetItems;
  final int completedItems;

  const DailyGoalEntity({
    required this.id,
    required this.targetSeconds,
    required this.completedSeconds,
    required this.targetItems,
    required this.completedItems,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String type; // kanji, vocab, grammar
  final String targetId; // Reference to the target item

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.type,
    required this.targetId,
  });
}

class ReadingEntity {
  final String id;
  final String title;
  final String passage;
  final String question;
  final String answer;
  final String explanation;
  final String notes;
  final StudyStatus status;

  const ReadingEntity({
    required this.id,
    required this.title,
    required this.passage,
    required this.question,
    required this.answer,
    required this.explanation,
    required this.notes,
    required this.status,
  });

  ReadingEntity copyWith({StudyStatus? status, String? notes}) {
    return ReadingEntity(
      id: id,
      title: title,
      passage: passage,
      question: question,
      answer: answer,
      explanation: explanation,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}

class ListeningEntity {
  final String id;
  final String title;
  final String audioScript;
  final String question;
  final String answer;
  final String explanation;
  final String notes;
  final StudyStatus status;

  const ListeningEntity({
    required this.id,
    required this.title,
    required this.audioScript,
    required this.question,
    required this.answer,
    required this.explanation,
    required this.notes,
    required this.status,
  });

  ListeningEntity copyWith({StudyStatus? status, String? notes}) {
    return ListeningEntity(
      id: id,
      title: title,
      audioScript: audioScript,
      question: question,
      answer: answer,
      explanation: explanation,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
