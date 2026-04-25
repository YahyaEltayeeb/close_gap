class AcademicExamEntity {
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

  const AcademicExamEntity({
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

  AcademicExamEntity copyWith({
    int? id,
    int? academicCourseId,
    String? academicCourseName,
    String? title,
    String? examType,
    int? durationMinutes,
    double? passingScore,
    double? totalMarks,
    String? startsAt,
    String? endsAt,
    bool? isPublished,
    int? questionCount,
  }) {
    return AcademicExamEntity(
      id: id ?? this.id,
      academicCourseId: academicCourseId ?? this.academicCourseId,
      academicCourseName: academicCourseName ?? this.academicCourseName,
      title: title ?? this.title,
      examType: examType ?? this.examType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      passingScore: passingScore ?? this.passingScore,
      totalMarks: totalMarks ?? this.totalMarks,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      isPublished: isPublished ?? this.isPublished,
      questionCount: questionCount ?? this.questionCount,
    );
  }
}
