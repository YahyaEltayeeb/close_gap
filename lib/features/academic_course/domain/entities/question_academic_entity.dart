
import 'package:close_gap/features/academic_course/data/models/response/start_exam_dto.dart';

class QuestionAcademicEntity {
  final int? examId;
  final int? id;
  final double? marks;
  final int? order;
  final String? questionType;
  final String? text;
  final List<OptionDto>? options;

  QuestionAcademicEntity({
    this.order,
    this.questionType,
    this.text,
    this.examId,
    this.id,
    this.marks,
    this.options,
  });
}
