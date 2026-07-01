import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shinka_track_n3/core/theme/design_system.dart';

class InteractiveTextSpan {
  final String text;
  final bool isVocab;
  final bool isGrammar;
  final bool isKanji;
  final String? referenceId;

  InteractiveTextSpan({
    required this.text,
    this.isVocab = false,
    this.isGrammar = false,
    this.isKanji = false,
    this.referenceId,
  });
}

class InteractiveText extends StatelessWidget {
  final String text;
  final List<String> vocabIds;
  final List<String> grammarIds;
  final List<String> kanjiIds;
  final Function(String id) onVocabTapped;
  final Function(String id) onGrammarTapped;
  final Function(String id) onKanjiTapped;
  final double fontSize;
  final double lineHeight;
  final bool highlightVocab;
  final bool highlightGrammar;
  final bool highlightKanji;
  final bool showFurigana;

  const InteractiveText({
    super.key,
    required this.text,
    required this.vocabIds,
    required this.grammarIds,
    required this.kanjiIds,
    required this.onVocabTapped,
    required this.onGrammarTapped,
    required this.onKanjiTapped,
    this.fontSize = 16.0,
    this.lineHeight = 1.5,
    this.highlightVocab = true,
    this.highlightGrammar = true,
    this.highlightKanji = true,
    this.showFurigana = true,
  });

  bool _isKanji(String char) {
    if (char.isEmpty) return false;
    final int code = char.codeUnitAt(0);
    return code >= 0x4E00 && code <= 0x9FAF;
  }

  List<InteractiveTextSpan> _parseText() {
    final List<InteractiveTextSpan> spans = [];
    int i = 0;
    
    // Very simple matching algorithm:
    // Check characters one by one. If we match a linked kanji/word/grammar, we group it.
    while (i < text.length) {
      final char = text[i];

      // Check if this single character is in kanjiIds
      if (kanjiIds.contains(char)) {
        spans.add(InteractiveTextSpan(
          text: char,
          isKanji: true,
          referenceId: char,
        ));
        i++;
        continue;
      }

      // Check if it's a kanji character in general
      if (_isKanji(char)) {
        spans.add(InteractiveTextSpan(
          text: char,
          isKanji: true,
          referenceId: char,
        ));
        i++;
        continue;
      }

      // Fallback: check vocabulary/grammar patterns
      // For testing/mocking, if a word matches, we trigger onVocabTapped.
      // Let's check for any of the linked vocabIds/grammarIds as substrings starting at index i
      bool matched = false;
      
      for (final gId in grammarIds) {
        if (text.startsWith(gId, i)) {
          spans.add(InteractiveTextSpan(
            text: gId,
            isGrammar: true,
            referenceId: gId,
          ));
          i += gId.length;
          matched = true;
          break;
        }
      }
      if (matched) continue;

      for (final vId in vocabIds) {
        if (text.startsWith(vId, i)) {
          spans.add(InteractiveTextSpan(
            text: vId,
            isVocab: true,
            referenceId: vId,
          ));
          i += vId.length;
          matched = true;
          break;
        }
      }
      if (matched) continue;

      // Plain character
      spans.add(InteractiveTextSpan(text: char));
      i++;
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final spans = _parseText();

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          height: lineHeight,
          color: isDark ? Colors.white : Colors.black,
        ),
        children: spans.map((span) {
          final isClickable = span.isVocab || span.isGrammar || span.isKanji;
          
          Color? textColor;
          Color? bgColor;
          
          if (span.isVocab && highlightVocab) {
            textColor = PremiumDesignSystem.primaryBlue;
            bgColor = PremiumDesignSystem.primaryBlue.withValues(alpha: 0.1);
          } else if (span.isGrammar && highlightGrammar) {
            textColor = Colors.purple;
            bgColor = Colors.purple.withValues(alpha: 0.1);
          } else if (span.isKanji && highlightKanji) {
            textColor = Colors.teal;
            bgColor = Colors.teal.withValues(alpha: 0.1);
          }

          TapGestureRecognizer? recognizer;
          if (isClickable && span.referenceId != null) {
            recognizer = TapGestureRecognizer()
              ..onTap = () {
                if (span.isVocab) {
                  onVocabTapped(span.referenceId!);
                } else if (span.isGrammar) {
                  onGrammarTapped(span.referenceId!);
                } else if (span.isKanji) {
                  onKanjiTapped(span.referenceId!);
                }
              };
          }

          return TextSpan(
            text: span.text,
            recognizer: recognizer,
            style: TextStyle(
              color: textColor,
              backgroundColor: bgColor,
              fontWeight: isClickable ? FontWeight.bold : FontWeight.normal,
              decoration: isClickable ? TextDecoration.underline : TextDecoration.none,
            ),
          );
        }).toList(),
      ),
    );
  }
}
