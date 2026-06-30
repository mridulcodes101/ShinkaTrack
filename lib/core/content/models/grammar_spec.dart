import 'dart:convert';

class GrammarExampleSpec {
  final String japanese;
  final String english;

  const GrammarExampleSpec({
    required this.japanese,
    required this.english,
  });

  factory GrammarExampleSpec.fromJson(Map<String, dynamic> json) {
    return GrammarExampleSpec(
      japanese: json['japanese']?.toString() ?? json['jp']?.toString() ?? '',
      english: json['english']?.toString() ?? json['en']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'japanese': japanese,
      'english': english,
    };
  }
}

class GrammarMistakeSpec {
  final String incorrect;
  final String correct;
  final String explanation;

  const GrammarMistakeSpec({
    required this.incorrect,
    required this.correct,
    required this.explanation,
  });

  factory GrammarMistakeSpec.fromJson(Map<String, dynamic> json) {
    return GrammarMistakeSpec(
      incorrect: json['incorrect']?.toString() ?? json['bad']?.toString() ?? '',
      correct: json['correct']?.toString() ?? json['good']?.toString() ?? '',
      explanation: json['explanation']?.toString() ?? json['reason']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'incorrect': incorrect,
      'correct': correct,
      'explanation': explanation,
    };
  }
}

class GrammarSpec {
  // Required standard fields
  final String id;
  final String grammarPattern;
  final String meaning;
  final String formation;
  final String usage;
  final String nuance;
  final String formalLevel;
  final int jlpt;
  final List<GrammarExampleSpec> examples;
  final List<GrammarMistakeSpec> commonMistakes;
  final List<String> relatedGrammar; // list of grammar pattern IDs
  final List<String> relatedVocabulary; // list of vocab IDs
  final List<String> relatedKanji; // list of Kanji IDs
  final double difficulty;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Versioning standard fields
  final int schemaVersion;
  final int contentVersion;
  final DateTime lastUpdated;

  // Optional fields
  final String? memoryTips;
  final String? audio;
  final String? video;

  // Future Extensibility fields
  final String? aiExplanation;

  const GrammarSpec({
    required this.id,
    required this.grammarPattern,
    required this.meaning,
    required this.formation,
    required this.usage,
    required this.nuance,
    required this.formalLevel,
    required this.jlpt,
    required this.examples,
    required this.commonMistakes,
    required this.relatedGrammar,
    required this.relatedVocabulary,
    required this.relatedKanji,
    required this.difficulty,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.schemaVersion,
    required this.contentVersion,
    required this.lastUpdated,
    this.memoryTips,
    this.audio,
    this.video,
    this.aiExplanation,
  });

  factory GrammarSpec.fromJson(Map<String, dynamic> json) {
    return GrammarSpec(
      id: json['id']?.toString() ?? '',
      grammarPattern: json['grammarPattern']?.toString() ?? json['pattern']?.toString() ?? json['grammar_pattern'] ?? '',
      meaning: json['meaning']?.toString() ?? json['explanation']?.toString() ?? '',
      formation: json['formation']?.toString() ?? json['structure']?.toString() ?? '',
      usage: json['usage']?.toString() ?? '',
      nuance: json['nuance']?.toString() ?? '',
      formalLevel: json['formalLevel'] ?? json['formal_level'] ?? json['formality'] ?? '',
      jlpt: _parseInt(json['jlpt'] ?? json['jlptLevel'] ?? json['jlpt_level']),
      examples: _parseExamples(json['examples']),
      commonMistakes: _parseMistakes(json['commonMistakes'] ?? json['common_mistakes']),
      relatedGrammar: _parseList(json['relatedGrammar'] ?? json['related_grammar']),
      relatedVocabulary: _parseList(json['relatedVocabulary'] ?? json['related_vocabulary'] ?? json['vocabs']),
      relatedKanji: _parseList(json['relatedKanji'] ?? json['related_kanji'] ?? json['kanjis']),
      difficulty: _parseDouble(json['difficulty']),
      tags: _parseList(json['tags']),
      createdAt: _parseDate(json['createdAt'] ?? json['created_at'] ?? json['created']),
      updatedAt: _parseDate(json['updatedAt'] ?? json['updated_at'] ?? json['updated']),
      schemaVersion: _parseInt(json['schemaVersion'] ?? json['schema_version'] ?? 1),
      contentVersion: _parseInt(json['contentVersion'] ?? json['content_version'] ?? 1),
      lastUpdated: _parseDate(json['lastUpdated'] ?? json['last_updated'] ?? json['updated_at'] ?? json['updated']),
      memoryTips: json['memoryTips'] ?? json['memory_tips'] ?? json['tips'],
      audio: json['audio']?.toString(),
      video: json['video']?.toString(),
      aiExplanation: json['aiExplanation'] ?? json['ai_explanation'],
    );
  }

  factory GrammarSpec.fromCsv(List<dynamic> row, Map<String, int> mapping) {
    dynamic getVal(String key) {
      final index = mapping[key];
      if (index == null || index >= row.length) return null;
      return row[index];
    }

    return GrammarSpec(
      id: getVal('id')?.toString() ?? '',
      grammarPattern: getVal('grammarPattern')?.toString() ?? getVal('pattern')?.toString() ?? '',
      meaning: getVal('meaning')?.toString() ?? getVal('explanation')?.toString() ?? '',
      formation: getVal('formation')?.toString() ?? getVal('structure')?.toString() ?? '',
      usage: getVal('usage')?.toString() ?? '',
      nuance: getVal('nuance')?.toString() ?? '',
      formalLevel: getVal('formalLevel')?.toString() ?? '',
      jlpt: _parseInt(getVal('jlpt')),
      examples: _parseExamples(getVal('examples')),
      commonMistakes: _parseMistakes(getVal('commonMistakes') ?? getVal('common_mistakes')),
      relatedGrammar: _parseList(getVal('relatedGrammar')),
      relatedVocabulary: _parseList(getVal('relatedVocabulary') ?? getVal('vocabs')),
      relatedKanji: _parseList(getVal('relatedKanji') ?? getVal('kanjis')),
      difficulty: _parseDouble(getVal('difficulty')),
      tags: _parseList(getVal('tags')),
      createdAt: _parseDate(getVal('createdAt') ?? getVal('created')),
      updatedAt: _parseDate(getVal('updatedAt') ?? getVal('updated')),
      schemaVersion: _parseInt(getVal('schemaVersion')) == 0 ? 1 : _parseInt(getVal('schemaVersion')),
      contentVersion: _parseInt(getVal('contentVersion')) == 0 ? 1 : _parseInt(getVal('contentVersion')),
      lastUpdated: _parseDate(getVal('lastUpdated') ?? getVal('updated')),
      memoryTips: getVal('memoryTips')?.toString() ?? getVal('tips')?.toString(),
      audio: getVal('audio')?.toString(),
      video: getVal('video')?.toString(),
      aiExplanation: getVal('aiExplanation')?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grammarPattern': grammarPattern,
      'meaning': meaning,
      'formation': formation,
      'usage': usage,
      'nuance': nuance,
      'formalLevel': formalLevel,
      'jlpt': jlpt,
      'examples': examples.map((e) => e.toJson()).toList(),
      'commonMistakes': commonMistakes.map((e) => e.toJson()).toList(),
      'relatedGrammar': relatedGrammar,
      'relatedVocabulary': relatedVocabulary,
      'relatedKanji': relatedKanji,
      'difficulty': difficulty,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'schemaVersion': schemaVersion,
      'contentVersion': contentVersion,
      'lastUpdated': lastUpdated.toIso8601String(),
      if (memoryTips != null) 'memoryTips': memoryTips,
      if (audio != null) 'audio': audio,
      if (video != null) 'video': video,
      if (aiExplanation != null) 'aiExplanation': aiExplanation,
    };
  }

  List<dynamic> toCsvRow(List<String> headers) {
    final Map<String, dynamic> data = toJson();
    return headers.map((header) {
      final val = data[header];
      if (val is List) {
        if (header == 'examples' || header == 'commonMistakes') {
          return jsonEncode(val);
        }
        return val.join(';');
      }
      return val ?? '';
    }).toList();
  }

  // Helper parsing methods
  static List<GrammarExampleSpec> _parseExamples(dynamic val) {
    if (val == null) return [];
    if (val is List) {
      return val.map((e) => GrammarExampleSpec.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    if (val is String && val.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(val);
        if (decoded is List) {
          return decoded.map((e) => GrammarExampleSpec.fromJson(Map<String, dynamic>.from(e))).toList();
        }
      } catch (_) {}
    }
    return [];
  }

  static List<GrammarMistakeSpec> _parseMistakes(dynamic val) {
    if (val == null) return [];
    if (val is List) {
      return val.map((e) => GrammarMistakeSpec.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    if (val is String && val.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(val);
        if (decoded is List) {
          return decoded.map((e) => GrammarMistakeSpec.fromJson(Map<String, dynamic>.from(e))).toList();
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
