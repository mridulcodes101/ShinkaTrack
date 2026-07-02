import 'package:shinka_track_n3/core/search/domain/models/search_result.dart';
import 'package:shinka_track_n3/core/search/domain/models/search_filter.dart';
import 'package:shinka_track_n3/core/search/domain/repositories/search_repository.dart';

class UniversalSearchEngine {
  final SearchRepository repository;

  UniversalSearchEngine(this.repository);

  // Score match types
  double _calculateScore(String query, String text, String alternative, String translation) {
    final q = query.trim().toLowerCase();
    final t = text.trim().toLowerCase();
    final alt = alternative.trim().toLowerCase();
    final trans = translation.trim().toLowerCase();

    if (t == q || alt == q) return 100.0;
    if (t.startsWith(q) || alt.startsWith(q)) return 80.0;
    if (t.contains(q) || alt.contains(q)) return 60.0;
    if (trans.contains(q)) return 50.0;
    return 0.0;
  }

  String _mapDifficulty(double difficulty) {
    if (difficulty >= 2.5) return 'Hard';
    if (difficulty >= 1.5) return 'Medium';
    return 'Easy';
  }

  Future<List<SearchResult>> search({
    required String query,
    required SearchFilter filter,
  }) async {
    final List<SearchResult> results = [];
    final q = query.trim();
    if (q.isEmpty) return [];

    final types = filter.contentTypes.isEmpty 
        ? ['kanji', 'vocab', 'grammar', 'reading', 'listening'] 
        : filter.contentTypes;

    // 1. Query Kanji
    if (types.contains('kanji')) {
      final matches = await repository.searchKanjis(q);
      for (var m in matches) {
        final score = _calculateScore(
          q, 
          m.spec.character, 
          m.spec.kunyomi.join(' '), 
          m.spec.meaning,
        );
        if (score > 0) {
          results.add(SearchResult(
            id: m.spec.id,
            contentType: 'kanji',
            primaryTitle: m.spec.character,
            secondaryTitle: m.spec.meaning,
            preview: m.spec.onyomi.isNotEmpty ? 'Onyomi: ${m.spec.onyomi.join(", ")}' : '',
            icon: 'menu_book',
            jlpt: m.spec.jlptLevel,
            difficulty: _mapDifficulty(m.spec.difficulty),
            route: '/kanji/details/${m.spec.id}',
            searchScore: score,
          ));
        }
      }
    }

    // 2. Query Vocabulary
    if (types.contains('vocab')) {
      final matches = await repository.searchVocabularies(q);
      for (var m in matches) {
        final score = _calculateScore(q, m.spec.word, m.spec.kana, m.spec.meaning);
        if (score > 0) {
          results.add(SearchResult(
            id: m.spec.id,
            contentType: 'vocab',
            primaryTitle: m.spec.word,
            secondaryTitle: m.spec.meaning,
            preview: m.spec.kana,
            icon: 'translate',
            jlpt: m.spec.jlpt,
            difficulty: _mapDifficulty(m.spec.difficulty),
            route: '/vocab/details/${m.spec.id}',
            searchScore: score,
          ));
        }
      }
    }

    // 3. Query Grammar
    if (types.contains('grammar')) {
      final matches = await repository.searchGrammars(q);
      for (var m in matches) {
        final score = _calculateScore(q, m.spec.grammarPattern, m.spec.formation, m.spec.meaning);
        if (score > 0) {
          results.add(SearchResult(
            id: m.spec.id,
            contentType: 'grammar',
            primaryTitle: m.spec.grammarPattern,
            secondaryTitle: m.spec.meaning,
            preview: m.spec.formation,
            icon: 'g_translate',
            jlpt: m.spec.jlpt,
            difficulty: _mapDifficulty(m.spec.difficulty),
            route: '/grammar/details/${m.spec.id}',
            searchScore: score,
          ));
        }
      }
    }

    // 4. Query Reading
    if (types.contains('reading')) {
      final matches = await repository.searchReadings(q);
      for (var m in matches) {
        final score = _calculateScore(q, m.spec.title, '', m.spec.passage);
        if (score > 0) {
          results.add(SearchResult(
            id: m.spec.id,
            contentType: 'reading',
            primaryTitle: m.spec.title,
            secondaryTitle: 'Passage',
            preview: m.spec.passage.substring(0, m.spec.passage.length.clamp(0, 60)),
            icon: 'chrome_reader_mode',
            jlpt: m.spec.jlpt,
            difficulty: _mapDifficulty(m.spec.difficulty),
            route: '/reading/details/${m.spec.id}',
            searchScore: score,
          ));
        }
      }
    }

    // 5. Query Listening
    if (types.contains('listening')) {
      final matches = await repository.searchListenings(q);
      for (var m in matches) {
        final score = _calculateScore(q, m.spec.title, '', m.spec.transcript);
        if (score > 0) {
          results.add(SearchResult(
            id: m.spec.id,
            contentType: 'listening',
            primaryTitle: m.spec.title,
            secondaryTitle: 'Listening Lesson',
            preview: m.spec.transcript.substring(0, m.spec.transcript.length.clamp(0, 60)),
            icon: 'audiotrack',
            jlpt: m.spec.jlpt,
            difficulty: _mapDifficulty(m.spec.difficulty),
            route: '/listening/details/${m.spec.id}',
            searchScore: score,
          ));
        }
      }
    }

    // Apply Filter Dials
    Iterable<SearchResult> filtered = results;
    if (filter.jlptLevels.isNotEmpty) {
      filtered = filtered.where((r) => filter.jlptLevels.contains(r.jlpt));
    }
    if (filter.difficulties.isNotEmpty) {
      filtered = filtered.where((r) => filter.difficulties.contains(r.difficulty));
    }

    final List<SearchResult> finalResults = filtered.toList();

    // Sorting algorithm
    if (filter.sortBy == 'alphabetical') {
      finalResults.sort((a, b) => a.primaryTitle.compareTo(b.primaryTitle));
    } else {
      // default: relevance score descending
      finalResults.sort((a, b) => b.searchScore.compareTo(a.searchScore));
    }

    return finalResults;
  }
}
