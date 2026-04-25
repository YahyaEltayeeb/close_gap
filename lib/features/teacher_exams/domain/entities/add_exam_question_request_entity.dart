import 'package:close_gap/features/teacher_exams/domain/entities/exam_question_option_request_entity.dart';

class AddExamQuestionRequestEntity {
  final int examId;
  final String text;
  final double marks;
  final List<ExamQuestionOptionRequestEntity> options;

  const AddExamQuestionRequestEntity({
    required this.examId,
    required this.text,
    required this.marks,
    required this.options,
  });
}
