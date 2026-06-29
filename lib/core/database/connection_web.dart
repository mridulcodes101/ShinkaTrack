import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor createConnection() {
  return WebDatabase('shinka_track_n3', logStatements: true);
}
