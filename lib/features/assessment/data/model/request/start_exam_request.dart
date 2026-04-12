import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'start_exam_request.g.dart';

StartExamRequest startExamRequestFromJson(String str) => StartExamRequest.fromJson(json.decode(str));

String startExamRequestToJson(StartExamRequest data) => json.encode(data.toJson());

@JsonSerializable()
class StartExamRequest {
    @JsonKey(name: "track_id")
    int? trackId;

    StartExamRequest({
        this.trackId,
    });

    factory StartExamRequest.fromJson(Map<String, dynamic> json) => _$StartExamRequestFromJson(json);

    Map<String, dynamic> toJson() => _$StartExamRequestToJson(this);
}
