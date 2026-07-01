import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';
import 'package:shinka_track_n3/features/listening/application/listening_notifier.dart';
import 'package:shinka_track_n3/features/listening/domain/models/listening_model.dart';
import 'package:shinka_track_n3/features/listening/presentation/screens/lesson_details_screen.dart';

class ListeningPlayerScreen extends ConsumerStatefulWidget {
  final String lessonId;
  const ListeningPlayerScreen({super.key, required this.lessonId});

  @override
  ConsumerState<ListeningPlayerScreen> createState() => _ListeningPlayerScreenState();
}

class _ListeningPlayerScreenState extends ConsumerState<ListeningPlayerScreen> {
  // Player state mockup parameters
  bool _isPlaying = false;
  double _elapsedSeconds = 0.0;
  double _playbackSpeed = 1.0;
  String _loopMode = 'Entire Lesson'; // Entire Lesson, Current Sentence, Current Selection
  bool _shadowingMode = false;
  
  // Settings values
  bool _showTranscript = true;
  bool _showTranslation = false;
  bool _autoScroll = true;
  bool _highlightCurrentSentence = true;
  bool _highlightVocab = true;
  bool _highlightGrammar = true;
  bool _highlightKanji = true;

  Timer? _playbackTimer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _timestampBookmarks = [];

  // Shadowing state overlay triggers
  bool _isWaitingForUserShadowing = false;

  void _startTimer(double duration) {
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(Duration(milliseconds: (200 / _playbackSpeed).toInt()), (timer) {
      if (mounted && _isPlaying && !_isWaitingForUserShadowing) {
        setState(() {
          // Increment elapsed time
          _elapsedSeconds += 0.2;
          
          // Shadowing Mode sentence boundary logic
          // Let's divide transcription into 4 sentences. If lesson is e.g. 60 seconds, boundaries at 15s, 30s, 45s.
          final int boundaryInterval = (duration / 4).toInt();
          if (_shadowingMode && _elapsedSeconds > 0 && (_elapsedSeconds.toInt() % boundaryInterval == 0) && (_elapsedSeconds - _elapsedSeconds.toInt() < 0.3)) {
            _isWaitingForUserShadowing = true;
            _isPlaying = false;
          }

          if (_elapsedSeconds >= duration) {
            _elapsedSeconds = duration;
            _isPlaying = false;
            _playbackTimer?.cancel();
            _triggerCompletion();
          }
        });
      }
    });
  }

  void _togglePlayPause(double duration) {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startTimer(duration);
      } else {
        _playbackTimer?.cancel();
      }
    });
  }

  void _skip(double delta, double duration) {
    setState(() {
      _elapsedSeconds += delta;
      if (_elapsedSeconds < 0) _elapsedSeconds = 0;
      if (_elapsedSeconds > duration) _elapsedSeconds = duration;
    });
  }

  String _formatDuration(double seconds) {
    final int mins = seconds ~/ 60;
    final int secs = (seconds % 60).toInt();
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  void _showVocabSheet(String vocabId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vocabId, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Meaning:佐藤 Sato (common surname)', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Add to Collection'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Open Vocabulary'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGrammarSheet(String grammarId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(grammarId, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Meaning: task or request indicator', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Open Grammar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showKanjiSheet(String kanjiChar) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(kanjiChar, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Meaning: 佐 support; assist', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Open Kanji'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _triggerCompletion() {
    final asyncData = ref.read(listeningDetailsProvider(widget.lessonId));
    asyncData.whenData((model) {
      if (model != null) {
        // Complete study status persistence
        ref.read(listeningLibraryNotifierProvider.notifier).updateStudyStatus(model.spec.id, 'completed');
        ref.invalidate(userListeningCollectionProvider);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.stars, color: Colors.green, size: 28),
                SizedBox(width: 8),
                Text('Lesson Completed!', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Congratulations! You finished "${model.spec.title}".'),
                const SizedBox(height: 16),
                _buildCompletionRow('Listening Time', _formatDuration(model.spec.duration)),
                _buildCompletionRow('Vocabulary Covered', '${model.spec.vocabularyReferences.length} items'),
                _buildCompletionRow('Grammar Covered', '${model.spec.grammarReferences.length} items'),
                _buildCompletionRow('Kanji Covered', '${model.spec.kanjiReferences.length} items'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _elapsedSeconds = 0.0;
                    _isPlaying = true;
                    _startTimer(model.spec.duration);
                  });
                },
                child: const Text('Replay'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: PremiumDesignSystem.primaryBlue, foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                  context.pop();
                },
                child: const Text('Finish'),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _buildCompletionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(listeningDetailsProvider(widget.lessonId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? PremiumDesignSystem.deepSlate : PremiumDesignSystem.backgroundLight,
      appBar: AppBar(
        title: const Text('Listening Player', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Player Settings',
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: _buildSettingsDrawer(),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading lesson: $err')),
        data: (model) {
          if (model == null) {
            return const Center(child: Text('Listening lesson not found'));
          }

          // Trigger reading status if unlearned
          if (model.status == 'unlearned') {
            ref.read(listeningLibraryNotifierProvider.notifier).updateStudyStatus(model.spec.id, 'reading');
          }

          final sentences = model.spec.transcript.split(RegExp(r'[。\n]')).where((s) => s.trim().isNotEmpty).toList();
          final int totalSentences = sentences.length;
          
          // Compute current sentence index based on progress
          int activeSentenceIndex = 0;
          if (totalSentences > 0) {
            activeSentenceIndex = ((_elapsedSeconds / model.spec.duration) * totalSentences).toInt();
            if (activeSentenceIndex >= totalSentences) {
              activeSentenceIndex = totalSentences - 1;
            }
          }

          return Column(
            children: [
              // Playback Progress indicator line
              LinearProgressIndicator(
                value: _elapsedSeconds / model.spec.duration,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(PremiumDesignSystem.primaryBlue),
              ),

              // Shadowing Mode Repeating Prompt overlay
              if (_isWaitingForUserShadowing)
                Container(
                  color: Colors.amber.withValues(alpha: 0.2),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(Icons.record_voice_over, color: Colors.amber),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Shadowing Mode: Repeat the sentence, then tap Continue.',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black87),
                        onPressed: () {
                          setState(() {
                            _isWaitingForUserShadowing = false;
                            _isPlaying = true;
                            _startTimer(model.spec.duration);
                          });
                        },
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                ),

              // Interactive Transcript Block
              Expanded(
                child: _showTranscript 
                    ? ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: sentences.length,
                        itemBuilder: (context, index) {
                          final sentence = sentences[index].trim();
                          final isActive = _highlightCurrentSentence && (index == activeSentenceIndex);

                          return InkWell(
                            onTap: () {
                              setState(() {
                                // Jump playback to sentence timestamp segment
                                final double segmentTime = (model.spec.duration / totalSentences) * index;
                                _elapsedSeconds = segmentTime;
                                _isWaitingForUserShadowing = false;
                                if (!_isPlaying) {
                                  _isPlaying = true;
                                  _startTimer(model.spec.duration);
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isActive 
                                    ? PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1) 
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: isActive 
                                    ? Border.all(color: PremiumDesignSystem.primaryBlue.withValues(alpha: 0.3)) 
                                    : null,
                              ),
                              child: Text(
                                sentence,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                  color: isActive 
                                      ? PremiumDesignSystem.primaryBlue 
                                      : (isDark ? Colors.white70 : Colors.black87),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('Transcript Hidden. Focus on listening!', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey))),
              ),

              // Player Controls Area
              _buildPlayerControlsSection(model),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayerControlsSection(ListeningModel model) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? PremiumDesignSystem.surfaceDark : Colors.white,
        boxShadow: PremiumDesignSystem.premiumShadow,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Progress Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_elapsedSeconds), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Expanded(
                  child: Slider(
                    value: _elapsedSeconds,
                    max: model.spec.duration,
                    activeColor: PremiumDesignSystem.primaryBlue,
                    onChanged: (val) {
                      setState(() {
                        _elapsedSeconds = val;
                        _isWaitingForUserShadowing = false;
                      });
                    },
                  ),
                ),
                Text(_formatDuration(model.spec.duration - _elapsedSeconds), style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),

            // Controls buttons (Previous, Skip Back, Play/Pause, Skip Forward, Next)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous_rounded, size: 28),
                  onPressed: () => setState(() => _elapsedSeconds = 0.0),
                ),
                IconButton(
                  icon: const Icon(Icons.replay_5_rounded, size: 28),
                  onPressed: () => _skip(-5, model.spec.duration),
                ),
                // Play/Pause circular button (Touch target 48dp min)
                Semantics(
                  label: _isPlaying ? 'Pause' : 'Play',
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: PremiumDesignSystem.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () => _togglePlayPause(model.spec.duration),
                      child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 32),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_5_rounded, size: 28),
                  onPressed: () => _skip(5, model.spec.duration),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded, size: 28),
                  onPressed: () => setState(() => _elapsedSeconds = model.spec.duration),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Playback Options (Speed, Loop, Shadowing Toggle)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Speed selection dropdown
                Row(
                  children: [
                    const Icon(Icons.speed, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    DropdownButton<double>(
                      value: _playbackSpeed,
                      underline: const SizedBox.shrink(),
                      style: TextStyle(fontSize: 13, color: isDark ? Colors.white : Colors.black87),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _playbackSpeed = val;
                            if (_isPlaying) {
                              _startTimer(model.spec.duration);
                            }
                          });
                        }
                      },
                      items: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((sp) {
                        return DropdownMenuItem<double>(
                          value: sp,
                          child: Text('${sp}x'),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                // Loop selection button
                TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(Icons.loop, size: 16),
                  label: Text(_loopMode, style: const TextStyle(fontSize: 12)),
                  onPressed: () {
                    final modes = ['Entire Lesson', 'Current Sentence', 'Current Selection'];
                    final idx = (modes.indexOf(_loopMode) + 1) % modes.length;
                    setState(() => _loopMode = modes[idx]);
                  },
                ),

                // Bookmark / Shadowing mode triggers
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.bookmark_add_outlined, size: 20, color: isDark ? Colors.white60 : Colors.black54),
                      tooltip: 'Bookmark current timestamp',
                      onPressed: () {
                        final ts = _formatDuration(_elapsedSeconds);
                        _timestampBookmarks.add(ts);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Bookmarked timestamp $ts'), duration: const Duration(seconds: 1)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _shadowingMode ? Icons.record_voice_over : Icons.record_voice_over_outlined,
                        size: 20,
                        color: _shadowingMode ? Colors.amber : (isDark ? Colors.white60 : Colors.black54),
                      ),
                      tooltip: 'Shadowing Mode Toggle',
                      onPressed: () {
                        setState(() {
                          _shadowingMode = !_shadowingMode;
                          _isWaitingForUserShadowing = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_shadowingMode ? 'Shadowing Mode Enabled: Audio pauses after sentences.' : 'Shadowing Mode Disabled'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsDrawer() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            const Text('Player Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 24),

            SwitchListTile(
              title: const Text('Show Transcript', style: TextStyle(fontSize: 14)),
              value: _showTranscript,
              onChanged: (val) => setState(() => _showTranscript = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Show English Translation', style: TextStyle(fontSize: 14)),
              value: _showTranslation,
              onChanged: (val) => setState(() => _showTranslation = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Auto Scroll Transcript', style: TextStyle(fontSize: 14)),
              value: _autoScroll,
              onChanged: (val) => setState(() => _autoScroll = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Current Sentence', style: TextStyle(fontSize: 14)),
              value: _highlightCurrentSentence,
              onChanged: (val) => setState(() => _highlightCurrentSentence = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Vocabulary', style: TextStyle(fontSize: 14)),
              value: _highlightVocab,
              onChanged: (val) => setState(() => _highlightVocab = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Grammar', style: TextStyle(fontSize: 14)),
              value: _highlightGrammar,
              onChanged: (val) => setState(() => _highlightGrammar = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Highlight Kanji', style: TextStyle(fontSize: 14)),
              value: _highlightKanji,
              onChanged: (val) => setState(() => _highlightKanji = val),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
