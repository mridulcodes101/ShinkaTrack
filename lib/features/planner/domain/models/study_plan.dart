class StudyPlan {
  final String id;
  final DateTime startDate;
  final DateTime targetDate;
  final double availableHours; // daily available hours/minutes limit
  final bool isActive;
  final String goal; // JLPT N5-N1, Custom
  final List<String> studyDays; // Monday, Tuesday, etc.
  final List<String> resources; // kanji, vocab, grammar, reading, listening

  const StudyPlan({
    required this.id,
    required this.startDate,
    required this.targetDate,
    required this.availableHours,
    required this.isActive,
    required this.goal,
    required this.studyDays,
    required this.resources,
  });

  StudyPlan copyWith({
    String? id,
    DateTime? startDate,
    DateTime? targetDate,
    double? availableHours,
    bool? isActive,
    String? goal,
    List<String>? studyDays,
    List<String>? resources,
  }) {
    return StudyPlan(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      availableHours: availableHours ?? this.availableHours,
      isActive: isActive ?? this.isActive,
      goal: goal ?? this.goal,
      studyDays: studyDays ?? this.studyDays,
      resources: resources ?? this.resources,
    );
  }
}
