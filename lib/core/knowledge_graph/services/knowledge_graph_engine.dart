import 'dart:collection';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_node.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_relationship.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/repositories/graph_repository.dart';

class KnowledgeGraphEngine {
  final GraphRepository repository;
  
  // Cache architecture
  final Map<String, GraphNode> _nodeCache = {};
  final Map<String, List<GraphRelationship>> _relationshipCache = {};

  KnowledgeGraphEngine(this.repository);

  // Clear caches
  void clearCaches() {
    _nodeCache.clear();
    _relationshipCache.clear();
  }

  // Register Nodes
  Future<void> registerNode(GraphNode node) async {
    // 1. Validation: Prevent duplicate nodes in DB or invalid types
    final existing = await repository.getNode(node.id);
    if (existing != null) {
      throw ArgumentError('Node with ID ${node.id} already exists.');
    }

    final validTypes = [
      'kanji', 'vocab', 'grammar', 'reading', 'listening', 
      'review', 'planner', 'achievement', 'dictionary', 'writing', 'speaking'
    ];
    if (!validTypes.contains(node.contentType.toLowerCase())) {
      throw ArgumentError('Invalid content type: ${node.contentType}');
    }

    await repository.saveNode(node);
    _nodeCache[node.id] = node;
  }

  // Register Relationships
  Future<void> registerRelationship(GraphRelationship relationship) async {
    // 1. Validation: Circular self-links
    if (relationship.sourceNodeId == relationship.targetNodeId) {
      throw ArgumentError('Circular self-links are not allowed.');
    }

    // 2. Validation: Broken references
    final sourceNode = await repository.getNode(relationship.sourceNodeId);
    final targetNode = await repository.getNode(relationship.targetNodeId);
    if (sourceNode == null) {
      throw ArgumentError('Source Node with ID ${relationship.sourceNodeId} does not exist.');
    }
    if (targetNode == null) {
      throw ArgumentError('Target Node with ID ${relationship.targetNodeId} does not exist.');
    }

    // 3. Validation: Duplicate relationships
    final outwards = await repository.getOutwardRelationships(relationship.sourceNodeId);
    final isDuplicate = outwards.any((r) => 
      r.targetNodeId == relationship.targetNodeId && 
      r.relationshipType == relationship.relationshipType
    );
    if (isDuplicate) {
      throw ArgumentError('Duplicate relationship already exists.');
    }

    // 4. Validation: Invalid relationship types
    final validTypes = [
      'USES', 'CONTAINS', 'REFERENCES', 'REQUIRES', 'PREREQUISITE', 
      'SIMILAR_TO', 'OPPOSITE_OF', 'NEXT', 'PREVIOUS', 'RELATED', 'OPTIONAL', 'AI_GENERATED'
    ];
    if (!validTypes.contains(relationship.relationshipType.toUpperCase())) {
      throw ArgumentError('Invalid relationship type: ${relationship.relationshipType}');
    }

    // 5. Validation: Cycle check for dependencies (PREREQUISITE / REQUIRES)
    if (relationship.relationshipType == 'PREREQUISITE' || relationship.relationshipType == 'REQUIRES') {
      final hasCycle = await _detectCycle(relationship.targetNodeId, relationship.sourceNodeId);
      if (hasCycle) {
        throw ArgumentError('Registering this relationship would introduce a circular dependency.');
      }
    }

    await repository.saveRelationship(relationship);
    
    // Invalidate caches
    _relationshipCache.remove(relationship.sourceNodeId);
    _relationshipCache.remove(relationship.targetNodeId);
  }

  // BFS search starting from startNode to find targetNode (detect cycle)
  Future<bool> _detectCycle(String startNodeId, String targetNodeId) async {
    final visited = <String>{};
    final queue = Queue<String>()..add(startNodeId);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (current == targetNodeId) return true;

      if (!visited.contains(current)) {
        visited.add(current);
        final outwards = await repository.getOutwardRelationships(current);
        for (var r in outwards) {
          if (r.relationshipType == 'PREREQUISITE' || r.relationshipType == 'REQUIRES') {
            queue.add(r.targetNodeId);
          }
        }
      }
    }
    return false;
  }

  // Get Related Nodes
  Future<List<GraphNode>> getRelatedNodes(String nodeId) async {
    final relationships = await repository.getOutwardRelationships(nodeId);
    final List<GraphNode> nodes = [];
    for (var r in relationships) {
      final node = await repository.getNode(r.targetNodeId);
      if (node != null) {
        nodes.add(node);
      }
    }
    return nodes;
  }

  // Get Connected Vocabulary using Kanji
  Future<List<GraphNode>> getConnectedVocabulary(String kanjiNodeId) async {
    final relations = await repository.getOutwardRelationships(kanjiNodeId);
    final List<GraphNode> nodes = [];
    for (var r in relations) {
      if (r.relationshipType == 'USES' || r.relationshipType == 'CONTAINS') {
        final node = await repository.getNode(r.targetNodeId);
        if (node != null && node.contentType == 'vocab') {
          nodes.add(node);
        }
      }
    }
    return nodes;
  }

  // Get Connected Grammar from Vocabulary
  Future<List<GraphNode>> getConnectedGrammar(String vocabNodeId) async {
    final relations = await repository.getOutwardRelationships(vocabNodeId);
    final List<GraphNode> nodes = [];
    for (var r in relations) {
      if (r.relationshipType == 'REFERENCES' || r.relationshipType == 'RELATED') {
        final node = await repository.getNode(r.targetNodeId);
        if (node != null && node.contentType == 'grammar') {
          nodes.add(node);
        }
      }
    }
    return nodes;
  }

  // Get Connected Reading containing Grammar
  Future<List<GraphNode>> getConnectedReading(String grammarNodeId) async {
    final relations = await repository.getInwardRelationships(grammarNodeId);
    final List<GraphNode> nodes = [];
    for (var r in relations) {
      if (r.relationshipType == 'CONTAINS' || r.relationshipType == 'REFERENCES') {
        final node = await repository.getNode(r.sourceNodeId);
        if (node != null && node.contentType == 'reading') {
          nodes.add(node);
        }
      }
    }
    return nodes;
  }

  // Get Connected Listening containing Vocabulary
  Future<List<GraphNode>> getConnectedListening(String vocabNodeId) async {
    final relations = await repository.getInwardRelationships(vocabNodeId);
    final List<GraphNode> nodes = [];
    for (var r in relations) {
      if (r.relationshipType == 'CONTAINS' || r.relationshipType == 'REFERENCES') {
        final node = await repository.getNode(r.sourceNodeId);
        if (node != null && node.contentType == 'listening') {
          nodes.add(node);
        }
      }
    }
    return nodes;
  }

  // Get all connected contents recursively
  Future<List<GraphNode>> getAllConnectedContent(String nodeId) async {
    final visited = <String>{};
    final List<GraphNode> connected = [];
    final queue = Queue<String>()..add(nodeId);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (current != nodeId && !visited.contains(current)) {
        visited.add(current);
        final node = await repository.getNode(current);
        if (node != null) connected.add(node);
      }

      final outwards = await repository.getOutwardRelationships(current);
      for (var r in outwards) {
        if (!visited.contains(r.targetNodeId)) {
          queue.add(r.targetNodeId);
        }
      }

      final inwards = await repository.getInwardRelationships(current);
      for (var r in inwards) {
        if (!visited.contains(r.sourceNodeId)) {
          queue.add(r.sourceNodeId);
        }
      }
    }
    return connected;
  }

  // Get Learning Path (Topological prerequisite sorting)
  Future<List<GraphNode>> getLearningPath(String targetNodeId) async {
    final path = <GraphNode>[];
    final visited = <String>{};

    Future<void> dfs(String currentId) async {
      visited.add(currentId);
      final inwards = await repository.getInwardRelationships(currentId);
      for (var r in inwards) {
        if (r.relationshipType == 'PREREQUISITE' || r.relationshipType == 'REQUIRES') {
          if (!visited.contains(r.sourceNodeId)) {
            await dfs(r.sourceNodeId);
          }
        }
      }
      final node = await repository.getNode(currentId);
      if (node != null) {
        path.add(node);
      }
    }

    await dfs(targetNodeId);
    return path;
  }

  // Find Shortest Path using BFS
  Future<List<GraphNode>> findShortestPath(String startNodeId, String endNodeId) async {
    if (startNodeId == endNodeId) {
      final node = await repository.getNode(startNodeId);
      return node != null ? [node] : [];
    }

    final parentMap = <String, String>{};
    final queue = Queue<String>()..add(startNodeId);
    final visited = <String>{startNodeId};

    bool found = false;
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (current == endNodeId) {
        found = true;
        break;
      }

      final outwards = await repository.getOutwardRelationships(current);
      for (var r in outwards) {
        if (!visited.contains(r.targetNodeId)) {
          visited.add(r.targetNodeId);
          parentMap[r.targetNodeId] = current;
          queue.add(r.targetNodeId);
        }
      }
    }

    if (!found) return [];

    final pathIds = <String>[];
    String? current = endNodeId;
    while (current != null) {
      pathIds.add(current);
      current = parentMap[current];
    }

    final List<GraphNode> pathNodes = [];
    for (var id in pathIds.reversed) {
      final node = await repository.getNode(id);
      if (node != null) {
        pathNodes.add(node);
      }
    }
    return pathNodes;
  }

  // Find Strongest Relationships sorted by weight/strength descending
  Future<List<GraphRelationship>> findStrongestRelationships(String nodeId, {int limit = 5}) async {
    final outwards = await repository.getOutwardRelationships(nodeId);
    outwards.sort((a, b) => b.strength.compareTo(a.strength));
    return outwards.take(limit).toList();
  }

  // Stubs for future AI / Recommendation engine extensions
  Future<List<GraphNode>> getSmartRecommendations(String userProfileId) async {
    // Stub to be implemented in future sittings
    return [];
  }
}
