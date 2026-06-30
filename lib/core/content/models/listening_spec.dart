import 'dart:convert';

class ListeningSpec {
  // Required standard fields
  final String id;
  final String title;
  final int jlpt;
  final double difficulty;
  final String transcript; // script/transcript of the audio
  final String translation; // English translation of the script
  final List<String> vocabularyReferences; // list of vocab IDs referenced
  final List<String> grammarReferences; // list of grammar pattern IDs referenced
  final List<String> kanjiReferences; // list of Kanji IDs referenced
  final double duration; // duration in seconds
  final DateTime createdAt;
  final DateTime updatedAt;

  // Versioning standard fields
  final int schemaVersion;
  final int contentVersion;
  final DateTime lastUpdated;

  // Optional fields
  final String? audio;
  final String? playbackSpeedMetadata; // metadata for speed options (e.g. JSON string or label)
  final String? notes;

  const ListeningSpec({
    required this.id,
    required this.title,
    required this.jlpt,
    required this.difficulty,
    required this.transcript,
    required this.translation,
    required this.vocabularyReferences,
    required this.grammarReferences,
    required this.kanjiReferences,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.schemaVersion,
    required this.contentVersion,
    required this.lastUpdated,
    this.audio,
    this.playbackSpeedMetadata,
    this.notes,
  });

  factory ListeningSpec.fromJson(Map<String, dynamic> json) {
    return ListeningSpec(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      jlpt: _parseInt(json['jlpt'] ?? json['jlptLevel'] ?? json['jlpt_level']),
      difficulty: _parseDouble(json['difficulty']),
      transcript: json['transcript']?.toString() ?? json['audioScript']?.toString() ?? json['audio_script'] ?? '',
      translation: json['translation']?.toString() ?? '',
      vocabularyReferences: _parseList(json['vocabularyReferences'] ?? json['vocabulary_references'] ?? json['vocabs']),
      grammarReferences: _parseList(json['grammarReferences'] ?? json['grammar_references'] ?? json['grammars']),
      kanjiReferences: _parseList(json['kanjiReferences'] ?? json['kanji_references'] ?? json['kanjis']),
      duration: _parseDouble(json['duration'] ?? json['duration_seconds']),
      createdAt: _parseDate(json['createdAt'] ?? json['created_at'] ?? json['created']),
      updatedAt: _parseDate(json['updatedAt'] ?? json['updated_at'] ?? json['updated']),
      schemaVersion: _parseInt(json['schemaVersion'] ?? json['schema_version'] ?? 1),
      contentVersion: _parseInt(json['contentVersion'] ?? json['content_version'] ?? 1),
      lastUpdated: _parseDate(json['lastUpdated'] ?? json['last_updated'] ?? json['updated_at'] ?? json['updated']),
      audio: json['audio']?.toString(),
      playbackSpeedMetadata: json['playbackSpeedMetadata']?.toString() ?? json['playback_speed_metadata']?.toString(),
      notes: json['notes']?.toString(),
    );
  }

  factory ListeningSpec.fromCsv(List<dynamic> row, Map<String, int> mapping) {
    dynamic getVal(String key) {
      final index = mapping[key];
      if (index == null || index >= row.length) return null;
      return row[index];
    }

    return ListeningSpec(
      id: getVal('id')?.toString() ?? '',
      title: getVal('title')?.toString() ?? '',
      jlpt: _parseInt(getVal('jlpt')),
      difficulty: _parseDouble(getVal('difficulty')),
      transcript: getVal('transcript')?.toString() ?? getVal('audioScript')?.toString() ?? '',
      translation: getVal('translation')?.toString() ?? '',
      vocabularyReferences: _parseList(getVal('vocabularyReferences') ?? getVal('vocabs')),
      grammarReferences: _parseList(getVal('grammarReferences') ?? getVal('grammars')),
      kanjiReferences: _parseList(getVal('kanjiReferences') ?? getVal('kanjis')),
      duration: _parseDouble(getVal('duration')),
      createdAt: _parseDate(getVal('createdAt') ?? getVal('created')),
      updatedAt: _parseDate(getVal('updatedAt') ?? getVal('updated')),
      schemaVersion: _parseInt(getVal('schemaVersion')) == 0 ? 1 : _parseInt(getVal('schemaVersion')),
      contentVersion: _parseInt(getVal('contentVersion')) == 0 ? 1 : _parseInt(getVal('contentVersion')),
      lastUpdated: _parseDate(getVal('lastUpdated') ?? getVal('updated')),
      audio: getVal('audio')?.toString(),
      playbackSpeedMetadata: getVal('playbackSpeedMetadata')?.toString(),
      notes: getVal('notes')?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'jlpt': jlpt,
      'difficulty': difficulty,
      'transcript': transcript,
      'translation': translation,
      'vocabularyReferences': vocabularyReferences,
      'grammarReferences': grammarReferences,
      'kanjiReferences': kanjiReferences,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'schemaVersion': schemaVersion,
      'contentVersion': contentVersion,
      'lastUpdated': lastUpdated.toIso8601String(),
      if (audio != null) 'audio': audio,
      if (playbackSpeedMetadata != null) 'playbackSpeedMetadata': playbackSpeedMetadata,
      if (notes != null) 'notes': notes,
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
