class SmartNotification {
  final String id;
  final String title;
  final String body;
  final DateTime scheduledTime;
  final String type; // study, review, achievement, planner, streak
  final bool isTriggered;

  const SmartNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.type,
    this.isTriggered = false,
  });

  SmartNotification copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? scheduledTime,
    String? type,
    bool? isTriggered,
  }) {
    return SmartNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      type: type ?? this.type,
      isTriggered: isTriggered ?? this.isTriggered,
    );
  }
}
