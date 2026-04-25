class UserModelLoginEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final int? trackId;
  final String? trackName;
  final int? year;
  final int? currentSemester;
  final String? pathType;
  final int? universityId;
  final String? universityName;
  final int? facultyId;
  final String? facultyName;
  final int? departmentId;
  final String? departmentName;
  final List<String> skills;
  final List<dynamic> exams;

  UserModelLoginEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.trackId,
    required this.trackName,
    required this.year,
    required this.currentSemester,
    required this.pathType,
    required this.universityId,
    required this.universityName,
    required this.facultyId,
    required this.facultyName,
    required this.departmentId,
    required this.departmentName,
    required this.skills,
    required this.exams,
  });
}
