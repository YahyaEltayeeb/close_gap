class AcademicCourseEntity {
  final int id;
  final String code;
  final String name;
  final int semester;

  const AcademicCourseEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.semester,
  });

  String get displayName => '$code - $name (Sem $semester)';
}
