import 'package:flutter/material.dart';
import 'package:shinka_track_n3/features/study/domain/entities/study_entities.dart';

/// Spaced Repetition System (SRS) service contract.
abstract class SrsEngineService {
  /// Computes the next scheduled review date and updates ease factor based on quality grade (0-5).
  KanjiEntity calculateNextReview(KanjiEntity kanji, int qualityGrade);
}

/// Writing practice and handwriting drawing recognition contract.
abstract class DrawingRecognitionService {
  /// Recognizes a list of drawn strokes (each stroke is a list of points/offsets)
  /// and returns a confidence score (0.0 to 1.0) compared to the correct Kanji stroke template.
  Future<double> recognizeStroke({
    required String kanji,
    required List<List<Offset>> userStrokes,
  });
}

/// Jisho external dictionary API service contract.
abstract class JishoIntegrationService {
  /// Fetches external definitions, details, and parts-of-speech for a Kanji character.
  Future<Map<String, dynamic>> fetchKanjiDetails(String kanji);
}

/// Pronunciation and Pitch Accent service contract.
abstract class PronunciationService {
  /// Returns pitch accent structure/patterns (e.g., Atama-taka, Heiban) for the Kanji/Vocab reading.
  List<String> getPitchAccent(String text);

  /// Plays synthesized/recorded native speaker audio for the Kanji reading.
  Future<void> playAudio(String audioPath);
}

/// Export & Import service contract for backups and sharing.
abstract class ExportImportService {
  /// Exports active Kanji list data to CSV formatted string.
  String exportToCsv(List<KanjiEntity> list);

  /// Imports and parses Kanji data from a CSV formatted string.
  List<KanjiEntity> importFromCsv(String csvContent);

  /// Generates a binary or JSON zip backup of all database entities.
  Future<List<int>> generateBackupPayload();

  /// Restores database entities from a backup payload.
  Future<void> restoreBackupPayload(List<int> backupData);
}

/// Cloud synchronization service contract.
abstract class CloudSyncService {
  /// Uploads local modifications to the cloud database and fetches remote updates.
  Future<void> syncWithCloud();

  /// Resolves entity merge conflicts during sync operations.
  KanjiEntity resolveConflict(KanjiEntity local, KanjiEntity remote);
}
