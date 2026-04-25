class TeacherExamSubmissionAnswerDto {
  final int? answerId;
  final int? questionId;
  final String? questionText;
  final String? chosenOptionText;
  final String? openAnswerText;
  final bool? isCorrect;
  final double? score;
  final String? feedback;

  const TeacherExamSubmissionAnswerDto({
    required this.answerId,
    required this.questionId,
    required this.questionText,
    required this.chosenOptionText,
    required this.openAnswerText,
    required this.isCorrect,
    required this.score,
    required this.feedback,
  });

  factory TeacherExamSubmissionAnswerDto.fromJson(Map<String, dynamic> json) {
    return TeacherExamSubmissionAnswerDto(
      answerId: json['answer_id'] as int?,
      questionId: json['question_id'] as int?,
      questionText: json['question_text'] as String?,
      chosenOptionText: json['chosen_option_text'] as String?,
      openAnswerText:
          json['open_answer_text'] as String? ?? json['answer_text'] as String?,
      isCorrect: json['is_correct'] as bool?,
      score: (json['score'] as num?)?.toDouble(),
      feedback: json['feedback'] as String?,
    );
  }
}

class TeacherExamSubmissionDto {
  final int? submissionId;
  final String? studentName;
  final String? status;
  final List<TeacherExamSubmissionAnswerDto>? answers;

  const TeacherExamSubmissionDto({
    required this.submissionId,
    required this.studentName,
    required this.status,
    required this.answers,
  });

  factory TeacherExamSubmissionDto.fromJson(Map<String, dynamic> json) {
    return TeacherExamSubmissionDto(
      submissionId: json['submission_id'] as int?,
      studentName: json['student_name'] as String?,
      status: json['status'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map(
            (answer) => TeacherExamSubmissionAnswerDto.fromJson(
              answer as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

class TeacherExamSubmissionsResponseDto {
  final List<TeacherExamSubmissionDto>? submissions;
  final int? total;
  final int? page;
  final int? perPage;
  final int? pages;

  const TeacherExamSubmissionsResponseDto({
    required this.submissions,
    required this.total,
    required this.page,
    required this.perPage,
    required this.pages,
  });

  factory TeacherExamSubmissionsResponseDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return TeacherExamSubmissionsResponseDto(
      submissions: (json['submissions'] as List<dynamic>?)
          ?.map(
            (submission) => TeacherExamSubmissionDto.fromJson(
              submission as Map<String, dynamic>,
            ),
          )
          .toList(),
      total: json['total'] as int?,
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
      pages: json['pages'] as int?,
    );
  }
}
