class StudySessionModel {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int durationSeconds;
  final String sessionType; // guided, review, quick, planner, custom
  final String status; // Created, Running, Paused, Completed, Cancelled, Abandoned
  final List<String> modulesStudied;
  final int tasksCompleted;
  final int reviewsCompleted;
  final int interruptions;
  final int pauseCount;
  final double completion; // 0.0 to 1.0
  final int xpEarned;

  const StudySessionModel({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.durationSeconds,
    required this.sessionType,
    required this.status,
    required this.modulesStudied,
    required this.tasksCompleted,
    required this.reviewsCompleted,
    required this.interruptions,
    required this.pauseCount,
    required this.completion,
    required this.xpEarned,
  });

  StudySessionModel copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    int? durationSeconds,
    String? sessionType,
    String? status,
    List<String>? modulesStudied,
    int? tasksCompleted,
    int? reviewsCompleted,
    int? interruptions,
    int? pauseCount,
    double? completion,
    int? xpEarned,
  }) {
    return StudySessionModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      sessionType: sessionType ?? this.sessionType,
      status: status ?? this.status,
      modulesStudied: modulesStudied ?? this.modulesStudied,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      reviewsCompleted: reviewsCompleted ?? this.reviewsCompleted,
      interruptions: interruptions ?? this.interruptions,
      pauseCount: pauseCount ?? this.pauseCount,
      completion: completion ?? this.completion,
      xpEarned: xpEarned ?? this.xpEarned,
    );
  }
}
