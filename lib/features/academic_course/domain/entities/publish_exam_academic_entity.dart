class PublishExamAcademicEntity {
  final int? academicCourseId;
  final String? academicCourseName;
  final DateTime? createdAt;
  final String? description;
  final int? durationMinutes;
  final DateTime? endsAt;
  final String? examType;
  final int? id;
  final bool? isPublished;
  final dynamic myScore;
  final String? myStatus;
  final int? passingScore;
  final int? questionCount;
  final DateTime? startsAt;
  final int? teacherId;
  final String? title;
  final int? totalMarks;

  PublishExamAcademicEntity({
    this.academicCourseId,
    this.academicCourseName,
    this.createdAt,
    this.description,
    this.durationMinutes,
    this.endsAt,
    this.examType,
    this.id,
    this.isPublished,
    this.myScore,
    this.myStatus,
    this.passingScore,
    this.questionCount,
    this.startsAt,
    this.teacherId,
    this.title,
    this.totalMarks,
  });
}
