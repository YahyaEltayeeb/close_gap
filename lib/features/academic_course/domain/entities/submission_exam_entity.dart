import 'package:close_gap/features/academic_course/domain/entities/submission_entity.dart';

class SubmissionExamEntity {
  final String? message;
  final bool? ok;
  final SubmissionEntity? submission;

  SubmissionExamEntity({
    this.message,
    this.ok,
    this.submission,
  });
}


