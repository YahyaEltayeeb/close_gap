class AcademicCourseDto {
  final int? id;
  final String? code;
  final String? name;
  final int? semester;

  const AcademicCourseDto({
    required this.id,
    required this.code,
    required this.name,
    required this.semester,
  });

  factory AcademicCourseDto.fromJson(Map<String, dynamic> json) {
    return AcademicCourseDto(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      semester: json['semester'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name, 'semester': semester};
  }
}
