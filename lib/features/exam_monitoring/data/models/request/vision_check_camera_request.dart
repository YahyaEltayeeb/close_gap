import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'vision_check_camera_request.g.dart';

VisionCheckCameraRequest visionCheckCameraRequestFromJson(String str) => VisionCheckCameraRequest.fromJson(json.decode(str));

String visionCheckCameraRequestToJson(VisionCheckCameraRequest data) => json.encode(data.toJson());

@JsonSerializable()
class VisionCheckCameraRequest {
    @JsonKey(name: "exam_id")
    int? examId;
    @JsonKey(name: "image")
    String? image;

    VisionCheckCameraRequest({
        this.examId,
        this.image,
    });

    factory VisionCheckCameraRequest.fromJson(Map<String, dynamic> json) => _$VisionCheckCameraRequestFromJson(json);

    Map<String, dynamic> toJson() => _$VisionCheckCameraRequestToJson(this);
}
