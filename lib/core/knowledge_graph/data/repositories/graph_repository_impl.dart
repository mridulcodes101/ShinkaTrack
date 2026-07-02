import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:shinka_track_n3/core/database/database.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_node.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_relationship.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/repositories/graph_repository.dart';

class GraphRepositoryImpl implements GraphRepository {
  final AppDatabase db;

  GraphRepositoryImpl(this.db);

  GraphNode _mapNode(GraphNodeData d) {
    List<String> decodeTags(String? val) {
      if (val == null || val.isEmpty) return [];
      try {
        final decoded = jsonDecode(val);
        if (decoded is List) return decoded.cast<String>();
      } catch (_) {}
      return [];
    }

    return GraphNode(
      id: d.id,
      contentType: d.contentType,
      masterId: d.masterId,
      title: d.title,
      subtitle: d.subtitle ?? '',
      difficulty: d.difficulty ?? 0.0,
      jlpt: d.jlpt ?? 0,
      tags: decodeTags(d.tags),
      createdAt: d.createdAt,
      updatedAt: d.updatedAt,
    );
  }

  GraphRelationship _mapRelationship(GraphRelationshipData r) {
    return GraphRelationship(
      id: r.id,
      sourceNodeId: r.sourceNodeId,
      targetNodeId: r.targetNodeId,
      relationshipType: r.relationshipType,
      weight: r.weight ?? 1.0,
      strength: r.strength ?? 1.0,
      status: r.status ?? 'active',
      createdAt: r.createdAt,
      updatedAt: r.updatedAt,
    );
  }

  @override
  Future<void> saveNode(GraphNode node) async {
    await db.into(db.graphNodes).insertOnConflictUpdate(
      GraphNodesCompanion.insert(
        id: node.id,
        contentType: node.contentType,
        masterId: node.masterId,
        title: node.title,
        subtitle: Value(node.subtitle),
        difficulty: Value(node.difficulty),
        jlpt: Value(node.jlpt),
        tags: Value(jsonEncode(node.tags)),
        createdAt: node.createdAt,
        updatedAt: node.updatedAt,
      ),
    );
  }

  @override
  Future<GraphNode?> getNode(String id) async {
    final query = db.select(db.graphNodes)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapNode(row);
  }

  @override
  Future<GraphNode?> getNodeByMaster(String masterId, String contentType) async {
    final query = db.select(db.graphNodes)
      ..where((tbl) => tbl.masterId.equals(masterId) & tbl.contentType.equals(contentType));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapNode(row);
  }

  @override
  Future<List<GraphNode>> getAllNodes() async {
    final rows = await db.select(db.graphNodes).get();
    return rows.map(_mapNode).toList();
  }

  @override
  Future<void> saveRelationship(GraphRelationship relationship) async {
    await db.into(db.graphRelationships).insertOnConflictUpdate(
      GraphRelationshipsCompanion.insert(
        id: relationship.id,
        sourceNodeId: relationship.sourceNodeId,
        targetNodeId: relationship.targetNodeId,
        relationshipType: relationship.relationshipType,
        weight: Value(relationship.weight),
        strength: Value(relationship.strength),
        status: Value(relationship.status),
        createdAt: relationship.createdAt,
        updatedAt: relationship.updatedAt,
      ),
    );
  }

  @override
  Future<GraphRelationship?> getRelationship(String id) async {
    final query = db.select(db.graphRelationships)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapRelationship(row);
  }

  @override
  Future<List<GraphRelationship>> getOutwardRelationships(String sourceNodeId) async {
    final query = db.select(db.graphRelationships)
      ..where((tbl) => tbl.sourceNodeId.equals(sourceNodeId));
    final rows = await query.get();
    return rows.map(_mapRelationship).toList();
  }

  @override
  Future<List<GraphRelationship>> getInwardRelationships(String targetNodeId) async {
    final query = db.select(db.graphRelationships)
      ..where((tbl) => tbl.targetNodeId.equals(targetNodeId));
    final rows = await query.get();
    return rows.map(_mapRelationship).toList();
  }

  @override
  Future<List<GraphRelationship>> getRelationshipsByType(String type) async {
    final query = db.select(db.graphRelationships)
      ..where((tbl) => tbl.relationshipType.equals(type));
    final rows = await query.get();
    return rows.map(_mapRelationship).toList();
  }

  @override
  Future<List<GraphRelationship>> getAllRelationships() async {
    final rows = await db.select(db.graphRelationships).get();
    return rows.map(_mapRelationship).toList();
  }

  @override
  Future<void> deleteNode(String id) async {
    await (db.delete(db.graphNodes)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<void> deleteRelationship(String id) async {
    await (db.delete(db.graphRelationships)..where((tbl) => tbl.id.equals(id))).go();
  }
}
