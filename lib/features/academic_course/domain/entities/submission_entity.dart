class SubmissionEntity {
  final dynamic autoScore;
  final int? examId;
  final dynamic finalScore;
  final int? id;
  final dynamic manualScore;
  final dynamic passed;
  final DateTime? startedAt;
  final String? status;
  final int? studentId;
  final dynamic submittedAt;
  final dynamic teacherFeedback;

  SubmissionEntity({
    this.autoScore,
    this.examId,
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
