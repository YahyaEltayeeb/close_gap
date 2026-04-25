class AcademicExamResultsEntity {
  final dynamic autoScore;
  final String? courseName;
  final int? examId;
  final String? examTitle;
  final String? examType;
  final dynamic finalScore;
  final int? id;
  final dynamic manualScore;
  final dynamic passed;
  final DateTime? startedAt;
  final String? status;
  final int? studentId;
  final DateTime? submittedAt;
  final dynamic teacherFeedback;

  AcademicExamResultsEntity({
    this.autoScore,
    this.courseName,
    this.examId,
    this.examTitle,
    this.examType,
    this.finalScore,
    this.id,
    this.manualScore,
    this.passed,
    this.startedAt,
    this.status,
    this.studentId,
    this.submittedAt,
    this.teacherFeedback,
  });
}
