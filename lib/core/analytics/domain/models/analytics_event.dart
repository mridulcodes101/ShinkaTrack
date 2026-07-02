class AnalyticsEvent {
  final String id;
  final String eventType; // STUDY_STARTED, STUDY_FINISHED, REVIEW_STARTED, REVIEW_FINISHED, LESSON_COMPLETED...
  final String? contentType; // kanji, vocab, grammar, reading, listening, review, planner...
  final String? contentId;
  final DateTime timestamp;
  final int durationSeconds;
  final String result; // e.g. 'success', 'failure', accuracy ratio
  final Map<String, dynamic> metadata;

  const AnalyticsEvent({
    required this.id,
    required this.eventType,
    this.contentType,
    this.contentId,
    required this.timestamp,
    this.durationSeconds = 0,
    this.result = '',
    this.metadata = const {},
  });

  AnalyticsEvent copyWith({
    String? id,
    String? eventType,
    String? contentType,
    String? contentId,
    DateTime? timestamp,
    int? durationSeconds,
    String? result,
    Map<String, dynamic>? metadata,
  }) {
    return AnalyticsEvent(
      id: id ?? this.id,
      eventType: eventType ?? this.eventType,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      timestamp: timestamp ?? this.timestamp,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      result: result ?? this.result,
      metadata: metadata ?? this.metadata,
    );
  }
}
