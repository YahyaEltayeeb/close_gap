import 'package:close_gap/features/academic_course/domain/entities/academic_exam_results_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'academic_exam_results_dto.g.dart';

@JsonSerializable()
class AcademicExamResultsDto {
  @JsonKey(name: "auto_score")
  dynamic autoScore;
  @JsonKey(name: "course_name")
  String? courseName;
  @JsonKey(name: "exam_id")
  int? examId;
  @JsonKey(name: "exam_title")
  String? examTitle;
  @JsonKey(name: "exam_type")
  String? examType;
  @JsonKey(name: "final_score")
  dynamic finalScore;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "manual_score")
  dynamic manualScore;
  @JsonKey(name: "passed")
  dynamic passed;
  @JsonKey(name: "started_at")
  DateTime? startedAt;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "student_id")
  int? studentId;
  @JsonKey(name: "submitted_at")
  DateTime? submittedAt;
  @JsonKey(name: "teacher_feedback")
  dynamic teacherFeedback;

  AcademicExamResultsDto({
    this.autoScore,
    this.courseName,
    this.examId,
    this.examTitle,
    this.examType,
    this.finalScore,
    this.id,
    this.manualScore,
    this.passed,
    this.startedAt,
    this.status,
    this.studentId,
    this.submittedAt,
    this.teacherFeedback,
  });

  factory AcademicExamResultsDto.fromJson(Map<String, dynamic> json) =>
      _$AcademicExamResultsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicExamResultsDtoToJson(this);

  AcademicExamResultsEntity toEntity() {
    return AcademicExamResultsEntity(
      autoScore: autoScore,
      courseName: courseName,
      examId: examId,
      examTitle: examTitle,
      examType: examType,
      finalScore: finalScore,
      id: id,
      manualScore: manualScore,
      passed: passed,
      startedAt: startedAt,
      status: status,
      studentId: studentId,
      submittedAt: submittedAt,
      teacherFeedback: teacherFeedback,
    );
  }
}
