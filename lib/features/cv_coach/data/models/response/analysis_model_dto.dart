import 'package:close_gap/features/cv_coach/data/models/response/details_analysis_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'analysis_model_dto.g.dart';

@JsonSerializable()
class AnalysisModelDto {
  @JsonKey(name: 'overall_score')
  final int overallScore;

  @JsonKey(name: 'formatting_score')
  final int formattingScore;

  @JsonKey(name: 'content_score')
  final int contentScore;

  @JsonKey(name: 'keywords_score')
  final int keywordsScore;

  @JsonKey(name: 'structure_score')
  final int structureScore;

  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> recommendations;

  @JsonKey(name: 'detailed_analysis')
  final DetailsdAnalysisDto detailsAnalysis;

  AnalysisModelDto({
    required this.overallScore,
    required this.formattingScore,
    required this.contentScore,
    required this.keywordsScore,
    required this.structureScore,
    required this.strengths,
    required this.weaknesses,
    required this.recommendations,
    required this.detailsAnalysis,
  });

  factory AnalysisModelDto.fromJson(Map<String, dynamic> json) =>
      _$AnalysisModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisModelDtoToJson(this);
}