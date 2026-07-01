import 'package:shinka_track_n3/core/content/models/grammar_spec.dart';

class GrammarModel {
  final GrammarSpec spec;
  final bool isAdded;
  final bool isFavorite;
  final String status; // 'unlearned', 'learning', 'mastered'
  final String customNotes;

  const GrammarModel({
    required this.spec,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.customNotes,
  });

  GrammarModel copyWith({
    GrammarSpec? spec,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    String? customNotes,
  }) {
    return GrammarModel(
      spec: spec ?? this.spec,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      customNotes: customNotes ?? this.customNotes,
    );
  }
}
