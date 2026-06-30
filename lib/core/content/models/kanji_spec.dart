import 'dart:convert';

class KanjiSpec {
  // Required standard fields
  final String id;
  final String character;
  final String unicode;
  final String meaning;
  final List<String> onyomi;
  final List<String> kunyomi;
  final int jlptLevel;
  final int gradeLevel;
  final int strokeCount;
  final String radicals;
  final String primaryRadical;
  final int frequencyRank;
  final String joyoStatus;
  final List<String> exampleWords;
  final List<String> exampleSentences;
  final List<String> relatedKanji; // list of related Kanji IDs
  final List<String> tags;
  final double difficulty;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status; // Published, Draft, Archived

  // Versioning standard fields
  final int schemaVersion;
  final int contentVersion;
  final DateTime lastUpdated;

  // Optional fields
  final String? mnemonic;
  final String? personalNotes;
  final String? image;
  final String? svgStrokeOrder;
  final String? animatedStrokeData;
  final String? audio;
  final List<String>? pitchAccentExamples;

  // Future Extensibility fields
  final String? writingPracticeData;
  final String? handwritingRecognitionData;
  final String? aiExplanation;

  const KanjiSpec({
    required this.id,
    required this.character,
    required this.unicode,
    required this.meaning,
    required this.onyomi,
    required this.kunyomi,
    required this.jlptLevel,
    required this.gradeLevel,
    required this.strokeCount,
    required this.radicals,
    required this.primaryRadical,
    required this.frequencyRank,
    required this.joyoStatus,
    required this.exampleWords,
    required this.exampleSentences,
    required this.relatedKanji,
    required this.tags,
    required this.difficulty,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'Published',
    required this.schemaVersion,
    required this.contentVersion,
    required this.lastUpdated,
    this.mnemonic,
    this.personalNotes,
    this.image,
    this.svgStrokeOrder,
    this.animatedStrokeData,
    this.audio,
    this.pitchAccentExamples,
    this.writingPracticeData,
    this.handwritingRecognitionData,
    this.aiExplanation,
  });

  factory KanjiSpec.fromJson(Map<String, dynamic> json) {
    return KanjiSpec(
      id: json['id']?.toString() ?? '',
      character: json['character']?.toString() ?? json['kanji']?.toString() ?? '',
      unicode: json['unicode']?.toString() ?? '',
      meaning: json['meaning']?.toString() ?? '',
      onyomi: _parseList(json['onyomi']),
      kunyomi: _parseList(json['kunyomi']),
      jlptLevel: _parseInt(json['jlptLevel'] ?? json['jlpt_level'] ?? json['jlpt']),
      gradeLevel: _parseInt(json['gradeLevel'] ?? json['grade_level'] ?? json['grade']),
      strokeCount: _parseInt(json['strokeCount'] ?? json['stroke_count'] ?? json['strokes']),
      radicals: json['radicals']?.toString() ?? '',
      primaryRadical: json['primaryRadical'] ?? json['primary_radical'] ?? '',
      frequencyRank: _parseInt(json['frequencyRank'] ?? json['frequency_rank'] ?? json['frequency']),
      joyoStatus: json['joyoStatus'] ?? json['joyo_status'] ?? '',
      exampleWords: _parseList(json['exampleWords'] ?? json['example_words'] ?? json['examples']),
      exampleSentences: _parseList(json['exampleSentences'] ?? json['example_sentences']),
      relatedKanji: _parseList(json['relatedKanji'] ?? json['related_kanji']),
      tags: _parseList(json['tags']),
      difficulty: _parseDouble(json['difficulty']),
      createdAt: _parseDate(json['createdAt'] ?? json['created_at'] ?? json['created']),
      updatedAt: _parseDate(json['updatedAt'] ?? json['updated_at'] ?? json['updated']),
      status: json['status']?.toString() ?? 'Published',
      schemaVersion: _parseInt(json['schemaVersion'] ?? json['schema_version'] ?? 1),
      contentVersion: _parseInt(json['contentVersion'] ?? json['content_version'] ?? 1),
      lastUpdated: _parseDate(json['lastUpdated'] ?? json['last_updated'] ?? json['updated_at'] ?? json['updated']),
      mnemonic: json['mnemonic']?.toString(),
      personalNotes: json['personalNotes'] ?? json['personal_notes'] ?? json['notes'],
      image: json['image']?.toString(),
      svgStrokeOrder: json['svgStrokeOrder'] ?? json['svg_stroke_order'],
      animatedStrokeData: json['animatedStrokeData'] ?? json['animated_stroke_data'],
      audio: json['audio']?.toString(),
      pitchAccentExamples: json['pitchAccentExamples'] != null ? _parseList(json['pitchAccentExamples']) : null,
      writingPracticeData: json['writingPracticeData'] ?? json['writing_practice_data'],
      handwritingRecognitionData: json['handwritingRecognitionData'] ?? json['handwriting_recognition_data'],
      aiExplanation: json['aiExplanation'] ?? json['ai_explanation'],
    );
  }

  factory KanjiSpec.fromCsv(List<dynamic> row, Map<String, int> mapping) {
    dynamic getVal(String key) {
      final index = mapping[key];
      if (index == null || index >= row.length) return null;
      return row[index];
    }

    return KanjiSpec(
      id: getVal('id')?.toString() ?? '',
      character: getVal('character')?.toString() ?? getVal('kanji')?.toString() ?? '',
      unicode: getVal('unicode')?.toString() ?? '',
      meaning: getVal('meaning')?.toString() ?? '',
      onyomi: _parseList(getVal('onyomi')),
      kunyomi: _parseList(getVal('kunyomi')),
      jlptLevel: _parseInt(getVal('jlptLevel') ?? getVal('jlpt')),
      gradeLevel: _parseInt(getVal('gradeLevel') ?? getVal('grade')),
      strokeCount: _parseInt(getVal('strokeCount') ?? getVal('strokes')),
      radicals: getVal('radicals')?.toString() ?? '',
      primaryRadical: getVal('primaryRadical')?.toString() ?? '',
      frequencyRank: _parseInt(getVal('frequencyRank') ?? getVal('frequency')),
      joyoStatus: getVal('joyoStatus')?.toString() ?? '',
      exampleWords: _parseList(getVal('exampleWords') ?? getVal('examples')),
      exampleSentences: _parseList(getVal('exampleSentences')),
      relatedKanji: _parseList(getVal('relatedKanji')),
      tags: _parseList(getVal('tags')),
      difficulty: _parseDouble(getVal('difficulty')),
      createdAt: _parseDate(getVal('createdAt') ?? getVal('created')),
      updatedAt: _parseDate(getVal('updatedAt') ?? getVal('updated')),
      status: getVal('status')?.toString() ?? 'Published',
      schemaVersion: _parseInt(getVal('schemaVersion')) == 0 ? 1 : _parseInt(getVal('schemaVersion')),
      contentVersion: _parseInt(getVal('contentVersion')) == 0 ? 1 : _parseInt(getVal('contentVersion')),
      lastUpdated: _parseDate(getVal('lastUpdated') ?? getVal('updated')),
      mnemonic: getVal('mnemonic')?.toString(),
      personalNotes: getVal('personalNotes')?.toString() ?? getVal('notes')?.toString(),
      image: getVal('image')?.toString(),
      svgStrokeOrder: getVal('svgStrokeOrder')?.toString(),
      animatedStrokeData: getVal('animatedStrokeData')?.toString(),
      audio: getVal('audio')?.toString(),
      pitchAccentExamples: getVal('pitchAccentExamples') != null ? _parseList(getVal('pitchAccentExamples')) : null,
      writingPracticeData: getVal('writingPracticeData')?.toString(),
      handwritingRecognitionData: getVal('handwritingRecognitionData')?.toString(),
      aiExplanation: getVal('aiExplanation')?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'character': character,
      'unicode': unicode,
      'meaning': meaning,
      'onyomi': onyomi,
      'kunyomi': kunyomi,
      'jlptLevel': jlptLevel,
      'gradeLevel': gradeLevel,
      'strokeCount': strokeCount,
      'radicals': radicals,
      'primaryRadical': primaryRadical,
      'frequencyRank': frequencyRank,
      'joyoStatus': joyoStatus,
      'exampleWords': exampleWords,
      'exampleSentences': exampleSentences,
      'relatedKanji': relatedKanji,
      'tags': tags,
      'difficulty': difficulty,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'schemaVersion': schemaVersion,
      'contentVersion': contentVersion,
      'lastUpdated': lastUpdated.toIso8601String(),
      if (mnemonic != null) 'mnemonic': mnemonic,
      if (personalNotes != null) 'personalNotes': personalNotes,
      if (image != null) 'image': image,
      if (svgStrokeOrder != null) 'svgStrokeOrder': svgStrokeOrder,
      if (animatedStrokeData != null) 'animatedStrokeData': animatedStrokeData,
      if (audio != null) 'audio': audio,
      if (pitchAccentExamples != null) 'pitchAccentExamples': pitchAccentExamples,
      if (writingPracticeData != null) 'writingPracticeData': writingPracticeData,
      if (handwritingRecognitionData != null) 'handwritingRecognitionData': handwritingRecognitionData,
      if (aiExplanation != null) 'aiExplanation': aiExplanation,
    };
  }

  List<dynamic> toCsvRow(List<String> headers) {
    final Map<String, dynamic> data = toJson();
    return headers.map((header) {
      final val = data[header];
      if (val is List) return val.join(';');
      return val ?? '';
    }).toList();
  }

  // Helper parsing methods
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
