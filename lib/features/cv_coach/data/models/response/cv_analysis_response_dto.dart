import 'package:close_gap/features/cv_coach/data/models/response/analysis_model_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cv_analysis_response_dto.g.dart';

@JsonSerializable()
class CvAnalysisResponseDto {
  final String message;
  final String filename;
  final AnalysisModelDto analysis;

  CvAnalysisResponseDto({
    required this.message,
    required this.filename,
    required this.analysis,
  });

  factory CvAnalysisResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CvAnalysisResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CvAnalysisResponseDtoToJson(this);
}