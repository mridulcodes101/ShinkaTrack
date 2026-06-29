class ReviewItemEntity {
  final String id;
  final String itemType; // kanji, vocab, grammar, reading, listening
  final String itemId;
  final int stage; // 0 to 6
  final DateTime nextReviewDate;
  final DateTime lastReviewDate;
  final String title;
  final String details;

  const ReviewItemEntity({
    required this.id,
    required this.itemType,
    required this.itemId,
    required this.stage,
    required this.nextReviewDate,
    required this.lastReviewDate,
    required this.title,
    required this.details,
  });

  ReviewItemEntity copyWith({
    int? stage,
    DateTime? nextReviewDate,
    DateTime? lastReviewDate,
  }) {
    return ReviewItemEntity(
      id: id,
      itemType: itemType,
      itemId: itemId,
      stage: stage ?? this.stage,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      title: title,
      details: details,
    );
  }
}
