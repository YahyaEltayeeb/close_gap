class AcademicExamQuestionOptionEntity {
  final int id;
  final int questionId;
  final int order;
  final String text;

  const AcademicExamQuestionOptionEntity({
    required this.id,
    required this.questionId,
    required this.order,
    required this.text,
  });
}

class AcademicExamQuestionEntity {
  final int id;
  final int examId;
  final String text;
  final String questionType;
  final double marks;
  final int order;
  final int? correctOptionId;
  final List<AcademicExamQuestionOptionEntity> options;

  const AcademicExamQuestionEntity({
    required this.id,
    required this.examId,
    required this.text,
    required this.questionType,
    required this.marks,
    required this.order,
    required this.correctOptionId,
    required this.options,
  });
}
