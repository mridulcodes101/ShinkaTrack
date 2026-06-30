import '../models/kanji_spec.dart';
import '../models/vocabulary_spec.dart';
import '../models/grammar_spec.dart';
import '../models/reading_spec.dart';
import '../models/listening_spec.dart';

class ValidationError {
  final String itemType; // 'kanji', 'vocabulary', 'grammar', 'reading', 'listening'
  final String itemId;
  final String field;
  final String message;

  const ValidationError({
    required this.itemType,
    required this.itemId,
    required this.field,
    required this.message,
  });

  @override
  String toString() => '[$itemType ID:$itemId] Field "$field": $message';
}

class ValidationResult {
  final List<ValidationError> errors;

  bool get isValid => errors.isEmpty;

  const ValidationResult(this.errors);
}

class ContentValidator {
  static ValidationResult validate({
    required List<KanjiSpec> kanjis,
    required List<VocabularySpec> vocabularies,
    required List<GrammarSpec> grammars,
    required List<ReadingSpec> readings,
    required List<ListeningSpec> listenings,
  }) {
    final List<ValidationError> errors = [];

    // Helper sets for uniqueness checks
    final Set<String> allIds = {};
    final Set<String> allKanjiChars = {};
    final Set<String> allVocabWords = {};

    // Helper maps for reference checks
    final Map<String, KanjiSpec> kanjiMap = {};
    final Map<String, VocabularySpec> vocabMap = {};
    final Map<String, GrammarSpec> grammarMap = {};

    // --- 1. Presence, Uniqueness, and Internal consistency validation ---

    // 1.1 Kanji Validation
    for (var k in kanjis) {
      // Uniqueness checks
      if (k.id.isEmpty) {
        errors.add(const ValidationError(itemType: 'kanji', itemId: 'unknown', field: 'id', message: 'ID cannot be empty'));
      } else if (allIds.contains(k.id)) {
        errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'id', message: 'Duplicate ID: ${k.id}'));
      } else {
        allIds.add(k.id);
        kanjiMap[k.id] = k;
      }

      if (k.character.isEmpty) {
        errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'character', message: 'Kanji character cannot be empty'));
      } else if (allKanjiChars.contains(k.character)) {
        errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'character', message: 'Duplicate Kanji character: ${k.character}'));
      } else {
        allKanjiChars.add(k.character);
      }

      // Presence rules
      if (k.meaning.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'meaning', message: 'Meaning cannot be empty'));
      }
      if (k.jlptLevel <= 0 || k.jlptLevel > 5) {
        errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'jlptLevel', message: 'JLPT level must be between 1 and 5'));
      }
      if (k.strokeCount <= 0) {
        errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'strokeCount', message: 'Stroke count must be greater than 0'));
      }
    }

    // 1.2 Vocabulary Validation
    for (var v in vocabularies) {
      if (v.id.isEmpty) {
        errors.add(const ValidationError(itemType: 'vocabulary', itemId: 'unknown', field: 'id', message: 'ID cannot be empty'));
      } else if (allIds.contains(v.id)) {
        errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'id', message: 'Duplicate ID: ${v.id}'));
      } else {
        allIds.add(v.id);
        vocabMap[v.id] = v;
      }

      if (v.word.isEmpty) {
        errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'word', message: 'Word cannot be empty'));
      } else if (allVocabWords.contains(v.word)) {
        errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'word', message: 'Duplicate Vocabulary word: ${v.word}'));
      } else {
        allVocabWords.add(v.word);
      }

      // Presence rules
      if (v.meaning.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'meaning', message: 'Meaning cannot be empty'));
      }
      if (v.kana.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'kana', message: 'Kana/reading cannot be empty'));
      }
      if (v.jlpt <= 0 || v.jlpt > 5) {
        errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'jlpt', message: 'JLPT level must be between 1 and 5'));
      }
    }

    // 1.3 Grammar Validation
    for (var g in grammars) {
      if (g.id.isEmpty) {
        errors.add(const ValidationError(itemType: 'grammar', itemId: 'unknown', field: 'id', message: 'ID cannot be empty'));
      } else if (allIds.contains(g.id)) {
        errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'id', message: 'Duplicate ID: ${g.id}'));
      } else {
        allIds.add(g.id);
        grammarMap[g.id] = g;
      }

      // Presence rules
      if (g.grammarPattern.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'grammarPattern', message: 'Grammar pattern cannot be empty'));
      }
      if (g.meaning.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'meaning', message: 'Meaning cannot be empty'));
      }
      if (g.formation.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'formation', message: 'Formation cannot be empty'));
      }
      if (g.examples.isEmpty) {
        errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'examples', message: 'At least one example sentence is required'));
      } else {
        for (int i = 0; i < g.examples.length; i++) {
          final ex = g.examples[i];
          if (ex.japanese.trim().isEmpty) {
            errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'examples[$i].japanese', message: 'Example Japanese text cannot be empty'));
          }
          if (ex.english.trim().isEmpty) {
            errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'examples[$i].english', message: 'Example English translation cannot be empty'));
          }
        }
      }
    }

    // 1.4 Reading Validation
    for (var r in readings) {
      if (r.id.isEmpty) {
        errors.add(const ValidationError(itemType: 'reading', itemId: 'unknown', field: 'id', message: 'ID cannot be empty'));
      } else if (allIds.contains(r.id)) {
        errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'id', message: 'Duplicate ID: ${r.id}'));
      } else {
        allIds.add(r.id);
      }

      // Presence rules
      if (r.title.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'title', message: 'Title cannot be empty'));
      }
      if (r.passage.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'passage', message: 'Passage text cannot be empty'));
      }
      if (r.translation.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'translation', message: 'Translation text cannot be empty'));
      }
      if (r.questions.isEmpty) {
        errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'questions', message: 'At least one question is required'));
      } else {
        for (int i = 0; i < r.questions.length; i++) {
          final q = r.questions[i];
          if (q.id.trim().isEmpty) {
            errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'questions[$i].id', message: 'Question ID cannot be empty'));
          }
          if (q.questionText.trim().isEmpty) {
            errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'questions[$i].questionText', message: 'Question text cannot be empty'));
          }
          if (q.options.length < 2) {
            errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'questions[$i].options', message: 'Question must have at least 2 options'));
          }
          if (q.correctOptionIndex < 0 || q.correctOptionIndex >= q.options.length) {
            errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'questions[$i].correctOptionIndex', message: 'Correct option index out of bounds'));
          }
        }
      }
    }

    // 1.5 Listening Validation
    for (var l in listenings) {
      if (l.id.isEmpty) {
        errors.add(const ValidationError(itemType: 'listening', itemId: 'unknown', field: 'id', message: 'ID cannot be empty'));
      } else if (allIds.contains(l.id)) {
        errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'id', message: 'Duplicate ID: ${l.id}'));
      } else {
        allIds.add(l.id);
      }

      // Presence rules
      if (l.title.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'title', message: 'Title cannot be empty'));
      }
      if (l.transcript.trim().isEmpty) {
        errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'transcript', message: 'Transcript cannot be empty'));
      }
      if (l.duration <= 0) {
        errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'duration', message: 'Duration must be greater than 0'));
      }
    }


    // --- 2. Reference Integrity Validation ---

    // 2.1 Kanji References
    for (var k in kanjis) {
      for (var rId in k.relatedKanji) {
        if (!kanjiMap.containsKey(rId)) {
          errors.add(ValidationError(itemType: 'kanji', itemId: k.id, field: 'relatedKanji', message: 'Broken reference: Kanji ID "$rId" does not exist'));
        }
      }
    }

    // 2.2 Vocabulary References
    for (var v in vocabularies) {
      for (var kId in v.kanjiUsed) {
        if (!kanjiMap.containsKey(kId)) {
          errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'kanjiUsed', message: 'Broken reference: Kanji ID "$kId" does not exist'));
        }
      }
      for (var gId in v.relatedGrammar) {
        if (!grammarMap.containsKey(gId)) {
          errors.add(ValidationError(itemType: 'vocabulary', itemId: v.id, field: 'relatedGrammar', message: 'Broken reference: Grammar ID "$gId" does not exist'));
        }
      }
    }

    // 2.3 Grammar References
    for (var g in grammars) {
      for (var kId in g.relatedKanji) {
        if (!kanjiMap.containsKey(kId)) {
          errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'relatedKanji', message: 'Broken reference: Kanji ID "$kId" does not exist'));
        }
      }
      for (var vId in g.relatedVocabulary) {
        if (!vocabMap.containsKey(vId)) {
          errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'relatedVocabulary', message: 'Broken reference: Vocabulary ID "$vId" does not exist'));
        }
      }
      for (var grId in g.relatedGrammar) {
        if (!grammarMap.containsKey(grId)) {
          errors.add(ValidationError(itemType: 'grammar', itemId: g.id, field: 'relatedGrammar', message: 'Broken reference: Grammar ID "$grId" does not exist'));
        }
      }
    }

    // 2.4 Reading References
    for (var r in readings) {
      for (var kId in r.kanjiReferences) {
        if (!kanjiMap.containsKey(kId)) {
          errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'kanjiReferences', message: 'Broken reference: Kanji ID "$kId" does not exist'));
        }
      }
      for (var vId in r.vocabularyReferences) {
        if (!vocabMap.containsKey(vId)) {
          errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'vocabularyReferences', message: 'Broken reference: Vocabulary ID "$vId" does not exist'));
        }
      }
      for (var gId in r.grammarReferences) {
        if (!grammarMap.containsKey(gId)) {
          errors.add(ValidationError(itemType: 'reading', itemId: r.id, field: 'grammarReferences', message: 'Broken reference: Grammar ID "$gId" does not exist'));
        }
      }
    }

    // 2.5 Listening References
    for (var l in listenings) {
      for (var kId in l.kanjiReferences) {
        if (!kanjiMap.containsKey(kId)) {
          errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'kanjiReferences', message: 'Broken reference: Kanji ID "$kId" does not exist'));
        }
      }
      for (var vId in l.vocabularyReferences) {
        if (!vocabMap.containsKey(vId)) {
          errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'vocabularyReferences', message: 'Broken reference: Vocabulary ID "$vId" does not exist'));
        }
      }
      for (var gId in l.grammarReferences) {
        if (!grammarMap.containsKey(gId)) {
          errors.add(ValidationError(itemType: 'listening', itemId: l.id, field: 'grammarReferences', message: 'Broken reference: Grammar ID "$gId" does not exist'));
        }
      }
    }

    return ValidationResult(errors);
  }
}
