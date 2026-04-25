class SkillDto {
  final int? id;
  final String? name;
  final String? description;
  final int? trackId;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  const SkillDto({
    required this.id,
    required this.name,
    required this.description,
    required this.trackId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SkillDto.fromJson(Map<String, dynamic> json) {
    return SkillDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      trackId: json['track_id'] as int?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
