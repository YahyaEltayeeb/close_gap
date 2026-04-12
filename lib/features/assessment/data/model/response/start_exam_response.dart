import 'package:close_gap/features/assessment/domain/entities/start_exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'start_exam_response.g.dart';

StartexamResponse startexamFromJson(String str) =>
    StartexamResponse.fromJson(json.decode(str));

String startexamToJson(StartexamResponse data) => json.encode(data.toJson());

@JsonSerializable()
class StartexamResponse {
  @JsonKey(name: "exam")
  Exam? exam;
  @JsonKey(name: "remaining_seconds")
  int? remainingSeconds;

  StartexamResponse({this.exam, this.remainingSeconds});

  factory StartexamResponse.fromJson(Map<String, dynamic> json) =>
      _$StartexamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StartexamResponseToJson(this);
}

@JsonSerializable()
class Exam {
  @JsonKey(name: "active")
  bool? active;
  @JsonKey(name: "answers")
  List<Answer>? answers;
  @JsonKey(name: "events")
  List<dynamic>? events;
  @JsonKey(name: "finished_at")
  dynamic finishedAt;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "invalidated")
  bool? invalidated;
  @JsonKey(name: "score")
  int? score;
  @JsonKey(name: "started_at")
  DateTime? startedAt;
  @JsonKey(name: "strikes")
  int? strikes;
  @JsonKey(name: "track_id")
  int? trackId;
  @JsonKey(name: "user_id")
  int? userId;

  Exam({
    this.active,
    this.answers,
    this.events,
    this.finishedAt,
    this.id,
    this.invalidated,
    this.score,
    this.startedAt,
    this.strikes,
    this.trackId,
    this.userId,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}

@JsonSerializable()
class Answer {
  @JsonKey(name: "chosen_option_id")
  int? chosenOptionId;
  @JsonKey(name: "exam_id")
  int? examId;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_correct")
  bool? isCorrect;
  @JsonKey(name: "question_id")
  int? questionId;

  Answer({
    this.chosenOptionId,
    this.examId,
    this.id,
    this.isCorrect,
    this.questionId,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

extension StartExamMapper on StartexamResponse {
  StartExamEntity toEntity() {
    return StartExamEntity(
      exam: exam?.toEntity(),
      remainingSeconds: remainingSeconds,
    );
  }
}

extension ExamMapper on Exam {
  ExamEntity toEntity() {
    return ExamEntity(
      active: active,
      answers: answers?.map((e) => e.toEntity()).toList(),
      events: events,
      finishedAt: finishedAt,
      id: id,
      invalidated: invalidated,
      score: score,
      startedAt: startedAt,
      strikes: strikes,
      trackId: trackId,
      userId: userId,
    );
  }
}

extension AnswerMapper on Answer {
  AnswerEntity toEntity() {
    return AnswerEntity(
      chosenOptionId: chosenOptionId,
      examId: examId,
      id: id,
      isCorrect: isCorrect,
      questionId: questionId,
    );
  }
}
