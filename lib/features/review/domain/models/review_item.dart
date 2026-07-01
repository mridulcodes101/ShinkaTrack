class ReviewItem {
  final String id;
  final String contentType; // kanji, vocab, grammar, reading, listening, etc.
  final String masterContentId;
  final String userContentId;
  final String title;
  final String subtitle;
  final String preview;
  final double difficulty;
  final String reviewState; // unlearned, learning, mastered, etc.
  final DateTime? nextReview;
  final DateTime? lastReview;
  final int reviewCount;
  final int correctCount;
  final int incorrectCount;
  final double easeFactor;
  final int interval;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReviewItem({
    required this.id,
    required this.contentType,
    required this.masterContentId,
    required this.userContentId,
    required this.title,
    required this.subtitle,
    required this.preview,
    required this.difficulty,
    required this.reviewState,
    this.nextReview,
    this.lastReview,
    this.reviewCount = 0,
    this.correctCount = 0,
    this.incorrectCount = 0,
    this.easeFactor = 2.5,
    this.interval = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  ReviewItem copyWith({
    String? id,
    String? contentType,
    String? masterContentId,
    String? userContentId,
    String? title,
    String? subtitle,
    String? preview,
    double? difficulty,
    String? reviewState,
    DateTime? nextReview,
    DateTime? lastReview,
    int? reviewCount,
    int? correctCount,
    int? incorrectCount,
    double? easeFactor,
    int? interval,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReviewItem(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      masterContentId: masterContentId ?? this.masterContentId,
      userContentId: userContentId ?? this.userContentId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      preview: preview ?? this.preview,
      difficulty: difficulty ?? this.difficulty,
      reviewState: reviewState ?? this.reviewState,
      nextReview: nextReview ?? this.nextReview,
      lastReview: lastReview ?? this.lastReview,
      reviewCount: reviewCount ?? this.reviewCount,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      easeFactor: easeFactor ?? this.easeFactor,
      interval: interval ?? this.interval,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
