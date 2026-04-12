import 'package:close_gap/features/assessment/domain/entities/exam_question_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'exam_questions_response.g.dart';

ExamquestionsResponse examquestionsFromJson(String str) =>
    ExamquestionsResponse.fromJson(json.decode(str));

String examquestionsToJson(ExamquestionsResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ExamquestionsResponse {
  @JsonKey(name: "level")
  Level? level;
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "questions")
  List<Question>? questions;
  @JsonKey(name: "total_questions")
  int? totalQuestions;
  @JsonKey(name: "track")
  String? track;

  ExamquestionsResponse({
    this.level,
    this.page,
    this.perPage,
    this.questions,
    this.totalQuestions,
    this.track,
  });

  factory ExamquestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamquestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamquestionsResponseToJson(this);
}

enum Level {
  @JsonValue("basic")
  BASIC,
}

final levelValues = EnumValues({"basic": Level.BASIC});

@JsonSerializable()
class Question {
  @JsonKey(name: "difficulty")
  Level? difficulty;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "options")
  List<Option>? options;
  @JsonKey(name: "text")
  String? text;

  Question({this.difficulty, this.id, this.options, this.text});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Option {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "question_id")
  int? questionId;
  @JsonKey(name: "text")
  String? text;

  Option({this.id, this.questionId, this.text});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

extension LevelMapper on Level {
  LevelEntity toEntity() {
    switch (this) {
      case Level.BASIC:
        return LevelEntity.basic;
    }
  }
}

extension OptionMapper on Option {
  OptionEntity toEntity() {
    return OptionEntity(id: id, questionId: questionId, text: text);
  }
}

extension QuestionMapper on Question {
  QuestionEntity toEntity() {
    return QuestionEntity(
      difficulty: difficulty?.toEntity(),
      id: id,
      options: options?.map((e) => e.toEntity()).toList(),
      text: text,
    );
  }
}

extension ExamQuestionsMapper on ExamquestionsResponse {
  ExamQuestionsEntity toEntity() {
    return ExamQuestionsEntity(
      level: level?.toEntity(),
      page: page,
      perPage: perPage,
      questions: questions?.map((e) => e.toEntity()).toList(),
      totalQuestions: totalQuestions,
      track: track,
    );
  }
}
