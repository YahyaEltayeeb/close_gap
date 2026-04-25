class CreateExamRequestEntity {
  final int academicCourseId;
  final String title;
  final String examType;
  final int durationMinutes;
  final double passingScore;
  final double totalMarks;
  final String startsAt;
  final String endsAt;

  const CreateExamRequestEntity({
    required this.academicCourseId,
    required this.title,
    required this.examType,
    required this.durationMinutes,
    required this.passingScore,
    required this.totalMarks,
    required this.startsAt,
    required this.endsAt,
  });
}
