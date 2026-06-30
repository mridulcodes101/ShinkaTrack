class VocabularySpec {
  // Required standard fields
  final String id;
  final String word;
  final String kana;
  final String meaning;
  final int jlpt;
  final String partOfSpeech;
  final int frequency;
  final List<String> kanjiUsed; // list of Kanji IDs used in this vocabulary
  final List<String> relatedGrammar; // list of grammar pattern IDs related to this vocabulary
  final List<String> synonyms;
  final List<String> antonyms;
  final List<String> exampleSentences;
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
  final String? pitchAccent;
  final String? audio;
  final String? image;
  final String? mnemonic;
  final String? personalNotes;

  // Future Extensibility fields
  final String? aiNotes;

  const VocabularySpec({
    required this.id,
    required this.word,
    required this.kana,
    required this.meaning,
    required this.jlpt,
    required this.partOfSpeech,
    required this.frequency,
    required this.kanjiUsed,
    required this.relatedGrammar,
    required this.synonyms,
    required this.antonyms,
    required this.exampleSentences,
    required this.tags,
    required this.difficulty,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'Published',
    required this.schemaVersion,
    required this.contentVersion,
    required this.lastUpdated,
    this.pitchAccent,
    this.audio,
    this.image,
    this.mnemonic,
    this.personalNotes,
    this.aiNotes,
  });

  factory VocabularySpec.fromJson(Map<String, dynamic> json) {
    return VocabularySpec(
      id: json['id']?.toString() ?? '',
      word: json['word']?.toString() ?? '',
      kana: json['kana']?.toString() ?? json['reading']?.toString() ?? '',
      meaning: json['meaning']?.toString() ?? '',
      jlpt: _parseInt(json['jlpt'] ?? json['jlptLevel'] ?? json['jlpt_level']),
      partOfSpeech: json['partOfSpeech'] ?? json['part_of_speech'] ?? json['pos'] ?? '',
      frequency: _parseInt(json['frequency'] ?? json['frequencyRank'] ?? json['frequency_rank']),
      kanjiUsed: _parseList(json['kanjiUsed'] ?? json['kanji_used'] ?? json['kanjis']),
      relatedGrammar: _parseList(json['relatedGrammar'] ?? json['related_grammar'] ?? json['grammars']),
      synonyms: _parseList(json['synonyms']),
      antonyms: _parseList(json['antonyms']),
      exampleSentences: _parseList(json['exampleSentences'] ?? json['example_sentences'] ?? json['examples']),
      tags: _parseList(json['tags']),
      difficulty: _parseDouble(json['difficulty']),
      createdAt: _parseDate(json['createdAt'] ?? json['created_at'] ?? json['created']),
      updatedAt: _parseDate(json['updatedAt'] ?? json['updated_at'] ?? json['updated']),
      status: json['status']?.toString() ?? 'Published',
      schemaVersion: _parseInt(json['schemaVersion'] ?? json['schema_version'] ?? 1),
      contentVersion: _parseInt(json['contentVersion'] ?? json['content_version'] ?? 1),
      lastUpdated: _parseDate(json['lastUpdated'] ?? json['last_updated'] ?? json['updated_at'] ?? json['updated']),
      pitchAccent: json['pitchAccent'] ?? json['pitch_accent'],
      audio: json['audio']?.toString(),
      image: json['image']?.toString(),
      mnemonic: json['mnemonic']?.toString(),
      personalNotes: json['personalNotes'] ?? json['personal_notes'] ?? json['notes'],
      aiNotes: json['aiNotes'] ?? json['ai_notes'],
    );
  }

  factory VocabularySpec.fromCsv(List<dynamic> row, Map<String, int> mapping) {
    dynamic getVal(String key) {
      final index = mapping[key];
      if (index == null || index >= row.length) return null;
      return row[index];
    }

    return VocabularySpec(
      id: getVal('id')?.toString() ?? '',
      word: getVal('word')?.toString() ?? '',
      kana: getVal('kana')?.toString() ?? getVal('reading')?.toString() ?? '',
      meaning: getVal('meaning')?.toString() ?? '',
      jlpt: _parseInt(getVal('jlpt')),
      partOfSpeech: getVal('partOfSpeech')?.toString() ?? getVal('pos')?.toString() ?? '',
      frequency: _parseInt(getVal('frequency')),
      kanjiUsed: _parseList(getVal('kanjiUsed') ?? getVal('kanjis')),
      relatedGrammar: _parseList(getVal('relatedGrammar') ?? getVal('grammars')),
      synonyms: _parseList(getVal('synonyms')),
      antonyms: _parseList(getVal('antonyms')),
      exampleSentences: _parseList(getVal('exampleSentences') ?? getVal('examples')),
      tags: _parseList(getVal('tags')),
      difficulty: _parseDouble(getVal('difficulty')),
      createdAt: _parseDate(getVal('createdAt') ?? getVal('created')),
      updatedAt: _parseDate(getVal('updatedAt') ?? getVal('updated')),
      status: getVal('status')?.toString() ?? 'Published',
      schemaVersion: _parseInt(getVal('schemaVersion')) == 0 ? 1 : _parseInt(getVal('schemaVersion')),
      contentVersion: _parseInt(getVal('contentVersion')) == 0 ? 1 : _parseInt(getVal('contentVersion')),
      lastUpdated: _parseDate(getVal('lastUpdated') ?? getVal('updated')),
      pitchAccent: getVal('pitchAccent')?.toString(),
      audio: getVal('audio')?.toString(),
      image: getVal('image')?.toString(),
      mnemonic: getVal('mnemonic')?.toString(),
      personalNotes: getVal('personalNotes')?.toString() ?? getVal('notes')?.toString(),
      aiNotes: getVal('aiNotes')?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'kana': kana,
      'meaning': meaning,
      'jlpt': jlpt,
      'partOfSpeech': partOfSpeech,
      'frequency': frequency,
      'kanjiUsed': kanjiUsed,
      'relatedGrammar': relatedGrammar,
      'synonyms': synonyms,
      'antonyms': antonyms,
      'exampleSentences': exampleSentences,
      'tags': tags,
      'difficulty': difficulty,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'schemaVersion': schemaVersion,
      'contentVersion': contentVersion,
      'lastUpdated': lastUpdated.toIso8601String(),
      if (pitchAccent != null) 'pitchAccent': pitchAccent,
      if (audio != null) 'audio': audio,
      if (image != null) 'image': image,
      if (mnemonic != null) 'mnemonic': mnemonic,
      if (personalNotes != null) 'personalNotes': personalNotes,
      if (aiNotes != null) 'aiNotes': aiNotes,
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
