class TeacherExamQuestionOptionDto {
  final int? id;
  final int? order;
  final int? questionId;
  final String? text;

  const TeacherExamQuestionOptionDto({
    required this.id,
    required this.order,
    required this.questionId,
    required this.text,
  });

  factory TeacherExamQuestionOptionDto.fromJson(Map<String, dynamic> json) {
    return TeacherExamQuestionOptionDto(
      id: json['id'] as int?,
      order: json['order'] as int?,
      questionId: json['question_id'] as int?,
      text: json['text'] as String?,
    );
  }
}

class TeacherExamQuestionDto {
  final int? correctOptionId;
  final int? examId;
  final int? id;
  final double? marks;
  final List<TeacherExamQuestionOptionDto>? options;
  final int? order;
  final String? questionType;
  final String? text;

  const TeacherExamQuestionDto({
    required this.correctOptionId,
    required this.examId,
    required this.id,
    required this.marks,
    required this.options,
    required this.order,
    required this.questionType,
    required this.text,
  });

  factory TeacherExamQuestionDto.fromJson(Map<String, dynamic> json) {
    return TeacherExamQuestionDto(
      correctOptionId: json['correct_option_id'] as int?,
      examId: json['exam_id'] as int?,
      id: json['id'] as int?,
      marks: (json['marks'] as num?)?.toDouble(),
      options: (json['options'] as List<dynamic>?)
          ?.map(
            (option) => TeacherExamQuestionOptionDto.fromJson(
              option as Map<String, dynamic>,
            ),
          )
          .toList(),
      order: json['order'] as int?,
      questionType: json['question_type'] as String?,
      text: json['text'] as String?,
    );
  }
}
