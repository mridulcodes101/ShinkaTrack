class GraphRelationship {
  final String id;
  final String sourceNodeId;
  final String targetNodeId;
  final String relationshipType; // USES, CONTAINS, REFERENCES, REQUIRES, PREREQUISITE, SIMILAR_TO, OPPOSITE_OF, NEXT, PREVIOUS, RELATED, OPTIONAL, AI_GENERATED
  final double weight;
  final double strength;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GraphRelationship({
    required this.id,
    required this.sourceNodeId,
    required this.targetNodeId,
    required this.relationshipType,
    required this.weight,
    required this.strength,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  GraphRelationship copyWith({
    String? id,
    String? sourceNodeId,
    String? targetNodeId,
    String? relationshipType,
    double? weight,
    double? strength,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GraphRelationship(
      id: id ?? this.id,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      relationshipType: relationshipType ?? this.relationshipType,
      weight: weight ?? this.weight,
      strength: strength ?? this.strength,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
