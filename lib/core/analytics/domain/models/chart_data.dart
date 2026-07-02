class ChartPoint {
  final String label;
  final double value;
  final Map<String, dynamic> extra;

  const ChartPoint({
    required this.label,
    required this.value,
    this.extra = const {},
  });
}

class ChartData {
  final String title;
  final String chartType; // line, bar, pie, area
  final List<ChartPoint> points;

  const ChartData({
    required this.title,
    required this.chartType,
    required this.points,
  });
}
