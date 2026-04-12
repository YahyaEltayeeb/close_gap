
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'exam_finish_response.g.dart';

ExamFinishResponse examFinishResponseFromJson(String str) => ExamFinishResponse.fromJson(json.decode(str));

String examFinishResponseToJson(ExamFinishResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ExamFinishResponse {
    @JsonKey(name: "correct_answers")
    int? correctAnswers;
    @JsonKey(name: "invalidated")
    bool? invalidated;
    @JsonKey(name: "score")
    int? score;
    @JsonKey(name: "total_questions")
    int? totalQuestions;
    @JsonKey(name: "wrong_answers")
    int? wrongAnswers;

    ExamFinishResponse({
        this.correctAnswers,
        this.invalidated,
        this.score,
        this.totalQuestions,
        this.wrongAnswers,
    });

    factory ExamFinishResponse.fromJson(Map<String, dynamic> json) => _$ExamFinishResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ExamFinishResponseToJson(this);
}
extension ExamFinishResponseMapper on ExamFinishResponse {
  ExamFinishEntity toEntity() {
    return ExamFinishEntity(
      correctAnswers: correctAnswers,
      invalidated: invalidated,
      score: score,
      totalQuestions: totalQuestions,
      wrongAnswers: wrongAnswers,
    );
  }
}