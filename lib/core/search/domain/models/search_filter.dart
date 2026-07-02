class SearchFilter {
  final List<String> contentTypes;
  final List<int> jlptLevels;
  final List<String> difficulties;
  final String collectionStatus; // 'all', 'added', 'favourite'
  final String sortBy; // 'relevance', 'alphabetical', 'newest'

  const SearchFilter({
    this.contentTypes = const [],
    this.jlptLevels = const [],
    this.difficulties = const [],
    this.collectionStatus = 'all',
    this.sortBy = 'relevance',
  });

  SearchFilter copyWith({
    List<String>? contentTypes,
    List<int>? jlptLevels,
    List<String>? difficulties,
    String? collectionStatus,
    String? sortBy,
  }) {
    return SearchFilter(
      contentTypes: contentTypes ?? this.contentTypes,
      jlptLevels: jlptLevels ?? this.jlptLevels,
      difficulties: difficulties ?? this.difficulties,
      collectionStatus: collectionStatus ?? this.collectionStatus,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
