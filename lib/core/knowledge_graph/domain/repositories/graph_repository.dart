import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_node.dart';
import 'package:shinka_track_n3/core/knowledge_graph/domain/models/graph_relationship.dart';

abstract class GraphRepository {
  Future<void> saveNode(GraphNode node);
  Future<GraphNode?> getNode(String id);
  Future<GraphNode?> getNodeByMaster(String masterId, String contentType);
  Future<List<GraphNode>> getAllNodes();
  
  Future<void> saveRelationship(GraphRelationship relationship);
  Future<GraphRelationship?> getRelationship(String id);
  Future<List<GraphRelationship>> getOutwardRelationships(String sourceNodeId);
  Future<List<GraphRelationship>> getInwardRelationships(String targetNodeId);
  Future<List<GraphRelationship>> getRelationshipsByType(String type);
  Future<List<GraphRelationship>> getAllRelationships();
  
  Future<void> deleteNode(String id);
  Future<void> deleteRelationship(String id);
}
