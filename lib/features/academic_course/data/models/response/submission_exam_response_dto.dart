import 'package:close_gap/features/academic_course/domain/entities/submission_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/submission_exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submission_exam_response_dto.g.dart';

@JsonSerializable()
class SubmissionExamResponseDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "ok")
  bool? ok;

  @JsonKey(name: "submission")
  Submission? submission;

  SubmissionExamResponseDto({
    this.message,
    this.ok,
    this.submission,
  });

  factory SubmissionExamResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SubmissionExamResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionExamResponseDtoToJson(this);

  SubmissionExamEntity toEntity() {
    return SubmissionExamEntity(
      message: message,
      ok: ok,
      submission: submission?.toEntity(),
    );
  }
}

@JsonSerializable()
class Submission {
  @JsonKey(name: "auto_score")
  dynamic autoScore;

  @JsonKey(name: "exam_id")
  int? examId;

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

  Submission({
    this.autoScore,
    this.examId,
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

  factory Submission.fromJson(Map<String, dynamic> json) =>
      _$SubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionToJson(this);

  SubmissionEntity toEntity() {
    return SubmissionEntity(
      autoScore: autoScore,
      examId: examId,
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