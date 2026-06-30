import 'dart:convert';

class ReadingQuestionSpec {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const ReadingQuestionSpec({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });

  factory ReadingQuestionSpec.fromJson(Map<String, dynamic> json) {
    return ReadingQuestionSpec(
      id: json['id']?.toString() ?? '',
      questionText: json['questionText']?.toString() ?? json['question']?.toString() ?? '',
      options: (json['options'] as List?)?.map((e) => e.toString()).toList() ?? [],
      correctOptionIndex: _parseInt(json['correctOptionIndex'] ?? json['correctIndex'] ?? json['correct_option_index']),
      explanation: json['explanation']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
    };
  }

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is num) return val.toInt();
    return int.tryParse(val.toString().trim()) ?? 0;
  }
}

class ReadingSpec {
  // Required standard fields
  final String id;
  final String title;
  final int jlpt;
  final double difficulty;
  final int estimatedReadingTime;
  final String passage;
  final String translation;
  final List<String> vocabularyReferences; // list of vocabulary IDs
  final List<String> grammarReferences; // list of grammar pattern IDs
  final List<String> kanjiReferences; // list of Kanji IDs
  final List<ReadingQuestionSpec> questions;
  final List<String> answers;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Versioning standard fields
  final int schemaVersion;
  final int contentVersion;
  final DateTime lastUpdated;

  // Optional fields
  final String? audio;
  final List<String>? images;
  final String? notes;

  const ReadingSpec({
    required this.id,
    required this.title,
    required this.jlpt,
    required this.difficulty,
    required this.estimatedReadingTime,
    required this.passage,
    required this.translation,
    required this.vocabularyReferences,
    required this.grammarReferences,
    required this.kanjiReferences,
    required this.questions,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
    required this.schemaVersion,
    required this.contentVersion,
    required this.lastUpdated,
    this.audio,
    this.images,
    this.notes,
  });

  factory ReadingSpec.fromJson(Map<String, dynamic> json) {
    return ReadingSpec(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      jlpt: _parseInt(json['jlpt'] ?? json['jlptLevel'] ?? json['jlpt_level']),
      difficulty: _parseDouble(json['difficulty']),
      estimatedReadingTime: _parseInt(json['estimatedReadingTime'] ?? json['estimated_reading_time'] ?? json['reading_time']),
      passage: json['passage']?.toString() ?? '',
      translation: json['translation']?.toString() ?? '',
      vocabularyReferences: _parseList(json['vocabularyReferences'] ?? json['vocabulary_references'] ?? json['vocabs']),
      grammarReferences: _parseList(json['grammarReferences'] ?? json['grammar_references'] ?? json['grammars']),
      kanjiReferences: _parseList(json['kanjiReferences'] ?? json['kanji_references'] ?? json['kanjis']),
      questions: _parseQuestions(json['questions']),
      answers: _parseList(json['answers'] ?? json['correct_answers']),
      createdAt: _parseDate(json['createdAt'] ?? json['created_at'] ?? json['created']),
      updatedAt: _parseDate(json['updatedAt'] ?? json['updated_at'] ?? json['updated']),
      schemaVersion: _parseInt(json['schemaVersion'] ?? json['schema_version'] ?? 1),
      contentVersion: _parseInt(json['contentVersion'] ?? json['content_version'] ?? 1),
      lastUpdated: _parseDate(json['lastUpdated'] ?? json['last_updated'] ?? json['updated_at'] ?? json['updated']),
      audio: json['audio']?.toString(),
      images: json['images'] != null ? _parseList(json['images']) : null,
      notes: json['notes']?.toString(),
    );
  }

  factory ReadingSpec.fromCsv(List<dynamic> row, Map<String, int> mapping) {
    dynamic getVal(String key) {
      final index = mapping[key];
      if (index == null || index >= row.length) return null;
      return row[index];
    }

    return ReadingSpec(
      id: getVal('id')?.toString() ?? '',
      title: getVal('title')?.toString() ?? '',
      jlpt: _parseInt(getVal('jlpt')),
      difficulty: _parseDouble(getVal('difficulty')),
      estimatedReadingTime: _parseInt(getVal('estimatedReadingTime') ?? getVal('reading_time')),
      passage: getVal('passage')?.toString() ?? '',
      translation: getVal('translation')?.toString() ?? '',
      vocabularyReferences: _parseList(getVal('vocabularyReferences') ?? getVal('vocabs')),
      grammarReferences: _parseList(getVal('grammarReferences') ?? getVal('grammars')),
      kanjiReferences: _parseList(getVal('kanjiReferences') ?? getVal('kanjis')),
      questions: _parseQuestions(getVal('questions')),
      answers: _parseList(getVal('answers')),
      createdAt: _parseDate(getVal('createdAt') ?? getVal('created')),
      updatedAt: _parseDate(getVal('updatedAt') ?? getVal('updated')),
      schemaVersion: _parseInt(getVal('schemaVersion')) == 0 ? 1 : _parseInt(getVal('schemaVersion')),
      contentVersion: _parseInt(getVal('contentVersion')) == 0 ? 1 : _parseInt(getVal('contentVersion')),
      lastUpdated: _parseDate(getVal('lastUpdated') ?? getVal('updated')),
      audio: getVal('audio')?.toString(),
      images: getVal('images') != null ? _parseList(getVal('images')) : null,
      notes: getVal('notes')?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'jlpt': jlpt,
      'difficulty': difficulty,
      'estimatedReadingTime': estimatedReadingTime,
      'passage': passage,
      'translation': translation,
      'vocabularyReferences': vocabularyReferences,
      'grammarReferences': grammarReferences,
      'kanjiReferences': kanjiReferences,
      'questions': questions.map((q) => q.toJson()).toList(),
      'answers': answers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'schemaVersion': schemaVersion,
      'contentVersion': contentVersion,
      'lastUpdated': lastUpdated.toIso8601String(),
      if (audio != null) 'audio': audio,
      if (images != null) 'images': images,
      if (notes != null) 'notes': notes,
    };
  }

  List<dynamic> toCsvRow(List<String> headers) {
    final Map<String, dynamic> data = toJson();
    return headers.map((header) {
      final val = data[header];
      if (val is List) {
        if (header == 'questions') {
          return jsonEncode(val);
        }
        return val.join(';');
      }
      return val ?? '';
    }).toList();
  }

  // Helper parsing methods
  static List<ReadingQuestionSpec> _parseQuestions(dynamic val) {
    if (val == null) return [];
    if (val is List) {
      return val.map((e) => ReadingQuestionSpec.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    if (val is String && val.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(val);
        if (decoded is List) {
          return decoded.map((e) => ReadingQuestionSpec.fromJson(Map<String, dynamic>.from(e))).toList();
        }
      } catch (_) {}
    }
    return [];
  }

  static List<String> _parseList(dynamic val) {
    if (val == null) return [];
    if (val is List) return val.map((e) => e.toString().trim()).toList();
    if (val is String) {
      if (val.trim().isEmpty) return [];
      if (val.contains(';')) {
        return val.split(';').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      if (val.contains(',')) {
        return val.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      return [val.trim()];
    }
    return [val.toString().trim()];
  }

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is num) return val.toInt();
    return int.tryParse(val.toString().trim()) ?? 0;
  }

  static double _parseDouble(dynamic val) {
    if (val == null) return 0.0;
    if (val is num) return val.toDouble();
    return double.tryParse(val.toString().trim()) ?? 0.0;
  }

  static DateTime _parseDate(dynamic val) {
    if (val == null) return DateTime.now();
    if (val is String) {
      return DateTime.tryParse(val.trim()) ?? DateTime.now();
    }
    return DateTime.now();
  }
}
