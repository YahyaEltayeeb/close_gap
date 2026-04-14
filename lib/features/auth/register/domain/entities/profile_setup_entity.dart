class ProfileSetupEntity {
  final int universityId;
  final int facultyId;
  final int departmentId;
  final int targetTrackId;
  final int year;
  final int currentSemester;
  final String pathType;

  const ProfileSetupEntity({
    required this.universityId,
    required this.facultyId,
    required this.departmentId,
    required this.targetTrackId,
    required this.year,
    required this.currentSemester,
    this.pathType = 'student',
  });
}
