import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/study_session/domain/models/study_session_model.dart';
import 'package:shinka_track_n3/features/study_session/application/study_session_notifier.dart';

class StudySessionScreen extends ConsumerStatefulWidget {
  final String sessionType; // guided, review, quick, planner, custom
  final List<String> modules;

  const StudySessionScreen({
    super.key,
    required this.sessionType,
    required this.modules,
  });

  @override
  ConsumerState<StudySessionScreen> createState() => _StudySessionScreenState();
}

class _StudySessionScreenState extends ConsumerState<StudySessionScreen> with WidgetsBindingObserver {
  late String _sessionId;
  int _seconds = 0;
  bool _isPaused = false;
  int _pauseCount = 0;
  int _interruptions = 0;
  int _tasksCompleted = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _sessionId = 'session_${DateTime.now().millisecondsSinceEpoch}';
    _startSession();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ref.read(studySessionEngineProvider).dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Interruption detection: increment count when backgrounded
    if (state == AppLifecycleState.paused) {
      ref.read(studySessionEngineProvider).recordInterruption();
      setState(() {
        _interruptions++;
      });
    }
  }

  void _startSession() async {
    final engine = ref.read(studySessionEngineProvider);
    await engine.startSession(
      id: _sessionId,
      type: widget.sessionType,
      modules: widget.modules,
    );

    engine.onTick.listen((elapsed) {
      if (mounted && !_isPaused) {
        setState(() {
          _seconds = elapsed;
        });
      }
    });
  }

  String _formatTimer(int totalSecs) {
    final m = (totalSecs ~/ 60).toString().padLeft(2, '0');
    final s = (totalSecs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _togglePause() async {
    final engine = ref.read(studySessionEngineProvider);
    if (_isPaused) {
      await engine.resumeSession();
      setState(() {
        _isPaused = false;
      });
    } else {
      await engine.pauseSession();
      setState(() {
        _isPaused = true;
        _pauseCount++;
      });
    }
  }

  void _completeTask() {
    ref.read(studySessionEngineProvider).incrementTasks();
    setState(() {
      _tasksCompleted++;
    });
  }

  void _finishSession({bool isAbandon = false}) async {
    final engine = ref.read(studySessionEngineProvider);
    final finished = await engine.finishSession(isAbandon: isAbandon);

    if (mounted) {
      _showCompletionDialog(finished);
    }
  }

  void _showCompletionDialog(StudySessionModel session) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Icon(
                session.status == 'Abandoned' ? Icons.warning_amber : Icons.stars,
                color: session.status == 'Abandoned' ? Colors.orange : PremiumDesignSystem.primaryBlue,
              ),
              const SizedBox(width: 12),
              Text(session.status == 'Abandoned' ? 'Session Abandoned' : 'Session Completed!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Summary of your study session:', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              const SizedBox(height: 16),
              _buildSummaryRow('Duration', _formatTimer(session.durationSeconds)),
              _buildSummaryRow('Tasks Completed', '${session.tasksCompleted}'),
              _buildSummaryRow('XP Awarded', '+${session.xpEarned} XP'),
              _buildSummaryRow('Interruptions', '${session.interruptions} times'),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PremiumDesignSystem.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context); // close dialog
                context.go('/'); // redirect to dashboard
              },
              child: const Text('Finish'),
            )
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Text('${widget.sessionType.toUpperCase()} STUDY SESSION', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel_outlined, color: Colors.red),
            tooltip: 'Abandon Study',
            onPressed: () => _finishSession(isAbandon: true),
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer representation
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatTimer(_seconds),
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isPaused ? 'PAUSED' : 'STUDYING',
                        style: TextStyle(
                          color: _isPaused ? Colors.orange : PremiumDesignSystem.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Stats row
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatsItem('Tasks', '$_tasksCompleted'),
                        _buildStatsItem('Pauses', '$_pauseCount'),
                        _buildStatsItem('Alerts', '$_interruptions'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: _isPaused ? Colors.green : Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                      onPressed: _togglePause,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PremiumDesignSystem.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Complete Task', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _isPaused ? null : _completeTask,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => _finishSession(isAbandon: false),
                    child: const Text('Finish & Save Session', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsItem(String label, String val) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
      ],
    );
  }
}
