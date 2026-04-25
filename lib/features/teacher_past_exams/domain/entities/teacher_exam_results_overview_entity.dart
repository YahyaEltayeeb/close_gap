import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';

class TeacherExamResultStudentEntity {
  final double? finalScore;
  final bool? passed;
  final String status;
  final int studentId;
  final String studentName;
  final int submissionId;
  final String submittedAt;

  const TeacherExamResultStudentEntity({
    required this.finalScore,
    required this.passed,
    required this.status,
    required this.studentId,
    required this.studentName,
    required this.submissionId,
    required this.submittedAt,
  });

  bool get isGraded => finalScore != null || status.toLowerCase() == 'graded';
}

class TeacherExamResultsOverviewEntity {
  final TeacherExamListItemEntity exam;
  final int passedCount;
  final List<TeacherExamResultStudentEntity> results;
  final int totalSubmissions;

  const TeacherExamResultsOverviewEntity({
    required this.exam,
    required this.passedCount,
    required this.results,
    required this.totalSubmissions,
  });
}
