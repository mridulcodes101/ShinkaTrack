class GraphNode {
  final String id;
  final String contentType; // kanji, vocab, grammar, reading, listening, review, planner, achievement
  final String masterId;
  final String title;
  final String subtitle;
  final double difficulty;
  final int jlpt;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GraphNode({
    required this.id,
    required this.contentType,
    required this.masterId,
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.jlpt,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  GraphNode copyWith({
    String? id,
    String? contentType,
    String? masterId,
    String? title,
    String? subtitle,
    double? difficulty,
    int? jlpt,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GraphNode(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      masterId: masterId ?? this.masterId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      difficulty: difficulty ?? this.difficulty,
      jlpt: jlpt ?? this.jlpt,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
