import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';

class ShinkaContentPackMetadata {
  final String author;
  final String authorChecksum;
  final String version;
  final String title;

  const ShinkaContentPackMetadata({
    required this.author,
    required this.authorChecksum,
    required this.version,
    required this.title,
  });

  factory ShinkaContentPackMetadata.fromJson(Map<String, dynamic> json) {
    return ShinkaContentPackMetadata(
      author: json['author'] as String? ?? 'Anonymous',
      authorChecksum: json['authorChecksum'] as String? ?? '',
      version: json['version'] as String? ?? '1.0.0',
      title: json['title'] as String? ?? 'Content Pack',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'authorChecksum': authorChecksum,
      'version': version,
      'title': title,
    };
  }
}

class ShinkaContentPack {
  final ShinkaContentPackMetadata metadata;
  final List<KanjiEntity> kanji;
  final List<VocabularyEntity> vocabulary;
  final List<GrammarEntity> grammar;
  final List<ReadingEntity> reading;
  final List<ListeningEntity> listening;

  const ShinkaContentPack({
    required this.metadata,
    required this.kanji,
    required this.vocabulary,
    required this.grammar,
    required this.reading,
    required this.listening,
  });
}
