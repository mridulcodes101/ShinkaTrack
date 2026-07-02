import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_node.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_relationship.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/repositories/graph_repository.dart';
import 'package:shinka_track_n3/core/knowledge_graph/services/knowledge_graph_engine.dart';

class InMemoryGraphRepository implements GraphRepository {
  final Map<String, GraphNode> nodes = {};
  final Map<String, GraphRelationship> relationships = {};

  @override
  Future<void> saveNode(GraphNode node) async {
    nodes[node.id] = node;
  }

  @override
  Future<GraphNode?> getNode(String id) async {
    return nodes[id];
  }

  @override
  Future<GraphNode?> getNodeByMaster(String masterId, String contentType) async {
    for (var node in nodes.values) {
      if (node.masterId == masterId && node.contentType == contentType) {
        return node;
      }
    }
    return null;
  }

  @override
  Future<List<GraphNode>> getAllNodes() async {
    return nodes.values.toList();
  }

  @override
  Future<void> saveRelationship(GraphRelationship relationship) async {
    relationships[relationship.id] = relationship;
  }

  @override
  Future<GraphRelationship?> getRelationship(String id) async {
    return relationships[id];
  }

  @override
  Future<List<GraphRelationship>> getOutwardRelationships(String sourceNodeId) async {
    return relationships.values
        .where((r) => r.sourceNodeId == sourceNodeId && r.status == 'active')
        .toList();
  }

  @override
  Future<List<GraphRelationship>> getInwardRelationships(String targetNodeId) async {
    return relationships.values
        .where((r) => r.targetNodeId == targetNodeId && r.status == 'active')
        .toList();
  }

  @override
  Future<List<GraphRelationship>> getRelationshipsByType(String type) async {
    return relationships.values.where((r) => r.relationshipType == type).toList();
  }

  @override
  Future<List<GraphRelationship>> getAllRelationships() async {
    return relationships.values.toList();
  }

  @override
  Future<void> deleteNode(String id) async {
    nodes.remove(id);
    relationships.removeWhere((key, r) => r.sourceNodeId == id || r.targetNodeId == id);
  }

  @override
  Future<void> deleteRelationship(String id) async {
    relationships.remove(id);
  }
}

void main() {
  late InMemoryGraphRepository repository;
  late KnowledgeGraphEngine engine;

  setUp(() {
    repository = InMemoryGraphRepository();
    engine = KnowledgeGraphEngine(repository);
  });

  group('SPEC-014: Knowledge Graph Engine Tests', () {
    test('Register node correctly maps properties and saves', () async {
      final node = GraphNode(
        id: 'kanji_k1',
        contentType: 'kanji',
        masterId: 'k1',
        title: '水',
        subtitle: 'Water',
        difficulty: 1.0,
        jlpt: 5,
        tags: ['nature'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerNode(node);
      final fetched = await repository.getNode('kanji_k1');
      expect(fetched, isNotNull);
      expect(fetched!.title, '水');
    });

    test('Prevent registering duplicate nodes', () async {
      final node = GraphNode(
        id: 'kanji_k1',
        contentType: 'kanji',
        masterId: 'k1',
        title: '水',
        subtitle: 'Water',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerNode(node);
      expect(() => engine.registerNode(node), throwsArgumentError);
    });

    test('Prevent registering relationships with invalid nodes', () async {
      final rel = GraphRelationship(
        id: 'r1',
        sourceNodeId: 'kanji_k1',
        targetNodeId: 'vocab_v1',
        relationshipType: 'USES',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(() => engine.registerRelationship(rel), throwsArgumentError);
    });

    test('Prevent duplicate relationships', () async {
      final n1 = GraphNode(
        id: 'n1',
        contentType: 'kanji',
        masterId: 'k1',
        title: '水',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final n2 = GraphNode(
        id: 'n2',
        contentType: 'vocab',
        masterId: 'v1',
        title: '水曜日',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerNode(n1);
      await engine.registerNode(n2);

      final rel = GraphRelationship(
        id: 'rel1',
        sourceNodeId: 'n1',
        targetNodeId: 'n2',
        relationshipType: 'USES',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerRelationship(rel);
      expect(() => engine.registerRelationship(rel), throwsArgumentError);
    });

    test('Circular self-link validation works', () async {
      final n1 = GraphNode(
        id: 'n1',
        contentType: 'kanji',
        masterId: 'k1',
        title: '水',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await engine.registerNode(n1);

      final rel = GraphRelationship(
        id: 'rel1',
        sourceNodeId: 'n1',
        targetNodeId: 'n1',
        relationshipType: 'PREREQUISITE',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(() => engine.registerRelationship(rel), throwsArgumentError);
    });

    test('Circular prerequisite dependencies cycle check works', () async {
      final n1 = GraphNode(
        id: 'n1',
        contentType: 'vocab',
        masterId: 'v1',
        title: 'Word 1',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final n2 = GraphNode(
        id: 'n2',
        contentType: 'vocab',
        masterId: 'v2',
        title: 'Word 2',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerNode(n1);
      await engine.registerNode(n2);

      // n1 is prerequisite for n2
      await engine.registerRelationship(GraphRelationship(
        id: 'r12',
        sourceNodeId: 'n1',
        targetNodeId: 'n2',
        relationshipType: 'PREREQUISITE',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      // Attempting to make n2 prerequisite for n1 should fail due to cycle
      final rel21 = GraphRelationship(
        id: 'r21',
        sourceNodeId: 'n2',
        targetNodeId: 'n1',
        relationshipType: 'PREREQUISITE',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(() => engine.registerRelationship(rel21), throwsArgumentError);
    });

    test('Traversals find connected vocabulary, grammar, and reading', () async {
      final kanji = GraphNode(
        id: 'k1',
        contentType: 'kanji',
        masterId: 'm1',
        title: '木',
        subtitle: 'Tree',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final vocab = GraphNode(
        id: 'v1',
        contentType: 'vocab',
        masterId: 'mv1',
        title: '木々',
        subtitle: 'Trees',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerNode(kanji);
      await engine.registerNode(vocab);

      await engine.registerRelationship(GraphRelationship(
        id: 'kv',
        sourceNodeId: 'k1',
        targetNodeId: 'v1',
        relationshipType: 'USES',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      final connectedVocab = await engine.getConnectedVocabulary('k1');
      expect(connectedVocab.length, 1);
      expect(connectedVocab.first.id, 'v1');
    });

    test('BFS shortest path finds correct sequence', () async {
      final n1 = GraphNode(
        id: 'a',
        contentType: 'kanji',
        masterId: '1',
        title: 'A',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final n2 = GraphNode(
        id: 'b',
        contentType: 'vocab',
        masterId: '2',
        title: 'B',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final n3 = GraphNode(
        id: 'c',
        contentType: 'grammar',
        masterId: '3',
        title: 'C',
        subtitle: '',
        difficulty: 1.0,
        jlpt: 5,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await engine.registerNode(n1);
      await engine.registerNode(n2);
      await engine.registerNode(n3);

      await engine.registerRelationship(GraphRelationship(
        id: 'ab',
        sourceNodeId: 'a',
        targetNodeId: 'b',
        relationshipType: 'RELATED',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      await engine.registerRelationship(GraphRelationship(
        id: 'bc',
        sourceNodeId: 'b',
        targetNodeId: 'c',
        relationshipType: 'RELATED',
        weight: 1.0,
        strength: 1.0,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      final path = await engine.findShortestPath('a', 'c');
      expect(path.length, 3);
      expect(path[0].id, 'a');
      expect(path[1].id, 'b');
      expect(path[2].id, 'c');
    });
  });
}
