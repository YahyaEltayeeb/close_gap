class CreateExamRequestDto {
  final int academicCourseId;
  final String title;
  final String examType;
  final int durationMinutes;
  final double passingScore;
  final double totalMarks;
  final String startsAt;
  final String endsAt;

  const CreateExamRequestDto({
    required this.academicCourseId,
    required this.title,
    required this.examType,
    required this.durationMinutes,
    required this.passingScore,
    required this.totalMarks,
    required this.startsAt,
    required this.endsAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'academic_course_id': academicCourseId,
      'title': title,
      'exam_type': examType,
      'duration_minutes': durationMinutes,
      'passing_score': passingScore,
      'total_marks': totalMarks,
      'starts_at': startsAt,
      'ends_at': endsAt,
    };
  }
}
