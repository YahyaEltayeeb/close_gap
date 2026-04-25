import 'package:close_gap/features/academic_course/domain/entities/explanation_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'explanation_dto.g.dart';

@JsonSerializable()
class ExplanationDto {
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_free")
  bool? isFree;
  @JsonKey(name: "quality_score")
  double? qualityScore;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "url")
  String? url;

  ExplanationDto({
    this.description,
    this.id,
    this.isFree,
    this.qualityScore,
    this.title,
    this.url,
  });

  factory ExplanationDto.fromJson(Map<String, dynamic> json) =>
      _$ExplanationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExplanationDtoToJson(this);
  ExplanationEntity toEntity() {
    return ExplanationEntity(
      description: description,
      id: id,
      isFree: isFree,
      qualityScore: qualityScore,
      title: title,
      url: url,
    );
  }
}
