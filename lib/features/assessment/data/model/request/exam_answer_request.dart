import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'exam_answer_request.g.dart';

ExamAnswerRequest examAnswerRequestFromJson(String str) => ExamAnswerRequest.fromJson(json.decode(str));

String examAnswerRequestToJson(ExamAnswerRequest data) => json.encode(data.toJson());

@JsonSerializable()
class ExamAnswerRequest {
    @JsonKey(name: "exam_id")
    int? examId;
    @JsonKey(name: "question_id")
    int? questionId;
    @JsonKey(name: "option_id")
    int? optionId;

    ExamAnswerRequest({
        this.examId,
        this.questionId,
        this.optionId,
    });

    factory ExamAnswerRequest.fromJson(Map<String, dynamic> json) => _$ExamAnswerRequestFromJson(json);

    Map<String, dynamic> toJson() => _$ExamAnswerRequestToJson(this);
}
