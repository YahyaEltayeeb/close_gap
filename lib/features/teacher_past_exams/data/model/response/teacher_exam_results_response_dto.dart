import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_list_item_dto.dart';

class TeacherExamResultStudentDto {
  final double? finalScore;
  final bool? passed;
  final String? status;
  final int? studentId;
  final String? studentName;
  final int? submissionId;
  final String? submittedAt;

  const TeacherExamResultStudentDto({
    required this.finalScore,
    required this.passed,
    required this.status,
    required this.studentId,
    required this.studentName,
    required this.submissionId,
    required this.submittedAt,
  });

  factory TeacherExamResultStudentDto.fromJson(Map<String, dynamic> json) {
    return TeacherExamResultStudentDto(
      finalScore: (json['final_score'] as num?)?.toDouble(),
      passed: json['passed'] as bool?,
      status: json['status'] as String?,
      studentId: json['student_id'] as int?,
      studentName: json['student_name'] as String?,
      submissionId: json['submission_id'] as int?,
      submittedAt: json['submitted_at'] as String?,
    );
  }
}

class TeacherExamResultsResponseDto {
  final TeacherExamListItemDto exam;
  final int? passedCount;
  final List<TeacherExamResultStudentDto>? results;
  final int? totalSubmissions;

  const TeacherExamResultsResponseDto({
    required this.exam,
    required this.passedCount,
    required this.results,
    required this.totalSubmissions,
  });

  factory TeacherExamResultsResponseDto.fromJson(Map<String, dynamic> json) {
    return TeacherExamResultsResponseDto(
      exam: TeacherExamListItemDto.fromJson(
        json['exam'] as Map<String, dynamic>,
      ),
      passedCount: json['passed_count'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map(
            (item) => TeacherExamResultStudentDto.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      totalSubmissions: json['total_submissions'] as int?,
    );
  }
}
