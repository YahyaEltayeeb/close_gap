class TeacherExamQuestionOptionEntity {
  final int id;
  final int order;
  final int questionId;
  final String text;

  const TeacherExamQuestionOptionEntity({
    required this.id,
    required this.order,
    required this.questionId,
    required this.text,
  });
}

class TeacherExamQuestionEntity {
  final int correctOptionId;
  final int examId;
  final int id;
  final double marks;
  final List<TeacherExamQuestionOptionEntity> options;
  final int order;
  final String questionType;
  final String text;

  const TeacherExamQuestionEntity({
    required this.correctOptionId,
    required this.examId,
    required this.id,
    required this.marks,
    required this.options,
    required this.order,
    required this.questionType,
    required this.text,
  });
}
