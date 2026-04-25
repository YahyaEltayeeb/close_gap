class AddExamQuestionOptionRequestDto {
  final String text;
  final bool isCorrect;

  const AddExamQuestionOptionRequestDto({
    required this.text,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() {
    return {'text': text, 'is_correct': isCorrect};
  }
}

class AddExamQuestionRequestDto {
  final String text;
  final String questionType;
  final double marks;
  final List<AddExamQuestionOptionRequestDto> options;

  const AddExamQuestionRequestDto({
    required this.text,
    required this.questionType,
    required this.marks,
    required this.options,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'question_type': questionType,
      'marks': marks,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}
