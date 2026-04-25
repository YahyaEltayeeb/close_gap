class AcademicExamQuestionOptionDto {
  final int? id;
  final int? order;
  final int? questionId;
  final String? text;

  const AcademicExamQuestionOptionDto({
    required this.id,
    required this.order,
    required this.questionId,
    required this.text,
  });

  factory AcademicExamQuestionOptionDto.fromJson(Map<String, dynamic> json) {
    return AcademicExamQuestionOptionDto(
      id: json['id'] as int?,
      order: json['order'] as int?,
      questionId: json['question_id'] as int?,
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'order': order, 'question_id': questionId, 'text': text};
  }
}

class AcademicExamQuestionDto {
  final int? id;
  final int? examId;
  final String? text;
  final String? questionType;
  final double? marks;
  final int? order;
  final int? correctOptionId;
  final List<AcademicExamQuestionOptionDto> options;

  const AcademicExamQuestionDto({
    required this.id,
    required this.examId,
    required this.text,
    required this.questionType,
    required this.marks,
    required this.order,
    required this.correctOptionId,
    required this.options,
  });

  factory AcademicExamQuestionDto.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'] as List<dynamic>? ?? const [];

    return AcademicExamQuestionDto(
      id: json['id'] as int?,
      examId: json['exam_id'] as int?,
      text: json['text'] as String?,
      questionType: json['question_type'] as String?,
      marks: (json['marks'] as num?)?.toDouble(),
      order: json['order'] as int?,
      correctOptionId: json['correct_option_id'] as int?,
      options: rawOptions
          .map(
            (option) => AcademicExamQuestionOptionDto.fromJson(
              option as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam_id': examId,
      'text': text,
      'question_type': questionType,
      'marks': marks,
      'order': order,
      'correct_option_id': correctOptionId,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

class AddExamQuestionResponseDto {
  final bool ok;
  final AcademicExamQuestionDto question;

  const AddExamQuestionResponseDto({required this.ok, required this.question});

  factory AddExamQuestionResponseDto.fromJson(Map<String, dynamic> json) {
    return AddExamQuestionResponseDto(
      ok: json['ok'] as bool? ?? false,
      question: AcademicExamQuestionDto.fromJson(
        json['question'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'ok': ok, 'question': question.toJson()};
  }
}
