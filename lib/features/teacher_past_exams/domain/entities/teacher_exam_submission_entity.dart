class TeacherExamSubmissionAnswerEntity {
  final int answerId;
  final int? questionId;
  final String questionText;
  final String chosenOptionText;
  final String openAnswerText;
  final bool? isCorrect;
  final double? score;
  final String feedback;

  const TeacherExamSubmissionAnswerEntity({
    required this.answerId,
    required this.questionId,
    required this.questionText,
    required this.chosenOptionText,
    required this.openAnswerText,
    required this.isCorrect,
    required this.score,
    required this.feedback,
  });
}

class TeacherExamSubmissionEntity {
  final int submissionId;
  final String studentName;
  final String status;
  final List<TeacherExamSubmissionAnswerEntity> answers;

  const TeacherExamSubmissionEntity({
    required this.submissionId,
    required this.studentName,
    required this.status,
    required this.answers,
  });
}
