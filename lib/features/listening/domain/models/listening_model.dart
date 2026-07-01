import 'package:shinka_track_n3/core/content/models/listening_spec.dart';

class ListeningModel {
  final ListeningSpec spec;
  final bool isAdded;
  final bool isFavorite; // bookmarked status
  final String status; // 'unlearned', 'reading' (or 'progress'), 'completed'
  final String customNotes;

  const ListeningModel({
    required this.spec,
    required this.isAdded,
    required this.isFavorite,
    required this.status,
    required this.customNotes,
  });

  ListeningModel copyWith({
    ListeningSpec? spec,
    bool? isAdded,
    bool? isFavorite,
    String? status,
    String? customNotes,
  }) {
    return ListeningModel(
      spec: spec ?? this.spec,
      isAdded: isAdded ?? this.isAdded,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
      customNotes: customNotes ?? this.customNotes,
    );
  }
}
