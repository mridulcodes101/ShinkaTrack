import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinka_track_n3/features/kanji/application/kanji_notifier.dart';
import 'package:shinka_track_n3/features/vocabulary/application/vocabulary_notifier.dart';
import 'package:shinka_track_n3/features/grammar/application/grammar_notifier.dart';
import 'package:shinka_track_n3/features/reading/application/reading_notifier.dart';
import 'package:shinka_track_n3/features/listening/application/listening_notifier.dart';
import 'package:shinka_track_n3/core/search/domain/models/search_result.dart';
import 'package:shinka_track_n3/core/search/domain/models/search_filter.dart';
import 'package:shinka_track_n3/core/search/domain/repositories/search_repository.dart';
import 'package:shinka_track_n3/core/search/data/repositories/search_repository_impl.dart';
import 'package:shinka_track_n3/core/search/services/universal_search_engine.dart';

// Search Repository Provider
final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final kanjiRepo = ref.watch(kanjiRepositoryProvider);
  final vocabRepo = ref.watch(vocabRepositoryProvider);
  final grammarRepo = ref.watch(grammarRepositoryProvider);
  final readingRepo = ref.watch(readingRepositoryProvider);
  final listeningRepo = ref.watch(listeningRepositoryProvider);

  return SearchRepositoryImpl(
    kanjiRepo: kanjiRepo,
    vocabRepo: vocabRepo,
    grammarRepo: grammarRepo,
    readingRepo: readingRepo,
    listeningRepo: listeningRepo,
  );
});

// Search Engine Provider
final universalSearchEngineProvider = Provider<UniversalSearchEngine>((ref) {
  final repo = ref.watch(searchRepositoryProvider);
  return UniversalSearchEngine(repo);
});

// Search State Providers
final searchQueryProvider = StateProvider<String>((ref) => '');
final searchFilterProvider = StateProvider<SearchFilter>((ref) => const SearchFilter());

// Recent Searches Tracker Notifier
class RecentSearchesNotifier extends StateNotifier<List<String>> {
  RecentSearchesNotifier() : super([]) {
    // Initialise mock or in-memory history
    state = ['kanji', 'grammar', 'particle', 'JLPT', 'vocabulary'];
  }

  void addSearch(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    
    final current = List<String>.from(state)..remove(q);
    current.insert(0, q);
    
    // limit to 10
    if (current.length > 10) {
      current.removeLast();
    }
    state = current;
  }

  void deleteSearch(String query) {
    state = List<String>.from(state)..remove(query);
  }

  void clearAll() {
    state = [];
  }
}

final recentSearchesProvider = StateNotifierProvider<RecentSearchesNotifier, List<String>>((ref) {
  return RecentSearchesNotifier();
});

// Debounced Search Results FutureProvider
final searchResultsProvider = FutureProvider.autoDispose<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final filter = ref.watch(searchFilterProvider);
  final engine = ref.watch(universalSearchEngineProvider);

  if (query.trim().isEmpty) return [];

  // 300 milliseconds debounce
  await Future.delayed(const Duration(milliseconds: 300));
  
  // Register search query into history
  ref.read(recentSearchesProvider.notifier).addSearch(query);

  return engine.search(query: query, filter: filter);
});
