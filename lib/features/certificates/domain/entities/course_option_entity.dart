class CourseOptionEntity {
  const CourseOptionEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.semester,
  });

  final int id;
  final String name;
  final String? code;
  final int? semester;
}
