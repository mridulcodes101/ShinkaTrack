import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/review/application/review_notifier.dart';

class ReviewSessionScreen extends ConsumerStatefulWidget {
  const ReviewSessionScreen({super.key});

  @override
  ConsumerState<ReviewSessionScreen> createState() => _ReviewSessionScreenState();
}

class _ReviewSessionScreenState extends ConsumerState<ReviewSessionScreen> {
  bool _revealAnswer = false;
  int _secondsElapsed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _submit(String rating) async {
    setState(() {
      _revealAnswer = false;
    });

    final notifier = ref.read(reviewSessionNotifierProvider.notifier);
    await notifier.submitAnswer(rating);

    final state = ref.read(reviewSessionNotifierProvider);
    if (state.isCompleted) {
      _timer?.cancel();
      context.pushReplacement('/review/complete');
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(reviewSessionNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (session.queue.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Review Session')),
        body: const Center(child: Text('No active review session queue.')),
      );
    }

    final currentItem = session.currentItem;
    if (currentItem == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Review Session')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final progressVal = session.queue.isNotEmpty 
        ? session.currentIndex / session.queue.length 
        : 0.0;

    return Scaffold(
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Review Session', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(
              '${session.currentIndex + 1} of ${session.queue.length} items',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${_secondsElapsed ~/ 60}:${(_secondsElapsed % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // progress bar
          LinearProgressIndicator(
            value: progressVal,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
          ),

          // Card viewport area
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500, minHeight: 300),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Type tag
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                currentItem.contentType.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: PremiumDesignSystem.primaryBlue,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Main prompt (the word, pattern or kanji)
                            Text(
                              currentItem.title,
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),

                            // Subtitle context hint (furigana/kana context preview)
                            if (currentItem.preview.isNotEmpty)
                              Text(
                                currentItem.preview,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark ? Colors.white60 : Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            const Divider(height: 48),

                            // Answer Section Reveal
                            if (!_revealAnswer)
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1),
                                    foregroundColor: PremiumDesignSystem.primaryBlue,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  onPressed: () => setState(() => _revealAnswer = true),
                                  child: const Text('Show Answer', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              )
                            else
                              Column(
                                children: [
                                  const Text(
                                    'MEANING / TRANSLATION',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    currentItem.subtitle,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Rating buttons block
          if (_revealAnswer)
            _buildRatingActionButtons(),
        ],
      ),
    );
  }

  Widget _buildRatingActionButtons() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRatingButton('Again', Colors.red, '1d'),
            _buildRatingButton('Hard', Colors.orange, '3d'),
            _buildRatingButton('Good', PremiumDesignSystem.primaryBlue, '7d'),
            _buildRatingButton('Easy', Colors.green, '14d'),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton(String label, Color color, String intervalStr) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 72,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withValues(alpha: 0.15),
              foregroundColor: color,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.zero,
            ),
            onPressed: () => _submit(label),
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ),
        const SizedBox(height: 4),
        Text(intervalStr, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
