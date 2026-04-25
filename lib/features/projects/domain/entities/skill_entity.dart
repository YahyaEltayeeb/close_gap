class SkillEntity {
  final int id;
  final String name;
  final String? description;
  final int? trackId;
  final String type;

  const SkillEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.trackId,
    required this.type,
  });
}
