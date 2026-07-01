import 'package:shinka_track_n3/core/content/models/vocabulary_spec.dart';

class VocabularyModel {
  final VocabularySpec spec;
  final bool isAdded;
  final bool isFavorite;
  final String status; // 'unlearned', 'learning', 'mastered'
  final int reviewCount;
  final DateTime? nextReview;
  final DateTime? lastReviewed;
  final double easeFactor;
  final String customNotes;

  const VocabularyModel({
    required this.spec,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.reviewCount,
    this.nextReview,
    this.lastReviewed,
    required this.easeFactor,
    required this.customNotes,
  });

  VocabularyModel copyWith({
    VocabularySpec? spec,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    int? reviewCount,
    DateTime? nextReview,
    DateTime? lastReviewed,
    double? easeFactor,
    String? customNotes,
  }) {
    return VocabularyModel(
      spec: spec ?? this.spec,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      reviewCount: reviewCount ?? this.reviewCount,
      nextReview: nextReview ?? this.nextReview,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      easeFactor: easeFactor ?? this.easeFactor,
      customNotes: customNotes ?? this.customNotes,
    );
  }
}
