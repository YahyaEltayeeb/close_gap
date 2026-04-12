import 'package:close_gap/features/exam_monitoring/domain/entities/vision_check_camera_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'vision_check_camera_response.g.dart';

VisionCheckCameraResponse visionCheckCameraResponseFromJson(String str) => VisionCheckCameraResponse.fromJson(json.decode(str));

String visionCheckCameraResponseToJson(VisionCheckCameraResponse data) => json.encode(data.toJson());

@JsonSerializable()
class VisionCheckCameraResponse {
    @JsonKey(name: "invalidated")
    bool? invalidated;
    @JsonKey(name: "ok")
    bool? ok;
    @JsonKey(name: "result")
    Result? result;
    @JsonKey(name: "strikes")
    int? strikes;

    VisionCheckCameraResponse({
        this.invalidated,
        this.ok,
        this.result,
        this.strikes,
    });

    factory VisionCheckCameraResponse.fromJson(Map<String, dynamic> json) => _$VisionCheckCameraResponseFromJson(json);

    Map<String, dynamic> toJson() => _$VisionCheckCameraResponseToJson(this);
}

@JsonSerializable()
@JsonSerializable()
@JsonSerializable()
class Result {
  @JsonKey(name: "phone_detected")
  final bool? phoneDetected;

  @JsonKey(name: "eye_contact")
  final bool? eyeContact;

  Result({this.phoneDetected, this.eyeContact});

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

extension VisionCheckCameraMapper on VisionCheckCameraResponse {
  VisionCheckCameraEntity toEntity() {
    return VisionCheckCameraEntity(
      invalidated: invalidated,
      ok: ok,
      result: result?.toEntity(),
      strikes: strikes,
    );
  }
}

extension ResultMapper on Result {
  ResultEntity toEntity() {
    return  ResultEntity(phoneDetected: phoneDetected,);
  }
}