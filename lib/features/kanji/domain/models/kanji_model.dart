import 'package:shinka_track_n3/core/content/models/kanji_spec.dart';

class KanjiModel {
  final KanjiSpec spec;
  final bool isAdded;
  final bool isLearned;
  final bool isFavorite;
  final int reviewCount;
  final DateTime? nextReview;
  final DateTime? lastReviewed;
  final String customNotes;

  const KanjiModel({
    required this.spec,
    required this.isAdded,
    required this.isLearned,
    required this.isFavorite,
    required this.reviewCount,
    this.nextReview,
    this.lastReviewed,
    required this.customNotes,
  });

  KanjiModel copyWith({
    KanjiSpec? spec,
    bool? isAdded,
    bool? isLearned,
    bool? isFavorite,
    int? reviewCount,
    DateTime? nextReview,
    DateTime? lastReviewed,
    String? customNotes,
  }) {
    return KanjiModel(
      spec: spec ?? this.spec,
      isAdded: isAdded ?? this.isAdded,
      isLearned: isLearned ?? this.isLearned,
      isFavorite: isFavorite ?? this.isFavorite,
      reviewCount: reviewCount ?? this.reviewCount,
      nextReview: nextReview ?? this.nextReview,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      customNotes: customNotes ?? this.customNotes,
    );
  }
}