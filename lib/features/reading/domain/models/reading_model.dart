import 'package:shinka_track_n3/core/content/models/reading_spec.dart';

class ReadingModel {
  final ReadingSpec spec;
  final bool isAdded;
  final bool isFavorite; // bookmarked status
  final String status; // 'unlearned', 'reading', 'completed'
  final String customNotes;

  const ReadingModel({
    required this.spec,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.customNotes,
  });

  ReadingModel copyWith({
    ReadingSpec? spec,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    String? customNotes,
  }) {
    return ReadingModel(
      spec: spec ?? this.spec,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      customNotes: customNotes ?? this.customNotes,
    );
  }
}
