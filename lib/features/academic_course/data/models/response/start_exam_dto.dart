import 'package:close_gap/features/academic_course/domain/entities/option_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/question_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/start_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/submission_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_exam_dto.g.dart';

@JsonSerializable()
class StartExamDto {
  @JsonKey(name: "questions")
  List<Question>? questions;
  @JsonKey(name: "remaining_seconds")
  int? remainingSeconds;
  @JsonKey(name: "submission")
  Submission? submission;
  @JsonKey(name: "submission_id")
  int? submissionId;

  StartExamDto({
    this.questions,
    this.remainingSeconds,
    this.submission,
    this.submissionId,
  });

  factory StartExamDto.fromJson(Map<String, dynamic> json) =>
      _$StartExamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StartExamDtoToJson(this);
  StartExamAcademicEntity toEntity() {
    return StartExamAcademicEntity(
      questions: questions,
      remainingSeconds: remainingSeconds,
      submission: submission,
      submissionId: submissionId,
    );
  }
}

@JsonSerializable()
class Question {
  @JsonKey(name: "exam_id")
  int? examId;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "marks")
  double? marks;
  @JsonKey(name: "options")
  List<OptionDto>? options;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "question_type")
  String? questionType;
  @JsonKey(name: "text")
  String? text;

  Question({
    this.examId,
    this.id,
    this.marks,
    this.options,
    this.order,
    this.questionType,
    this.text,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
  QuestionAcademicEntity toEntity() {
    return QuestionAcademicEntity(
      examId: examId,
      id: id,
      marks: marks,
      options: options,
      order: order,
      questionType: questionType,
      text: text,
    );
  }
}

@JsonSerializable()
class OptionDto {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "question_id")
  int? questionId;
  @JsonKey(name: "text")
  String? text;

  OptionDto({this.id, this.order, this.questionId, this.text});

  factory OptionDto.fromJson(Map<String, dynamic> json) => _$OptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OptionDtoToJson(this);
  OptionAcademicEntity toEntity() {
    return OptionAcademicEntity(
      id: id,
      order: order,
      questionId: questionId,
      text: text,
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
  dynamic submittedAt;
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
