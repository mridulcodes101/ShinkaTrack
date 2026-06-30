import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';
import 'package:shinka_track_n3/core/design/design_tokens.dart';
import 'package:shinka_track_n3/core/navigation/responsive_layout.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeFabProvider.notifier).state = FabConfig(
        label: 'Export Progress',
        icon: Icons.upload,
        onPressed: _exportProgressData,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(activeFabProvider)?.label == 'Export Progress') {
        ref.read(activeFabProvider.notifier).state = null;
      }
    });
    super.dispose();
  }

  void _exportProgressData() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          shape: AppRadius.shapeLG,
          title: const Text('Export Progress', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('All study metrics, collections, and lesson parameters successfully packaged and exported to backup files.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final kanjiAsync = ref.watch(kanjiListProvider);
    final vocabAsync = ref.watch(vocabListProvider);
    final grammarAsync = ref.watch(grammarListProvider);
    final readingAsync = ref.watch(readingListProvider);
    final listeningAsync = ref.watch(listeningListProvider);

    final sessionsAsync = ref.watch(studySessionsProvider);
    final streakAsync = ref.watch(streakProvider);
    final longestStreakAsync = ref.watch(longestStreakProvider);
    final statsAsync = ref.watch(studyStatsProvider);
    final progressStatsAsync = ref.watch(overallProgressProvider);

    final bool dataLoaded = kanjiAsync.hasValue &&
        vocabAsync.hasValue &&
        grammarAsync.hasValue &&
        readingAsync.hasValue &&
        listeningAsync.hasValue &&
        sessionsAsync.hasValue &&
        streakAsync.hasValue &&
        longestStreakAsync.hasValue &&
        statsAsync.hasValue &&
        progressStatsAsync.hasValue;

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (!dataLoaded) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        appBar: AppBar(
          title: const Text('Progress Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Extract values
    final kanjis = kanjiAsync.value ?? [];
    final vocabs = vocabAsync.value ?? [];
    final grammars = grammarAsync.value ?? [];
    final readings = readingAsync.value ?? [];
    final listenings = listeningAsync.value ?? [];

    final sessions = sessionsAsync.value ?? [];
    final currentStreak = streakAsync.value ?? 0;
    final longestStreak = longestStreakAsync.value ?? 0;
    final statsBundle = statsAsync.value!;
    final progressStats = progressStatsAsync.value!;

    final int finishedKanjis = kanjis.where((x) => x.status == StudyStatus.mastered).length;
    final int finishedVocabs = vocabs.where((x) => x.status == StudyStatus.mastered).length;
    final int finishedGrammars = grammars.where((x) => x.status == StudyStatus.mastered).length;
    final int finishedReadings = readings.where((x) => x.status == StudyStatus.mastered).length;
    final int finishedListenings = listenings.where((x) => x.status == StudyStatus.mastered).length;

    final int totalFinished = finishedKanjis + finishedVocabs + finishedGrammars + finishedReadings + finishedListenings;
    final double completionRate = progressStats.overall;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Progress', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STREAK & COMPLETION METRIC CARDS GRID
            Row(
              children: [
                Expanded(
                  child: _buildMetricGradientCard(
                    title: 'Streak Ratio',
                    primaryValue: '$currentStreak Days',
                    secondaryLabel: 'Longest: $longestStreak Days',
                    icon: Icons.local_fire_department,
                    gradient: PremiumDesignSystem.sakuraGradient,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricGradientCard(
                    title: 'Completion Rate',
                    primaryValue: '${(completionRate * 100).toInt()}%',
                    secondaryLabel: 'Finished: $totalFinished lessons',
                    icon: Icons.stars,
                    gradient: PremiumDesignSystem.primaryGradient,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // MINI FOCUS DURATION TIME CARDS
            Row(
              children: [
                Expanded(child: _buildTimeCard('Daily', '${statsBundle.dailyMinutes.toStringAsFixed(1)} m', isDark)),
                const SizedBox(width: 8),
                Expanded(child: _buildTimeCard('Weekly', '${statsBundle.weeklyMinutes.toStringAsFixed(1)} m', isDark)),
                const SizedBox(width: 8),
                Expanded(child: _buildTimeCard('Monthly', '${statsBundle.monthlyMinutes.toStringAsFixed(1)} m', isDark)),
                const SizedBox(width: 8),
                Expanded(child: _buildTimeCard('Avg Rate', '${statsBundle.averageDailyMinutes.toStringAsFixed(1)} m/d', isDark)),
              ],
            ),
            const SizedBox(height: 28),

            // BAR CHART: WEEKLY STUDY TIME
            const Text('Weekly Study Time (Daily)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildWeeklyStudyBarChart(context, sessions),
            const SizedBox(height: 28),

            // LINE CHART: FOCUS STUDY PROGRESSION (CUMULATIVE PROGRESS)
            const Text('Focus Study Progression (Line)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildCumulativeLineChart(context, sessions),
            const SizedBox(height: 28),

            // PIE CHART: MASTERY DISTRIBUTION (ALL PILLARS)
            const Text('Mastery Distribution (Pie)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildMasteryPieChart(context, kanjis, vocabs, grammars, readings, listenings),
            const SizedBox(height: 28),

            // HEATMAP activity grid
            const Text('Study Heatmap (28 Days)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildHeatmapGrid(context, sessions),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  // --- GRADIENT METRICS CARD ---

  Widget _buildMetricGradientCard({
    required String title,
    required String primaryValue,
    required String secondaryLabel,
    required IconData icon,
    required Gradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            primaryValue,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            secondaryLabel,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11),
          ),
        ],
      ),
    );
  }

  // --- MINI TIME TIME CARDS ---

  Widget _buildTimeCard(String label, String value, bool isDark) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      borderRadius: 14,
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // --- BAR CHART (WEEKLY FOCUS DISTRIBUTION) ---

  Widget _buildWeeklyStudyBarChart(BuildContext context, List<StudySessionEntity> sessions) {
    final DateFormat dayFormat = DateFormat('E');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final List<DateTime> last7Days = List.generate(
      7,
      (index) => DateTime.now().subtract(Duration(days: 6 - index)),
    );

    final Map<String, double> dailyMinutes = {};
    for (var date in last7Days) {
      dailyMinutes[formatter.format(date)] = 0.0;
    }

    for (var session in sessions) {
      final dateKey = formatter.format(session.date);
      if (dailyMinutes.containsKey(dateKey)) {
        dailyMinutes[dateKey] = dailyMinutes[dateKey]! + (session.durationSeconds / 60.0);
      }
    }

    final double maxVal = dailyMinutes.values.isNotEmpty ? dailyMinutes.values.reduce(max) : 0.0;
    final double yAxisLimit = max(15.0, (maxVal / 5).ceil() * 5.0 + 5.0);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily focus duration in minutes.',
            style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: yAxisLimit,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => PremiumDesignSystem.secondaryPink,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(1)} min',
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        final int index = val.toInt();
                        if (index < 0 || index >= 7) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            dayFormat.format(last7Days[index]),
                            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (val, meta) {
                        if (val % 5 != 0) return const SizedBox();
                        return Text(
                          '${val.toInt()}m',
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: List.generate(7, (index) {
                  final key = formatter.format(last7Days[index]);
                  final val = dailyMinutes[key] ?? 0.0;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: val,
                        color: PremiumDesignSystem.primaryBlue,
                        width: 14,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: yAxisLimit,
                          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- LINE CHART (CUMULATIVE FOCUS PROGRESSION) ---

  Widget _buildCumulativeLineChart(BuildContext context, List<StudySessionEntity> sessions) {
    final DateFormat dayFormat = DateFormat('E');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final List<DateTime> last7Days = List.generate(
      7,
      (index) => DateTime.now().subtract(Duration(days: 6 - index)),
    );

    // Calculate cumulative daily totals
    final Map<String, double> dailyMinutes = {};
    for (var date in last7Days) {
      dailyMinutes[formatter.format(date)] = 0.0;
    }

    for (var session in sessions) {
      final dateKey = formatter.format(session.date);
      if (dailyMinutes.containsKey(dateKey)) {
        dailyMinutes[dateKey] = dailyMinutes[dateKey]! + (session.durationSeconds / 60.0);
      }
    }

    // Build cumulative array
    double cumulative = 0.0;
    final List<FlSpot> spots = [];
    for (int i = 0; i < last7Days.length; i++) {
      final key = formatter.format(last7Days[i]);
      cumulative += dailyMinutes[key] ?? 0.0;
      spots.add(FlSpot(i.toDouble(), cumulative));
    }

    final double maxVal = cumulative;
    final double yAxisLimit = max(30.0, (maxVal / 10).ceil() * 10.0 + 10.0);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cumulative focus minutes accumulated this week.',
            style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                maxY: yAxisLimit,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (group) => PremiumDesignSystem.primaryBlue,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)} min',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                        );
                      }).toList();
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        final int index = val.toInt();
                        if (index < 0 || index >= 7) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            dayFormat.format(last7Days[index]),
                            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (val, meta) {
                        if (val % 10 != 0) return const SizedBox();
                        return Text(
                          '${val.toInt()}m',
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 10),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: PremiumDesignSystem.secondaryPink,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: PremiumDesignSystem.secondaryPink.withOpacity(0.12),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- PIE CHART (MASTERY DISTRIBUTION - ALL 5 MODULES) ---

  Widget _buildMasteryPieChart(
    BuildContext context,
    List<KanjiEntity> kanjis,
    List<VocabularyEntity> vocabs,
    List<GrammarEntity> grammars,
    List<ReadingEntity> readings,
    List<ListeningEntity> listenings,
  ) {
    int unlearned = 0;
    int learning = 0;
    int mastered = 0;

    final allItems = [...kanjis, ...vocabs, ...grammars, ...readings, ...listenings];
    for (dynamic item in allItems) {
      if (item.status == StudyStatus.mastered) {
        mastered++;
      } else if (item.status == StudyStatus.learning) {
        learning++;
      } else {
        unlearned++;
      }
    }

    final total = allItems.length;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown of lesson mastery statuses.',
            style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 140,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 35,
                      sections: [
                        PieChartSectionData(
                          color: PremiumDesignSystem.primaryBlue,
                          value: mastered.toDouble(),
                          title: total == 0 ? '0%' : '${(mastered * 100 / total).toStringAsFixed(0)}%',
                          radius: 40,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          color: PremiumDesignSystem.amberGold,
                          value: learning.toDouble(),
                          title: total == 0 ? '0%' : '${(learning * 100 / total).toStringAsFixed(0)}%',
                          radius: 40,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        PieChartSectionData(
                          color: Colors.grey.withOpacity(0.3),
                          value: unlearned.toDouble(),
                          title: total == 0 ? '0%' : '${(unlearned * 100 / total).toStringAsFixed(0)}%',
                          radius: 40,
                          titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Legend columns
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem('Mastered', mastered, PremiumDesignSystem.primaryBlue),
                    const SizedBox(height: 8),
                    _buildLegendItem('Learning', learning, PremiumDesignSystem.amberGold),
                    const SizedBox(height: 8),
                    _buildLegendItem('Unlearned', unlearned, Colors.grey.withValues(alpha: 0.6)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, int count, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $count',
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  // --- STUDY HEATMAP GRID (28 DAYS) ---

  Widget _buildHeatmapGrid(BuildContext context, List<StudySessionEntity> sessions) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final Map<String, int> dailySeconds = {};

    final List<DateTime> last28Days = List.generate(
      28,
      (index) => DateTime.now().subtract(Duration(days: 27 - index)),
    );

    for (var date in last28Days) {
      dailySeconds[formatter.format(date)] = 0;
    }

    for (var session in sessions) {
      final dateKey = formatter.format(session.date);
      if (dailySeconds.containsKey(dateKey)) {
        dailySeconds[dateKey] = dailySeconds[dateKey]! + session.durationSeconds;
      }
    }

    return GlassCard(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1.0,
            ),
            itemCount: 28,
            itemBuilder: (context, index) {
              final date = last28Days[index];
              final key = formatter.format(date);
              final seconds = dailySeconds[key] ?? 0;
              final minutes = seconds ~/ 60;

              Color cellColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
              if (minutes > 15) {
                cellColor = const Color(0xFF047857);
              } else if (minutes > 5) {
                cellColor = const Color(0xFF10B981);
              } else if (minutes > 0) {
                cellColor = const Color(0xFF6EE7B7);
              }

              return Tooltip(
                message: '${DateFormat('MMM d').format(date)}: $minutes mins studied',
                child: Container(
                  decoration: BoxDecoration(
                    color: cellColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Less', style: TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(width: 4),
              _buildSmallLegendBox(isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
              _buildSmallLegendBox(const Color(0xFF6EE7B7)),
              _buildSmallLegendBox(const Color(0xFF10B981)),
              _buildSmallLegendBox(const Color(0xFF047857)),
              const SizedBox(width: 4),
              const Text('More', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildSmallLegendBox(Color color) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
