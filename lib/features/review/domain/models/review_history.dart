class ReviewHistory {
  final String id;
  final String itemId;
  final String itemType;
  final DateTime timestamp;
  final String result; // correct, incorrect, Again, Hard, Good, Easy
  final int timeTakenSeconds;
  final int prevInterval;
  final int nextInterval;

  const ReviewHistory({
    required this.id,
    required this.itemId,
    required this.itemType,
    required this.timestamp,
    required this.result,
    required this.timeTakenSeconds,
    required this.prevInterval,
    required this.nextInterval,
  });
}
