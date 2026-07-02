class AnalyticsMetrics {
  final int dailyStudyTime; // seconds
  final int weeklyStudyTime;
  final int monthlyStudyTime;
  final int yearlyStudyTime;
  final int currentStreak;
  final int longestStreak;
  final int lessonsCompleted;
  final int reviewsCompleted;
  final double accuracy; // 0.0 to 1.0
  final double averageSessionLength; // seconds
  final double averageReviewTime; // seconds
  final double completionRate; // 0.0 to 1.0
  final double retentionRate; // 0.0 to 1.0
  final double learningVelocity; // items/day or week

  const AnalyticsMetrics({
    this.dailyStudyTime = 0,
    this.weeklyStudyTime = 0,
    this.monthlyStudyTime = 0,
    this.yearlyStudyTime = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lessonsCompleted = 0,
    this.reviewsCompleted = 0,
    this.accuracy = 0.0,
    this.averageSessionLength = 0.0,
    this.averageReviewTime = 0.0,
    this.completionRate = 0.0,
    this.retentionRate = 0.0,
    this.learningVelocity = 0.0,
  });

  AnalyticsMetrics copyWith({
    int? dailyStudyTime,
    int? weeklyStudyTime,
    int? monthlyStudyTime,
    int? yearlyStudyTime,
    int? currentStreak,
    int? longestStreak,
    int? lessonsCompleted,
    int? reviewsCompleted,
    double? accuracy,
    double? averageSessionLength,
    double? averageReviewTime,
    double? completionRate,
    double? retentionRate,
    double? learningVelocity,
  }) {
    return AnalyticsMetrics(
      dailyStudyTime: dailyStudyTime ?? this.dailyStudyTime,
      weeklyStudyTime: weeklyStudyTime ?? this.weeklyStudyTime,
      monthlyStudyTime: monthlyStudyTime ?? this.monthlyStudyTime,
      yearlyStudyTime: yearlyStudyTime ?? this.yearlyStudyTime,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lessonsCompleted: lessonsCompleted ?? this.lessonsCompleted,
      reviewsCompleted: reviewsCompleted ?? this.reviewsCompleted,
      accuracy: accuracy ?? this.accuracy,
      averageSessionLength: averageSessionLength ?? this.averageSessionLength,
      averageReviewTime: averageReviewTime ?? this.averageReviewTime,
      completionRate: completionRate ?? this.completionRate,
      retentionRate: retentionRate ?? this.retentionRate,
      learningVelocity: learningVelocity ?? this.learningVelocity,
    );
  }
}
