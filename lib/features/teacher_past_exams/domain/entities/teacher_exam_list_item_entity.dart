class TeacherExamListItemEntity {
  final int id;
  final int academicCourseId;
  final String academicCourseName;
  final String title;
  final String examType;
  final int durationMinutes;
  final double passingScore;
  final double totalMarks;
  final String startsAt;
  final String endsAt;
  final bool isPublished;
  final int questionCount;

  const TeacherExamListItemEntity({
    required this.id,
    required this.academicCourseId,
    required this.academicCourseName,
    required this.title,
    required this.examType,
    required this.durationMinutes,
    required this.passingScore,
    required this.totalMarks,
    required this.startsAt,
    required this.endsAt,
    required this.isPublished,
    required this.questionCount,
  });
}
