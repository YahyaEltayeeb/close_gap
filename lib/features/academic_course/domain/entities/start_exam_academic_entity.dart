import 'package:close_gap/features/academic_course/data/models/response/start_exam_dto.dart';

class StartExamAcademicEntity {
  final List<Question>? questions;
  final int? remainingSeconds;
  final Submission? submission;
  final int? submissionId;

  StartExamAcademicEntity({
    this.questions,
    this.remainingSeconds,
    this.submission,
    this.submissionId,
  });
}
