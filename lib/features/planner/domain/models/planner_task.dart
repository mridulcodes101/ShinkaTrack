class PlannerTask {
  final String id;
  final DateTime date;
  final String itemType; // kanji, vocab, grammar, reading, listening, review
  final String itemId;
  final bool isCompleted;
  final bool isReview;
  final int duration; // in minutes
  final int priority; // 1 = high, 2 = medium, 3 = low
  final double completion; // 0.0 to 100.0
  final DateTime createdAt;
  final DateTime updatedAt;

  const PlannerTask({
    required this.id,
    required this.date,
    required this.itemType,
    required this.itemId,
    required this.isCompleted,
    required this.isReview,
    required this.duration,
    required this.priority,
    required this.completion,
    required this.createdAt,
    required this.updatedAt,
  });

  PlannerTask copyWith({
    String? id,
    DateTime? date,
    String? itemType,
    String? itemId,
    bool? isCompleted,
    bool? isReview,
    int? duration,
    int? priority,
    double? completion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlannerTask(
      id: id ?? this.id,
      date: date ?? this.date,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      isCompleted: isCompleted ?? this.isCompleted,
      isReview: isReview ?? this.isReview,
      duration: duration ?? this.duration,
      priority: priority ?? this.priority,
      completion: completion ?? this.completion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
