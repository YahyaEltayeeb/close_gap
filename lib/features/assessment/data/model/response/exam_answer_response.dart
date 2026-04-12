import 'package:close_gap/features/assessment/domain/entities/exam_answer_entity%20.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'exam_answer_response.g.dart';

ExamAnswerResponse examAnswerResponseFromJson(String str) => ExamAnswerResponse.fromJson(json.decode(str));

String examAnswerResponseToJson(ExamAnswerResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ExamAnswerResponse {
    @JsonKey(name: "is_correct")
    bool? isCorrect;
    @JsonKey(name: "ok")
    bool? ok;
    @JsonKey(name: "remaining_seconds")
    int? remainingSeconds;

    ExamAnswerResponse({
        this.isCorrect,
        this.ok,
        this.remainingSeconds,
    });

    factory ExamAnswerResponse.fromJson(Map<String, dynamic> json) => _$ExamAnswerResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ExamAnswerResponseToJson(this);
}
extension ExamAnswerResponseMapper on ExamAnswerResponse {
  ExamAnswerEntity toEntity() {
    return ExamAnswerEntity(
      isCorrect: isCorrect,
      ok: ok,
      remainingSeconds: remainingSeconds,
    );
  }
}