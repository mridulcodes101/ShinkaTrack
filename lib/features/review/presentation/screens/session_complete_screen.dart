import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/review/application/review_notifier.dart';

class SessionCompleteScreen extends ConsumerWidget {
  const SessionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(reviewSessionNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final int total = session.correctCount + session.incorrectCount;
    final double accuracy = total > 0 ? (session.correctCount / total) * 100 : 100.0;
    
    // Calculate total duration in seconds
    int durationSeconds = 0;
    if (session.sessionStartTime != null) {
      durationSeconds = DateTime.now().difference(session.sessionStartTime!).inSeconds;
    }

    final String timeStr = '${durationSeconds ~/ 60}:${(durationSeconds % 60).toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Session Finished', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Celebratory Icon block
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 72,
                    color: PremiumDesignSystem.primaryBlue,
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Great Job!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You have completed your review session.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Statistics Card panel
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildStatRow('Accuracy', '${accuracy.toStringAsFixed(1)}%', Colors.green),
                        const Divider(height: 24),
                        _buildStatRow('Time Spent', timeStr, Colors.blue),
                        const Divider(height: 24),
                        _buildStatRow('Correct Items', '${session.correctCount}', Colors.teal),
                        const Divider(height: 24),
                        _buildStatRow('Incorrect Items', '${session.incorrectCount}', Colors.red),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Actions Button stack
                Column(
                  children: [
                    if (session.incorrectItems.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PremiumDesignSystem.secondaryPink,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Review Incorrect Items Only', style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            ref.read(reviewSessionNotifierProvider.notifier).startReviewIncorrectSession();
                            context.pushReplacement('/review/session');
                          },
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                ref.read(reviewSessionNotifierProvider.notifier).restartSession();
                                context.pushReplacement('/review/session');
                              },
                              child: const Text('Restart Session', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PremiumDesignSystem.primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                context.pop(); // returns to Review Home
                              },
                              child: const Text('Finish', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
