import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study/presentation/providers/study_providers.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isRunning = false;
  String _selectedCategory = 'Kanji';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });
    _animationController.repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _pauseTimer() {
    if (!_isRunning) return;

    _timer?.cancel();
    _animationController.stop();
    setState(() {
      _isRunning = false;
    });
  }

  Future<void> _stopAndSaveTimer() async {
    _timer?.cancel();
    _animationController.stop();

    final int secondsToSave = _secondsElapsed;
    final String categoryToSave = _selectedCategory.toLowerCase();

    setState(() {
      _isRunning = false;
      _secondsElapsed = 0;
    });

    if (secondsToSave > 0) {
      await ref.read(studySessionsProvider.notifier).logSession(secondsToSave, categoryToSave);
      await ref.read(dailyGoalProvider.notifier).addProgress(seconds: secondsToSave);

      if (mounted) {
        _showSessionSummary(secondsToSave, _selectedCategory);
      }
    }
  }

  void _showSessionSummary(int seconds, String category) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    final String timeStr = minutes > 0
        ? '$minutes min $remainingSeconds sec'
        : '$remainingSeconds sec';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.spa,
                size: 64,
                color: PremiumDesignSystem.forestEmerald,
              ),
              const SizedBox(height: 16),
              const Text(
                'Focus Seed Harvested!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Congratulations! You added $timeStr of N3 $category focus to your evolution tree.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;

    final String hStr = hours > 0 ? '${hours.toString().padLeft(2, '0')}:' : '';
    final String mStr = '${minutes.toString().padLeft(2, '0')}:';
    final String sStr = seconds.toString().padLeft(2, '0');

    return '$hStr$mStr$sStr';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: _isRunning
              ? (isDark ? const Color(0xFF070B14) : const Color(0xFFF1F5F9))
              : Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth >= 600;

              // Forest growth seedling painter
              final growthPainter = SizedBox(
                width: 240,
                height: 240,
                child: CustomPaint(
                  painter: TreeGrowthPainter(
                    seconds: _secondsElapsed,
                    pulseValue: _pulseValueAnimation(),
                    isRunning: _isRunning,
                    primaryColor: isDark ? Colors.white : Colors.black87,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _formatTime(_secondsElapsed),
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isRunning ? 'FOCUSING' : 'QUIET SPACE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: _isRunning
                                ? PremiumDesignSystem.forestEmerald
                                : Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              final categorySelector = AnimatedOpacity(
                opacity: _isRunning ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 400),
                child: AbsorbPointer(
                  absorbing: _isRunning,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Choose focus topic',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: -0.2),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ['Kanji', 'Vocab', 'Grammar'].map((cat) {
                          final isSelected = _selectedCategory == cat;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: ChoiceChip(
                              label: Text(cat),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedCategory = cat;
                                  });
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );

              final controls = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_secondsElapsed > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: IconButton.filledTonal(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Discard focus?'),
                              content: const Text('Are you sure you want to discard this focus session? progress will not be saved.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _timer?.cancel();
                                      _animationController.stop();
                                      _isRunning = false;
                                      _secondsElapsed = 0;
                                    });
                                  },
                                  child: const Text('Discard', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: 26,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Material(
                        color: _isRunning ? Colors.red.withValues(alpha: 0.12) : PremiumDesignSystem.forestEmerald.withValues(alpha: 0.12),
                        child: InkWell(
                          onTap: _isRunning ? _pauseTimer : _startTimer,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Icon(
                              _isRunning ? Icons.pause : Icons.play_arrow,
                              size: 40,
                              color: _isRunning ? Colors.red : PremiumDesignSystem.forestEmerald,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_secondsElapsed > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Material(
                          color: PremiumDesignSystem.forestEmerald,
                          child: InkWell(
                            onTap: _stopAndSaveTimer,
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              child: const Icon(
                                Icons.check,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );

              if (isWide) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    children: [
                      Expanded(child: Center(child: growthPainter)),
                      const VerticalDivider(width: 40),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            categorySelector,
                            const SizedBox(height: 48),
                            controls,
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                child: Column(
                  children: [
                    categorySelector,
                    const Spacer(),
                    growthPainter,
                    const Spacer(),
                    controls,
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  double _pulseValueAnimation() {
    if (!_isRunning) return 1.0;
    return 1.0 + (_animationController.value * 0.04);
  }
}

/// Custom Painter that draws a calming Bonsai/Seeding growth representation
/// as focus session time progresses.
class TreeGrowthPainter extends CustomPainter {
  final int seconds;
  final double pulseValue;
  final bool isRunning;
  final Color primaryColor;

  TreeGrowthPainter({
    required this.seconds,
    required this.pulseValue,
    required this.isRunning,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Paint activeProgressPaint = Paint()
      ..color = PremiumDesignSystem.forestEmerald
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 - 8;

    // Draw background circle
    canvas.drawCircle(center, radius, linePaint);

    // Draw active progress ring (mapping to 25 mins Focus standard)
    const int targetFocusSeconds = 1500;
    final double progressRatio = (seconds / targetFocusSeconds).clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progressRatio,
      false,
      activeProgressPaint,
    );

    // Draw Growing Organic Seedling branch inside
    final Paint branchPaint = Paint()
      ..color = PremiumDesignSystem.forestEmerald.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final Path branchPath = Path();
    branchPath.moveTo(center.dx, center.dy + 50);
    // Draw trunk
    branchPath.quadraticBezierTo(center.dx - 10, center.dy + 10, center.dx, center.dy - 10);

    canvas.drawPath(branchPath, branchPaint);

    // Draw Leaves based on focus time (1 leaf for every 30 seconds focused, up to 6 leaves)
    final int leafCount = (seconds ~/ 30).clamp(0, 6);
    final Paint leafPaint = Paint()
      ..color = PremiumDesignSystem.forestEmerald
      ..style = PaintingStyle.fill;

    final List<Offset> leafPositions = [
      Offset(center.dx - 8, center.dy + 30),
      Offset(center.dx + 8, center.dy + 20),
      Offset(center.dx - 9, center.dy + 5),
      Offset(center.dx + 9, center.dy - 2),
      Offset(center.dx - 6, center.dy - 12),
      Offset(center.dx, center.dy - 22),
    ];

    for (int i = 0; i < leafCount; i++) {
      final pos = leafPositions[i];
      canvas.drawOval(
        Rect.fromCenter(
          center: pos,
          width: 8 * pulseValue,
          height: 14 * pulseValue,
        ),
        leafPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant TreeGrowthPainter oldDelegate) {
    return oldDelegate.seconds != seconds ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.isRunning != isRunning;
  }
}
