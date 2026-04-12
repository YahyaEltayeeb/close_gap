import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'exam_finish_request.g.dart';

ExamFinishRequest examFinishRequestFromJson(String str) => ExamFinishRequest.fromJson(json.decode(str));

String examFinishRequestToJson(ExamFinishRequest data) => json.encode(data.toJson());

@JsonSerializable()
class ExamFinishRequest {
    @JsonKey(name: "exam_id")
    int? examId;

    ExamFinishRequest({
        this.examId,
    });

    factory ExamFinishRequest.fromJson(Map<String, dynamic> json) => _$ExamFinishRequestFromJson(json);

    Map<String, dynamic> toJson() => _$ExamFinishRequestToJson(this);
}
