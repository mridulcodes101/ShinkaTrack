class StudyPlanEntity {
  final String id;
  final DateTime startDate;
  final DateTime targetDate;
  final double availableHours;
  final bool isActive;

  const StudyPlanEntity({
    required this.id,
    required this.startDate,
    required this.targetDate,
    required this.availableHours,
    this.isActive = true,
  });

  StudyPlanEntity copyWith({
    DateTime? startDate,
    DateTime? targetDate,
    double? availableHours,
    bool? isActive,
  }) {
    return StudyPlanEntity(
      id: id,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      availableHours: availableHours ?? this.availableHours,
      isActive: isActive ?? this.isActive,
    );
  }
}

class PlannerTaskEntity {
  final String id;
  final DateTime date;
  final String itemType; // kanji, vocab, grammar, reading, listening, review
  final String itemId;
  final bool isCompleted;
  final bool isReview;
  final String title;
  final String details;

  const PlannerTaskEntity({
    required this.id,
    required this.date,
    required this.itemType,
    required this.itemId,
    required this.isCompleted,
    required this.isReview,
    required this.title,
    required this.details,
  });

  PlannerTaskEntity copyWith({
    bool? isCompleted,
  }) {
    return PlannerTaskEntity(
      id: id,
      date: date,
      itemType: itemType,
      itemId: itemId,
      isCompleted: isCompleted ?? this.isCompleted,
      isReview: isReview,
      title: title,
      details: details,
    );
  }
}
