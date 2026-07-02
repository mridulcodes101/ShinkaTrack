class SearchResult {
  final String id;
  final String contentType; // kanji, vocab, grammar, reading, listening
  final String primaryTitle;
  final String secondaryTitle;
  final String preview;
  final String icon;
  final int jlpt;
  final String difficulty;
  final String? thumbnail;
  final String route;
  final double searchScore;

  const SearchResult({
    required this.id,
    required this.contentType,
    required this.primaryTitle,
    required this.secondaryTitle,
    required this.preview,
    required this.icon,
    required this.jlpt,
    required this.difficulty,
    this.thumbnail,
    required this.route,
    required this.searchScore,
  });

  SearchResult copyWith({
    String? id,
    String? contentType,
    String? primaryTitle,
    String? secondaryTitle,
    String? preview,
    String? icon,
    int? jlpt,
    String? difficulty,
    String? thumbnail,
    String? route,
    double? searchScore,
  }) {
    return SearchResult(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      primaryTitle: primaryTitle ?? this.primaryTitle,
      secondaryTitle: secondaryTitle ?? this.secondaryTitle,
      preview: preview ?? this.preview,
      icon: icon ?? this.icon,
      jlpt: jlpt ?? this.jlpt,
      difficulty: difficulty ?? this.difficulty,
      thumbnail: thumbnail ?? this.thumbnail,
      route: route ?? this.route,
      searchScore: searchScore ?? this.searchScore,
    );
  }
}
